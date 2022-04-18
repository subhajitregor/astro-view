//
//  Service.swift
//  astro-view
//
//  Created by Subhajit on 14/04/22.
//

import Foundation
typealias NetworkRouterCompletion = (Result<Data?, Error>) -> ()

protocol ServiceCancellable {
    func cancel()
}

protocol ServiceRouterProtocol {
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
}

class ServiceRouter: NSObject, ServiceRouterProtocol, ServiceCancellable, URLSessionTaskDelegate {
    
    private var task: URLSessionTask?
    private var completion: NetworkRouterCompletion?
    
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion) {
        self.completion = completion
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        
        if #available(iOS 11, *) {
            configuration.waitsForConnectivity = true
        }
        
        let session = URLSession(configuration: configuration)
        
        task = session.dataTask(with: route.urlRequest) { data, response, error in
            let responseResult = ServiceResponse.handleNetworkResponse(response)
            
            switch responseResult {
            case .success:
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        task?.delegate = self
        task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
        self.completion?(.failure(NetworkRequestError.cancelledByUser))
    }
    
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        self.completion?(.failure(NetworkRequestError.waitingForConnectivity))
    }
}
