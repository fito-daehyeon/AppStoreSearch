//
//  AppStoreCopy.swift
//  AppStoreCopy
//
//  Created by DaeHyeon Kim on 2022/03/18.
//

import Foundation
import Combine

enum AppStoreAPIError: Error {
    case parsing(description: String, returnValue: [String: Any]?)
    case network(description: String, statusCode: Int?, url: String?)
    case invalidURL(path: String)
    case accessTokenDoesNotExist
    case userUUIDDoesNotExist
    case invalidBasicAuthorization
    case AppStoreResultFailure(code: String, message: String)
    case invalidToken
    case emptyResponse
    case unknown(description: String)
}


class AppStoreAPIFetcher
{
    static let shared = AppStoreAPIFetcher()
    
    let scheme = "https"
    let host = "itunes.apple.com"
    let port: Int? = nil
    
    
    private let session: URLSession = .shared
    private let disposables = Set<AnyCancellable>()
    
    
    func requestAppData(item: String) -> AnyPublisher<[AppDataInfo], AppStoreAPIError> {
        let params = ["entity":"software", "term": item,"country":"kr","limit":"10"]
        return requestToServer(api: .getAppData, header: [:], parameters: params)
    }
    
    
    private func requestToServer<T>(
        api: AppStoreAPI,
        header: [String: String],
        parameters: [String: Any]
    ) -> AnyPublisher<T, AppStoreAPIError> where T: Codable {
        let apiDescriptor = api.getDesciptor()
        
        var urlComponents = createUrlComponents(with: apiDescriptor.path)
        
        if apiDescriptor.method == .get {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        }
        
        guard let url = urlComponents.url else {
            let error = AppStoreAPIError.invalidURL(path: apiDescriptor.path)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = apiDescriptor.contentType == nil ? header : header.merging(["Content-Type": apiDescriptor.contentType!.rawValue]) { (current, _) in current }
        request.httpMethod = apiDescriptor.method.toString()
        
        if apiDescriptor.method == .post || apiDescriptor.method == .put || apiDescriptor.method == .delete {
            request.httpBody = createBodyParameters(parameters)
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { response -> Data in
                guard let httpResponse = response.response as? HTTPURLResponse else {
                    throw AppStoreAPIError.network(
                        description: "Invalid type of response",
                        statusCode: nil,
                        url: response.response.url?.absoluteString
                    )
                }
                
                let statusCode = httpResponse.statusCode
                
                guard statusCode == 200 else {
                    
                    if let jsonData = try? JSONSerialization.jsonObject(with: response.data, options: []) {
                        throw AppStoreAPIError.network(
                            description: "\(jsonData)",
                            statusCode: statusCode,
                            url: httpResponse.url?.absoluteString
                        )
                    } else {
                        let responseData = String(data: response.data, encoding: .utf8) ?? "Unknown type of response.data"
                        throw AppStoreAPIError.network(
                            description: "\(responseData)",
                            statusCode: statusCode,
                            url: httpResponse.url?.absoluteString
                        )
                    }
                }
                
                return response.data
            }
            .mapError { [weak self] err -> AppStoreAPIError in
                if let AppStoreAPIError = err as? AppStoreAPIError {
                    self?.printErrMessageOnConsole(err: AppStoreAPIError, url: request.url?.absoluteString)
                    return AppStoreAPIError
                } else {
                    return AppStoreAPIError.network(
                        description: err.localizedDescription,
                        statusCode: nil,
                        url: request.url?.absoluteString
                    )
                }
            }
            .flatMap(maxPublishers: .max(1), { responseData -> AnyPublisher<T, AppStoreAPIError> in
                
                //성공데이터 디코딩 후 리턴
                return decode(responseData)
            })
            .mapError{ [weak self] wowpleErr in
                self?.printErrMessageOnConsole(err: wowpleErr, url: request.url?.absoluteString)
                return wowpleErr
            }
            .eraseToAnyPublisher()
    }
    
    
    func convertToDictionary(from text: String) throws -> [String: String] {
        guard let data = text.data(using: .utf8) else { return [:] }
        let anyResult: Any = try JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: String] ?? [:]
    }
    
    private func createBodyParameters(_ dict: [String: Any]) -> Data? {
        let parameterArray = dict.map { (key, value) -> String in
            return "\(key)=\(value)"
        }
        
        return parameterArray.joined(separator: "&").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)?.data(using: .utf8)
    }
    
    private func createUrlComponents(with path: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.host
        urlComponents.port = self.port
        urlComponents.path = path
        
        return urlComponents
    }
    
    private func printErrMessageOnConsole(err: AppStoreAPIError, url: String?) {
        switch err {
        case .network(let desc, let statusCode, _):
            print("=============== api network error  / status: \(statusCode ?? -1) ===============")
            print("URL: \(url ?? "Invalid URL")")
            print(desc)
            print("=============================================")
        case .parsing(let desc, let returnValue):
            print("============================== api parsing error ==============================")
            print("URL: \(url ?? "Invalid URL")")
            print(desc)
            
            if returnValue != nil {
                print("\(returnValue!)")
                print("===========================================================================")
            } else {
                print("===========================================================================")
            }
        case .AppStoreResultFailure(let code, let message):
            print("============================== api error code \(code) ==============================")
            print("URL: \(url ?? "Invalid URL")")
            print("message: \(message)")
        default:
            break
        }
    }
}


extension AppStoreAPIFetcher {
    struct BaroderAPIDesciptor {
        let path: String
        let method: HTTPMethod
        let contentType: HeaderContentType?
    }
    
    enum AppStoreAPI {
        
        case getAppData
        
        func getDesciptor() -> BaroderAPIDesciptor {
            switch self {
                
                //유저
            case .getAppData:
                return BaroderAPIDesciptor(path: "/search", method: .get, contentType: .urlEncoded)
                
                
            }
        }
    }
    
    enum HTTPMethod {
        case get, post, put, delete
        func toString() -> String {
            switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .delete:
                return "DELETE"
            }
        }
    }
    
    enum HeaderContentType: String {
        case urlEncoded = "application/x-www-form-urlencoded"
        case formData = "multipart/form-data"
    }
}
