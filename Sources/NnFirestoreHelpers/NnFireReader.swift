//
//  NnFireReader.swift
//  
//
//  Created by Nikolai Nobadi on 2/11/22.
//

final class NnFireReader {
    
//    private let decoder = FirestoreDecoder()
//
//    private var listeners = [FireListener]()
//
//    deinit {
//        removeAllListeners()
//    }
}
    

// MARK: - Reader
extension NnFireReader: NnReader {
    
    func removeListener(tag: Int) {
//        if let index = listeners.firstIndex(where: { $0.tag == tag }) {
//            listeners[index].removeListener()
//            listeners.remove(at: index)
//        }
    }
    
    func removeAllListeners() {
//        listeners.forEach { $0.removeListener() }
//        listeners = []
    }
    
    func singleRead<T: Decodable>(info: FireEndpointInfo,
                                  completion: @escaping (Result<T, Error>) -> Void) {
        
//        fetchSingleDocument(info: info) { [unowned self] (snapshot, error) in
//            decoder.decodeSingleResponse(
//                snapshot: snapshot,
//                error: error,
//                disableOffline: info.disableOffline,
//                completion: completion)
//        }
    }
    
//    func fetchSingleDocument(info: FireEndpointInfo,
//                             completion: @escaping FIRDocumentSnapshotBlock) {
//
//        let ref = FireRefFactory.makeDocRef(info)
//
//        guard info.listen else { return ref.getDocument(completion: completion) }
//
//        listeners.append(
//            FireListener(ref.addSnapshotListener(includeMetadataChanges: true,
//                                                 listener: completion))
//        )
//    }
    
    
    // MARK: Multi
    func multiRead<T: Decodable>(info: FireEndpointInfo,
                                 completion: @escaping (Result<[T], Error>) -> Void) {

//        let ref = FireRefFactory.makeCollectionRef(info)
//
//        fetchDocList(query: ref, listen: info.listen) { [unowned self] (snapshot, error) in
//
//            decoder.decodeMultiResponse(
//                snapshot: snapshot,
//                error: error,
//                completion: completion)
//        }
    }
    
//    func fetchDocList(query: Query,
//                      listen: Bool,
//                      completion: @escaping FIRQuerySnapshotBlock) {
//        guard
//            listen
//        else { return query.getDocuments(completion: completion) }
//
//        listeners.append(
//            FireListener(query.addSnapshotListener(completion))
//        )
//    }
    
    
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



