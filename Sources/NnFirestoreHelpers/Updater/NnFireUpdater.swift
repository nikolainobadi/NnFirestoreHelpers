//
//  NnFireUpdater.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

// MARK: - NnUpdater
public protocol NnUpdater {
    func singleUpdate<T: Encodable>(_ item: UpdateItem<T>, completion: @escaping (Error?) -> Void)
}


// MARK: - FireUpdater
final class NnFireUpdater {
    
    public init() { }
}


// MARK: - SingleUpdate
extension NnFireUpdater: NnUpdater {
    
    func singleUpdate<T>(_ item: UpdateItem<T>,
                                completion: @escaping (Error?) -> Void) where T: Encodable {
        do {
            guard let ref = FireRefFactory.makeDocRef(item.info) else {
                // MARK: - TODO
                // complete with error
                return
            }
            
            if item.isDeleting {
                ref.delete(completion: completion)
            } else {
                try ref.setData(from: item.model)
            }
        } catch {
            // MARK: - TODO -> convert error
            completion(error)
        }
    }
}
