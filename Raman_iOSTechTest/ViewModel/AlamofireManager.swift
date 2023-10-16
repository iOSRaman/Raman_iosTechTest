//
//  APIManager.swift
//  Raman_iOSTechTest
//
//  Created by Genie Talk on 13/10/23.
//

import Foundation
import Alamofire

class AlamofireManager : NSObject {
    static func callAPiGetDataListJson(url:String,OnResultBlock: @escaping (_ dict: Any,_ status:Bool) -> Void) {
        let headers: HTTPHeaders = [
            "x-api-key": apiKey
        ]
        AF.request(url, method: .get, parameters: nil, encoding:  URLEncoding.queryString, headers: headers).response { response in
            switch response.result {
            case .success:
                let data = response.data
                if data != nil{
                    let str = String(decoding: data!, as: UTF8.self)
                    print(str)
                }
                OnResultBlock(data as Any, true)
                
            case let .failure(error):
                print(error)
                OnResultBlock(error, false)
            }
        }
        
    }
}
