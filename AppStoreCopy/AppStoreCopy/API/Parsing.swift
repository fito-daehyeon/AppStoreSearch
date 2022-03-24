//
//  Parsing.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/18.
//

import Foundation
import Combine

fileprivate func makeErrorResponseReadable(data: Data) -> [String: Any]? {
    guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
        return nil
    }
    
    return json
}

func decode<T: Codable>(_ data: Data) -> AnyPublisher<T, AppStoreAPIError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    
    
    return Just(data)
        .decode(type: ResponseBase<T>.self, decoder: decoder)
        .tryMap { result -> T? in
            
            if result.results == nil && (result.results as? [Any]?) != nil {
                return [] as? T
            } else {
                return result.results
            }
            
        }
        .tryMap {
            if ($0 == nil) {
                throw AppStoreAPIError.emptyResponse
            } else {
                return $0
            }
        }
        .compactMap{$0}
        .mapError{err -> AppStoreAPIError in
            if let wowpleErr = err as? AppStoreAPIError {
                return wowpleErr
            } else {
                return .parsing(description: err.localizedDescription, returnValue: makeErrorResponseReadable(data: data))
            }
        }
        .eraseToAnyPublisher()
}


