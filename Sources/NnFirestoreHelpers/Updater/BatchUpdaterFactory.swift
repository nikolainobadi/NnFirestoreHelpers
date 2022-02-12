//
//  BatchUpdaterFactory.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

public protocol BatchUpdaterFactory {
    
    func makeBatchUpdater() -> NnBatchUpdater
}

public final class NnBatchUpdaterFactory: BatchUpdaterFactory {
    
    public init() { }
    
    public func makeBatchUpdater() -> NnBatchUpdater {
        NnFireBatchUpdater()
    }
}
