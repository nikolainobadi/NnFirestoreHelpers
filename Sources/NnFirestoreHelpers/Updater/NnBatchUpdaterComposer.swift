//
//  NnBatchUpdaterComposer.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

public protocol NnBatchUpdaterComposer {
    
    func makeBatchUpdater() -> NnBatchUpdater
}

public final class NnBatchUpdaterComposite: NnBatchUpdaterComposer {
    
    public init() { }
    
    public func makeBatchUpdater() -> NnBatchUpdater {
        NnFireBatchUpdater()
    }
}
