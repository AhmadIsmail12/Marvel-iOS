//
//  ApiManager.swift
//  Mavel-iOS
//
//  Created by Ahmad Ismail on 17/09/2023.
//

import Foundation
import CryptoSwift

final class ApiManager {
    // Singleton
    static let shared = ApiManager()
    
    struct BaseURl {
        static let apiKey = "7875ef7089c95c894a5d9295ebe22701"
        static let privateKey = "1e144a647f9cc8adebeffd52eafedcc6098080cc"
        static let scheme = "https"
        static let host = "gateway.marvel.com"
    }
    
    enum Method: String {
        case GET
        case POST
    }
    
    // This func return the URL with Parameters
    // Converts the params passed as Encodable to query Items
    func getURL(path: String, params: Encodable?) -> URL {
        var component = URLComponents()
        component.scheme = BaseURl.scheme
        component.host = BaseURl.host
        component.path = path
        let date = Date().timeIntervalSince1970
        component.queryItems = []
        var urlQueryItems = [URLQueryItem]()
        do {
            let queryParameters = try params?.toDictionary()
            queryParameters?.forEach {
                if $0.value is [Any] {
                    let values = $0.value as! [Any]
                    for (index, value) in values.enumerated() {
                        if let intValue = value as? Int {
                            urlQueryItems.append(URLQueryItem(name: "\($0.key)[\(index)]", value: String(intValue)))
                        } else if let stringValue = value as? String {
                            urlQueryItems.append(URLQueryItem(name: "\($0.key)[\(index)]", value: stringValue))
                        }
                    }
                } else {
                    urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
                }
            }
            urlQueryItems.append(URLQueryItem(name: "ts", value: "\(date)"))
            urlQueryItems.append(URLQueryItem(name: "hash", value: "\(date)\(BaseURl.privateKey)\(BaseURl.apiKey)".md5()))
            urlQueryItems.append(URLQueryItem(name: "apikey", value: BaseURl.apiKey))
            component.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        } catch {
            
        }
        return component.url!
    }
    
    public func createRequest(url : URL?, type : Method, completion : @escaping (URLRequest) -> Void) {
        guard let url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        completion(request)
    }
    
    //MARK: - API's
    public func getCharactersApi(
        path: String,
        params: Encodable?,
        completion: @escaping (Result<Response<Character> , Error>) -> Void) {
            self.createRequest(url: getURL(path: path, params: params), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) {data , _, error in
                guard let data = data , error == nil  else {
                    completion(.failure("Failed To Get Data" as! Error))
                    return
                }
                do {
                    let charctersResponse = try JSONDecoder().decode(Response<Character>.self, from: data)
                    completion(.success(charctersResponse))
                } catch {
                    print("Error : \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getCharacterContentApi(
        path: String,
        params: Encodable?,
        completion: @escaping (Result<Response<CharacterContent> , Error>) -> Void) {
            self.createRequest(url: getURL(path: path, params: params), type: .GET) { request in
                let task = URLSession.shared.dataTask(with: request) {data , _, error in
                    guard let data = data , error == nil  else {
                        completion(.failure("Failed To Get Data" as! Error))
                        return
                    }
                    do {
                        let charctersResponse = try JSONDecoder().decode(Response<CharacterContent>.self, from: data)
                        completion(.success(charctersResponse))
                    } catch {
                        print("Error : \(error.localizedDescription)")
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
        }
}

