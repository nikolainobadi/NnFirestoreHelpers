//
//  NnBatchUpdaterFactory.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

public protocol NnBatchUpdaterFactoryProtocol {
    
    func makeBatchUpdater() -> NnBatchUpdater
}

public class NnBatchUpdaterFactory: NnBatchUpdaterFactoryProtocol {
    
    public init() { }
    
    public func makeBatchUpdater() -> NnBatchUpdater {
        NnFireBatchUpdater()
    }
}
