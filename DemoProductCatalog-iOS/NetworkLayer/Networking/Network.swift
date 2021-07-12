//
//  Network.swift
//  DemoProductCatalog-iOS
//
//  Created by Mujy on 10/07/2021.
//

import UIKit

final class Network: NSObject {
    
    public static let shared: Network = .init()
    
    private lazy var imageDownloadManager: URLSession = {
        let conf: URLSessionConfiguration = .default
        conf.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: conf, delegate: nil, delegateQueue: OperationQueue())
    }()
    
    /// To prevent flooding Network IC with downloading resources
    private var downloadLimit: DispatchSemaphore = .init(value: 3)
    
    /// This function is intended to be used for all REST API calls from the app to get decoded response/failure in return, or a custom NetworkError
    public func request<E: EndpointProvider>(_ request: E, completion: @escaping (NetworkResult<E.Response, E.Failure, NetworkError>) -> Void) {
        
        let endpoint = request.endpoint
        let manager = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        
        guard let urlRequest = try? endpoint.urlRequest() else {
            completion(.error(.requestCreation))
            return
        }
        
        let task = manager.dataTask(with: urlRequest) { (data, response, error) in
            var error = error
            if let response = response as? HTTPURLResponse,
                !(200...299).contains(response.statusCode),
                error == nil {
                
                let message = "Bad Status: \(response.statusCode)"
                error = NSError(domain: URLError.errorDomain, code: URLError.badServerResponse.rawValue, userInfo: [NSLocalizedDescriptionKey: message])
            }

            if let error = error {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let errorDto = try decoder.decode(E.Failure.self, from: data)
                        completion(.failure(errorDto))
                    } catch let exception {
                        completion(.error(NetworkError.server(data, exception)))
                    }
                } else {
                    completion(.error(NetworkError.server(data, error)))
                }
                
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let dto = try decoder.decode(E.Response.self, from: data)
                    completion(.success(dto))
                } catch let exception {
                    completion(.error(.decoding(data, exception)))
                }
            }
        }

        task.resume()
    }
    
    /// A convinience function to download an Image from a given URL using the default configuration
    public func downloadImage(from url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        DispatchQueue.global().async {
            let urlRequest = URLRequest(url: url)
            let task = self.imageDownloadManager.dataTask(with: urlRequest) { (data, _, error) in
                defer { self.downloadLimit.signal() }
                guard let data = data,
                      let image = UIImage(data: data) else {
                    return DispatchQueue.main.async { completion(nil, error) }
                }
                DispatchQueue.main.async { completion(image, nil) }
            }
            
            // Wait until it is safe to make a request
            self.downloadLimit.wait()
            task.resume()
        }
    }
    
}
