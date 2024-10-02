//
//  DataRequest.swift
//  DunnMetal
//
//  Created by chanaka kasun bandara on 11/26/18.
//  Copyright © 2018 Elegant Media. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

protocol DataRequest {
    func requestData(completion: @escaping (AFResult<Data>) -> Void)
}

private func headers() -> HTTPHeaders {
    
    return [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
}

struct URLDataRequest: DataRequest {
    
    private var _url: String
    private var _param: [String : Any]?
    private var _httpMethod: HTTPMethod
    
    
    init(url: String, param: [String : Any]?, method: HTTPMethod) {
        _url = url
        _param = param
        _httpMethod = method
    }
    
    func requestData(completion: @escaping (AFResult<Data>) -> Void) {
        // continue with request
        let encodedUrl = _url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? _url
        AF.request(encodedUrl, method: _httpMethod, parameters: _param, encoding: JSONEncoding.default, headers: headers()).validate().responseJSON { response in
            //proceed log out when session has expired
            if response.response?.statusCode == 401 {
                
            }
            switch response.result {
            case .success:
                if let data = response.data {
                    completion(.success(data))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}


struct JSONRequest {
    
    var dataSource: DataRequest
    
    func requestJSONObject(completion: @escaping(JSON?, String?) -> ()) {
        dataSource.requestData { response in
            switch response {
            case let .success(data):
                do {
                    let json = try JSON(data: data)
                    completion(json, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
            case let .failure(error):
                completion(nil, (error).localizedDescription)
            }
        }
    }
    
}
