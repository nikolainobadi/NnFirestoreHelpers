//
//  FireListener.swift
//  
//
//  Created by Nikolai Nobadi on 2/11/22.
//

import FirebaseFirestore

struct FireListener {
    let listener: ListenerRegistration
    let tag: Int?
    
    init(_ listener: ListenerRegistration, tag: Int? = nil) {
        self.listener = listener
        self.tag = tag
    }
    
    func removeListener() {
        listener.remove()
    }
}
