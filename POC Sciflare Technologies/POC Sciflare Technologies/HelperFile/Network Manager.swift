//
//  Network Manager.swift
//  POC Sciflare Technologies
//
//  Created by Apple on 08/06/24.
//

import Foundation
import Alamofire

class ApiManager:NSObject {
    
    //MARK: - Post Data
    static func postData(api:String,param:[String:Any],success:@escaping (Data)->Void,failure:@escaping(Error)->Void){
        
        AF.request(api,method:.post,parameters: param,encoding: JSONEncoding.default).responseJSON { response in
            do{
                guard let responseData = response.data else {
                    return
                }
                switch response.result{
                case .success:
                    success(responseData)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
    //MARK: - Get Data
    static func getData (api:String,success:@escaping (Data)->Void,failure:@escaping(Error)->Void){
        
        AF.request(api,method:.get,encoding: URLEncoding.default).responseJSON { response in
            do{
                guard let responseData = response.data else {
                    return
                }
                switch response.result{
                case .success:
                    success(responseData)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
    //MARK: - Put Data
    static func putData(api:String,param:[String:Any],success:@escaping (Data)->Void,failure:@escaping(Error)->Void){
        AF.request(api,method:.put,parameters: param,encoding: JSONEncoding.default).responseJSON { response in
            do{
                guard let responseData = response.data else {
                    return
                }
                switch response.result{
                case .success:
                    success(responseData)
                case .failure(let error):
                    failure(error)
                }
            }
        }
    }
}


