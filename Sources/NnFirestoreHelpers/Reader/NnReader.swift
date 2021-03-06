//
//  NnReader.swift
//  
//
//  Created by Nikolai Nobadi on 2/11/22.
//

// MARK: Reader
public protocol NnReader {
    func removeAllListeners()
    func singleRead<T: Decodable>(
        info: FireEndpointInfo,
        completion: @escaping FireSingleCompletion<T>)
    
    func multiRead<T: Decodable>(
        info: FireEndpointInfo,
        completion: @escaping FireMultiCompletion<T>)
    
    func singleRead<T: Decodable>(info: FireEndpointInfo) async throws -> T
    func multiRead<T: Decodable>(info: FireEndpointInfo) async throws -> [T]
}


// MARK: - QueryReader
public protocol NnQueryReader {
    func queryRead<T>(_ info: FireQueryInfo,
                      completion: @escaping FireMultiCompletion<T>) where T: Decodable
    
    func queryRead<T: Decodable>(_ info: FireQueryInfo) async throws -> [T]
}


// MARK: - Dependencies
public typealias FireSingleCompletion<T: Decodable> = ((Result<T, FireNetworkError>) -> Void)

public typealias FireMultiCompletion<T: Decodable> = ((Result<[T], FireNetworkError>) -> Void)
