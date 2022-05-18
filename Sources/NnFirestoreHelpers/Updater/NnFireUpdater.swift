//
//  NnFireUpdater.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

// MARK: - NnUpdater
public protocol NnUpdater {
    func singleUpdate<T: Encodable>(_ item: UpdateItem<T>) async throws
    func singleUpdate<T: Encodable>(_ item: UpdateItem<T>, completion: @escaping (Error?) -> Void)
}


// MARK: - FireUpdater
public final class NnFireUpdater {
    
    public init() { }
}


// MARK: - SingleUpdate
extension NnFireUpdater: NnUpdater {
    
    public func singleUpdate<T: Encodable>(_ item: UpdateItem<T>) async throws {
        guard let ref = FireRefFactory.makeDocRef(item.info) else {
            throw FireNetworkError.badURL
        }
        
        do {
            if item.isDeleting {
                try await ref.delete()
            } else {
                try ref.setData(from: item.model)
            }
        } catch {
            throw FireErrorConverter.convertError(error)
        }
    }
    
    public func singleUpdate<T>(_ item: UpdateItem<T>,
                                completion: @escaping (Error?) -> Void) where T: Encodable {
        do {
            guard let ref = FireRefFactory.makeDocRef(item.info) else {
                return completion(FireNetworkError.badURL)
            }
            
            if item.isDeleting {
                ref.delete(completion: completion)
            } else {
                try ref.setData(from: item.model)
                
                completion(nil)
            }
        } catch {
            completion(FireErrorConverter.convertError(error))
        }
    }
}
