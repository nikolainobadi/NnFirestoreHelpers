//
//  NnReader.swift
//  
//
//  Created by Nikolai Nobadi on 2/11/22.
//

public protocol NnReader {
    func singleRead<T: Decodable>(
        info: FireEndpointInfo,
        completion: @escaping (Result<T, Error>) -> Void)
    
    func multiRead<T: Decodable>(
        info: FireEndpointInfo,
        completion: @escaping (Result<[T], Error>) -> Void)
}
