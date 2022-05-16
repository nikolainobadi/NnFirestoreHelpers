//
//  FireQueryInfo.swift
//  
//
//  Created by Nikolai Nobadi on 2/12/22.
//

import FirebaseFirestore

public struct FireQueryInfo {
    let query: Query
    let listen: Bool
    let disableOffline: Bool
    
    public init(query: Query,
                listen: Bool = false,
                disableOffline: Bool = false) {
        
        self.query = query
        self.listen = listen
        self.disableOffline = disableOffline
    }
}
