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
                                  completion: @escaping (Result<T, Error>) -> Void) {
        do {
            try fetchSingleDocument(
                info: info,
                completion: decodeSingleResponse(disableOffline: info.disableOffline, completion: completion))
        } catch {
            completion(.failure(error))
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
                                 completion: @escaping (Result<T, Error>) -> Void) -> FIRDocumentSnapshotBlock where T: Decodable {
        
        return { (snapshot, error) in
            do {
                if let error = error { throw error }
                guard let snapshot = snapshot, snapshot.exists else {
                    // MARK: - TODO
                    return
                }
                
                if disableOffline && snapshot.metadata.isFromCache {
                    print("From cache, not available")
                } else {
                    if let object = try snapshot.data(as: T.self) {
                        completion(.success(object))
                    } else {
                        completion(.failure(NSError(domain: "Test", code: 0)))
                    }
                }
            } catch {
                // MARK: - TODO
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: Multi Read
    func multiRead<T: Decodable>(info: FireEndpointInfo,
                                 completion: @escaping (Result<[T], Error>) -> Void) {

        let ref = FireRefFactory.makeCollectionRef(info)

        fetchDocList(query: ref, listen: info.listen) { (snapshot, error) in

        }
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
                                completion: @escaping (Result<[T], Error>) -> Void) -> FIRQuerySnapshotBlock where T: Decodable {
        
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
                completion(.failure(error))
            }
        }
    }
    
    
    // MARK: Queries
//    func textQuery<T>(queryInfo: FireTextQueryInfo,
//                      completion: @escaping (Result<[T], NetworkError>) -> Void) where T : Decodable {
//
//        let query = FireRefFactory.makeTextQuery(queryInfo)
//
//        fetchDocList(query: query, listen: queryInfo.listen) { [weak self] (snapshot, error) in
//
//            self?.decoder.decodeMultiResponse(
//                snapshot: snapshot,
//                error: error,
//                completion: completion)
//        }
//    }
    
//    func arrayQuery<T>(queryInfo: FireArrayQueryInfo,
//                       completion: @escaping (Result<[T], NetworkError>) -> Void) where T : Decodable {
//
//        FireRefFactory.makeArrayQuery(queryInfo).getDocuments { [weak self] (snapshot, error) in
//
//            self?.decoder.decodeMultiResponse(
//                snapshot: snapshot,
//                error: error,
//                completion: completion)
//        }
//    }
}



