//
//  File.swift
//  
//
//  Created by Nikolai Nobadi on 2/11/22.
//

import FirebaseFirestore

public final class FireRefFactory {
    
    private static let db = Firestore.firestore()
    
    private init()  { }
    
    public static func makeCollectionRef(_ info: FireEndpointInfo) -> CollectionReference {
        
        let ref = db.collection(info.collection)
        
        guard
            let docId = info.docId,
            let nestedCollection = info.nestedCollection
        else { return ref }
            
        return ref.document(docId).collection(nestedCollection)
    }
    
    public static func makeDocRef(_ info: FireEndpointInfo) -> DocumentReference? {

        guard let docId = getDocId(info) else { return nil }

        return makeCollectionRef(info).document(docId)
    }
    
    private static func getDocId(_ info: FireEndpointInfo) -> String? {
        info.nestedId ?? info.docId
    }
}
