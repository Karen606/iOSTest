//
//  NetworkManager.swift
//  iOSTest
//
//  Created by user on 30.06.23.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    enum Paths: String {
        case getCategories = "058729bd-1402-4578-88de-265481fd7d54"
    }
    
    private init() {}
    private let scheme = "https"
    private let base = "run.mocky.io"
    private let apiVersion = "/v3/"
    
    private func getURLComponents(path: Paths, params: [String: Any]? = nil) -> URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.base
        components.path = self.apiVersion + path.rawValue
        
        if let params = params {
            for (name, val) in params {
                if let value = val as? String {
                    components.queryItems?.append(URLQueryItem(name: name, value: value))
                } else {
                    fatalError("something went wrong")
                }
            }
        }
        
        return components
    }
    
    private func handleResponse(response: AFDataResponse<Any>, completion: ((Result<Data,NetworkError>) -> Void)) {
        if (200...299) ~= response.response?.statusCode ?? -1 {
            completion(.success(response.data!))
        } else {
            do {
                if let data = response.data {
                    let json = try JSONDecoder().decode(ErrorResponse.self, from: data)
                    completion(.failure(.responseError(json.message)))
                } else {
                    completion(.failure(.serverError))
                }
            }  catch {
                completion(.failure(.serverError))
            }
        }
    }
    
    func setupRequest(path: Paths, method: RequestMethod, bodyJson: [String : Any]? = nil, body: Encodable? = nil, params: [String: Any]? = nil, header: HeaderType, completion: @escaping((Result<Data,NetworkError>) -> Void)) {
        guard let url = self.getURLComponents(path: path, params: params).url else { fatalError("url is nil") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue(header.value[0].value, forHTTPHeaderField: "Content-Type")
        request.setValue("en", forHTTPHeaderField: "Accept-Language")
        if let bodyJson = bodyJson {
            if let jsonData = try? JSONSerialization.data(withJSONObject: bodyJson, options: .prettyPrinted) {
                request.httpBody = jsonData
            }
        } else if let body = body {
            if let jsonData = body.toJSONData() {
                request.httpBody = jsonData
            }
        }

        AF.request(request).validate().responseJSON { [weak self] response in
            guard let self = self else { return }
            self.handleResponse(response: response, completion: completion)
        }
    }
}

struct ErrorResponse: Decodable {
    let status: String
    let message: String
}

extension Dictionary {
    func passingQuery() -> String {
        var finalQueryForm = "?"
        for element in self {
            finalQueryForm.append("\(element.key)=\(element.value)&")
        }
        finalQueryForm.removeLast()
        return finalQueryForm
    }
}

enum RequestMethod: String {
    case put = "PUT"
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum HeaderType {
    case application_json
    case multipart_form_data
    case application_x_www_form_urlencoded
    
    var value: HTTPHeaders {
        switch self {
        case .application_json:
            return ["Content-Type" : "application/json"]
        case .multipart_form_data:
            return ["Content-Type": "multipart/form-data"]
        case .application_x_www_form_urlencoded:
            return ["Content-Type" : "application_x_www_form_urlencoded"]
        }
    }
}

enum NetworkError: Error {
    case serverError
    case responseError(_ errorMessage: String)
    
    var errorMessage: String {
        switch self {
        case .serverError:
            return "Something went wrong"
        case .responseError(let errMessage):
            return errMessage
        }
    }
}

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
