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
    associatedtype PersistantStore: CacheUpdateService
    var serviceStore: PersistantStore? { get set }
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
}

class ServiceRouter<PD>: NSObject, ServiceRouterProtocol, ServiceCancellable where PD: CacheUpdateService {
    typealias PersistantStore = PD
    private var task: URLSessionTask?
    private var completion: NetworkRouterCompletion?
    var serviceStore: PersistantStore?
    
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion) {
        self.completion = completion
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        
        if #available(iOS 11, *) {
            configuration.waitsForConnectivity = false
        }
        
        let session = URLSession(configuration: configuration)
        
        task = session.dataTask(with: route.urlRequest) { data, response, error in
            if let error = error as? URLError {
                let requestError = ServiceRequestError.handleError(error)
                completion(.failure(requestError))
            } else {
                let responseResult = ServiceResponseError.handleNetworkResponse(response)
                
                switch responseResult {
                case .success:
                    self.serviceStore?.saveInCache(data: data, response: response, for: route.urlRequest)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
        self.completion?(.failure(NetworkRequestError.cancelledByUser))
    }
}
