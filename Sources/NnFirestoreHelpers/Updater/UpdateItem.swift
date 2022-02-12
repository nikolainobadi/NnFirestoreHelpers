//
//  UpdateItem.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

public struct UpdateItem<T: Encodable> {
    var model: T
    var info: FireEndpointInfo
    var isDeleting: Bool = false
}
