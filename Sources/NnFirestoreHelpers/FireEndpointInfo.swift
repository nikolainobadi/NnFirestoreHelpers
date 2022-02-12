//
//  FireEndpointInfo.swift
//  
//
//  Created by Nikolai Nobadi on 2/11/22.
//

public struct FireEndpointInfo: Equatable {
    
    // MARK: - Properties
    var collection: String
    var docId: String?
    var nestedCollection: String?
    var nestedId: String?
    var listen: Bool
    var listenerTag: Int?
    var disableOffline: Bool = false
    
    
    // MARK: - Init
    init(collection: String,
         docId: String? = nil,
         nestedCollection: String? = nil,
         nestedId: String? = nil,
         listen: Bool = false,
         listenerTag: Int? = nil,
         disableOffline: Bool = false) {
        
        self.collection = collection
        self.docId = docId
        self.nestedCollection = nestedCollection
        self.nestedId = nestedId
        self.listen = listen
        self.listenerTag = listenerTag
        self.disableOffline = disableOffline
    }
}



