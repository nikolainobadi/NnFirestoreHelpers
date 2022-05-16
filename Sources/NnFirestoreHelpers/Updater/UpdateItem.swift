//
//  UpdateItem.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

public struct UpdateItem<T: Encodable> {
    public var model: T
    public var info: FireEndpointInfo
    public var isDeleting: Bool
    
    public init(model: T, info: FireEndpointInfo, isDeleting: Bool = false) {
        self.model = model
        self.info = info
        self.isDeleting = isDeleting
    }
}
