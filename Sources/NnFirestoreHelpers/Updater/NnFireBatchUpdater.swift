//
//  NnFireBatchUpdater.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

// MARK: - Protocol
public protocol NnBatchUpdater {
    func add<T: Encodable>(item: UpdateItem<T>) throws
    func batchUpdate(completion: @escaping (Error?) -> Void)
    func batchUpdate() async throws
}


// MARK: - Class
final class NnFireBatchUpdater {
    private let batch = FireRefFactory.makeBatch()
}


// MARK: - BatchUpdate
extension NnFireBatchUpdater: NnBatchUpdater {
    
    public func add<T>(item: UpdateItem<T>) throws where T: Encodable {
        guard let ref = FireRefFactory.makeDocRef(item.info) else {
            throw FireNetworkError.updateFail
        }
        
        try batch.setData(from: item.model, forDocument: ref)
    }
    
    public func batchUpdate(completion: @escaping (Error?) -> Void) {
        batch.commit(completion: completion)
    }
    
    public func batchUpdate() async throws {
        try await batch.commit()
    }
}
