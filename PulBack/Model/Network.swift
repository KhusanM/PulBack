//
//  Network.swift
//  PulBack
//
//  Created by Kh's MacBook on 19.08.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class Network{
    
    class func request(url: String, method: HTTPMethod, param: [String: Any]?, header: HTTPHeaders?, complition: @escaping (_ data: JSON?) -> ()){
        
        if Reachability.isConnectedToNetwork(){
            Loader.start()
            AF.request(AppData.base_URL + url, method: method, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { response in
                Loader.stop()
                if let data = response.data{
                    complition(JSON(data))
                }else{
                    complition(nil)
                }
            }
        }else{
            print("No Internet")
            ShowAlert.showAlert(text: "No connection to internet", forState: .error)
        }
    }
    
    class func requestWithToken(url: String, method: HTTPMethod, param: [String: Any]?, complition: @escaping (_ data: JSON?) -> ()){
        
        if Reachability.isConnectedToNetwork(){
            let token = Cache.getUserToken()
            
            let header: HTTPHeaders = [
                "Authorization" : "Barer \(token)",
                "Content-Type" : "application/json"
            ]
            
            Loader.start()
            AF.request(AppData.base_URL + url, method: method, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { response in
                Loader.stop()
                if let data = response.data{
                    complition(JSON(data))
                }else{
                    complition(nil)
                }
            })
        }else{
            print("No Internet")
            ShowAlert.showAlert(text: "No connection to internet", forState: .error)
        }
    }
    
    
}
