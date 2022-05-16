//
//  NnFireReader.swift
//  
//
//  Created by Nikolai Nobadi on 2/11/22.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

public final class NnFireReader {
    
    private var listeners = [FireListener]()
    
    public init() { }

    deinit {
        removeAllListeners()
    }
}
    

// MARK: - Reader
extension NnFireReader: NnReader {
    
    public func removeListener(tag: Int) {
        if let index = listeners.firstIndex(where: { $0.tag == tag }) {
            listeners[index].removeListener()
            listeners.remove(at: index)
        }
    }
    
    public func removeAllListeners() {
        listeners.forEach { $0.removeListener() }
        listeners = []
    }
    
    public func singleRead<T: Decodable>(info: FireEndpointInfo,
                                  completion: @escaping FireSingleCompletion<T>) {
        do {
            try fetchSingleDocument(
                info: info,
                completion: decodeSingleResponse(disableOffline: info.disableOffline, completion: completion))
        } catch {
            completion(.failure(FireErrorConverter.convertError(error)))
        }
    }
    
    public func multiRead<T: Decodable>(info: FireEndpointInfo,
                                 completion: @escaping FireMultiCompletion<T>) {

        let ref = FireRefFactory.makeCollectionRef(info)

        fetchDocList(query: ref, listen: info.listen, completion: decodeMultiResponse(disableOffline: info.disableOffline, completion: completion))
    }
    
    public func singleRead<T: Decodable>(info: FireEndpointInfo) async throws -> T {
        guard let ref = FireRefFactory.makeDocRef(info) else { throw FireNetworkError.badURL }
        
        return try await ref.getDocument(as: T.self)
    }
    
    public func multiRead<T: Decodable>(info: FireEndpointInfo) async throws -> [T] {
        try await asyncDocFetch(query: FireRefFactory.makeCollectionRef(info))
    }
}


// MARK: - Queries
extension NnFireReader: NnQueryReader {
    
    public func queryRead<T>(_ info: FireQueryInfo,
                             completion: @escaping FireMultiCompletion<T>) where T: Decodable {
        fetchDocList(
            query: info.query,
            listen: info.listen,
            completion: decodeMultiResponse(disableOffline: info.disableOffline,
                                            completion: completion))
    }
    
    public func queryRead<T: Decodable>(_ info: FireQueryInfo) async throws -> [T] {
        try await asyncDocFetch(query: info.query)
    }
}


// MARK: - Private Methods
private extension NnFireReader {
    
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
                    let object = try snapshot.data(as: T.self)
                    
                    completion(.success(object))
                }
            } catch {
                completion(.failure(FireErrorConverter.convertError(error)))
            }
        }
    }
    
    func asyncDocFetch<T: Decodable>(query: Query) async throws -> [T] {
        let snapshot = try await query.getDocuments()
        
        return try snapshot.documents.compactMap { try $0.data(as: T.self) }
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
