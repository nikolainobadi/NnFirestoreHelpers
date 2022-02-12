//
//  NnFireBatchUpdater.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

// MARK: - Protocol
public protocol NnBatchUpdater {
    func add<T: Encodable>(item: UpdateItem<T>?) throws
    func batchUpdate(completion: @escaping (Error?) -> Void)
}


// MARK: - Class
final class NnFireBatchUpdater {
    
    private let batch = FireRefFactory.makeBatch()
}


// MARK: - BatchUpdate
extension NnFireBatchUpdater: NnBatchUpdater {
    
    public func add<T>(item: UpdateItem<T>?) throws where T : Encodable {
        guard let item = item else { return }
        guard let ref = FireRefFactory.makeDocRef(item.info) else {
            // MARK: - TODO
            // throw error
            return
        }
        
        try batch.setData(from: item.model, forDocument: ref)
    }
    
    public func batchUpdate(completion: @escaping (Error?) -> Void) {
        batch.commit(completion: completion)
    }
}
