//
//  NnFireReader.swift
//  
//
//  Created by Nikolai Nobadi on 2/11/22.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class NnFireReader {
    
    private var listeners = [FireListener]()

    deinit {
        removeAllListeners()
    }
}
    

// MARK: - Reader
extension NnFireReader: NnReader {
    
    func removeListener(tag: Int) {
        if let index = listeners.firstIndex(where: { $0.tag == tag }) {
            listeners[index].removeListener()
            listeners.remove(at: index)
        }
    }
    
    func removeAllListeners() {
        listeners.forEach { $0.removeListener() }
        listeners = []
    }
    
    
    // MARK: Single Read
    func singleRead<T: Decodable>(info: FireEndpointInfo,
                                  completion: @escaping FireSingleCompletion<T>) {
        do {
            try fetchSingleDocument(
                info: info,
                completion: decodeSingleResponse(disableOffline: info.disableOffline, completion: completion))
        } catch {
            completion(.failure(FireErrorConverter.convertError(error)))
        }
    }
    
    func fetchSingleDocument(info: FireEndpointInfo,
                             completion: @escaping FIRDocumentSnapshotBlock) throws {

        guard let ref = FireRefFactory.makeDocRef(info) else {
            throw NSError(domain: "Test", code: 0)
        }

        guard info.listen else {
            return ref.getDocument(completion: completion)
        }

        listeners.append(
            FireListener(ref.addSnapshotListener(includeMetadataChanges: true,
                                                 listener: completion))
        )
    }
    
    func decodeSingleResponse<T>(disableOffline: Bool,
                                 completion: @escaping FireSingleCompletion<T>) -> FIRDocumentSnapshotBlock where T: Decodable {
        
        return { (snapshot, error) in
            do {
                if let error = error { throw error }
                guard let snapshot = snapshot, snapshot.exists else {
                    completion(.failure(FireNetworkError.dataNotFound))
                    return
                }
                
                if disableOffline && snapshot.metadata.isFromCache {
                    print("From cache, not available")
                } else {
                    if let object = try snapshot.data(as: T.self) {
                        completion(.success(object))
                    } else {
                        completion(.failure(FireNetworkError.decodeError))
                    }
                }
            } catch {
                completion(.failure(FireErrorConverter.convertError(error)))
            }
        }
    }
    
    
    // MARK: Multi Read
    func multiRead<T: Decodable>(info: FireEndpointInfo,
                                 completion: @escaping FireMultiCompletion<T>) {

        let ref = FireRefFactory.makeCollectionRef(info)

        fetchDocList(query: ref, listen: info.listen, completion: decodeMultiResponse(disableOffline: info.disableOffline, completion: completion))
    }
    
    func fetchDocList(query: Query,
                      listen: Bool,
                      completion: @escaping FIRQuerySnapshotBlock) {
        guard
            listen
        else { return query.getDocuments(completion: completion) }

        listeners.append(
            FireListener(query.addSnapshotListener(completion))
        )
    }
    
    func decodeMultiResponse<T>(disableOffline: Bool,
                                completion: @escaping FireMultiCompletion<T>) -> FIRQuerySnapshotBlock where T: Decodable {
        
        return { (snapshot, error) in
            do {
                if let error = error { throw error }
                guard let docs = snapshot?.documents else {
                    // MARK: - TODO
                    return
                }

                completion(.success(
                    try docs.compactMap { try $0.data(as: T.self) }
                ))
            } catch {
                completion(.failure(FireErrorConverter.convertError(error)))
            }
        }
    }
}


// MARK: - Queries
extension NnFireReader {
    
    func textQuery<T>(_ info: FireQueryInfo,
                      completion: @escaping FireMultiCompletion<T>) where T: Decodable {
        fetchDocList(
            query: info.query,
            listen: info.listen,
            completion: decodeMultiResponse(disableOffline: info.disableOffline,
                                            completion: completion))
    }
}
