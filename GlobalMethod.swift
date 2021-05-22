//
//  GlobalMethod.swift
//  EcomApp
//
//  Created by MDR SOFTECH on 20/05/21.
//

import Foundation
import Alamofire
class GlobalMethod: NSObject {

    static let objGlobalMethod = GlobalMethod()

    func ServiceMethod(url:String, method:String, controller:UIViewController, parameters:Parameters, completion: @escaping (_ result: DataResponse<Any>) -> Void) {

            var headers = Alamofire.SessionManager.defaultHTTPHeaders
            headers["HeaderKey"] = "HeaderKey"
            if method == "POST" {
                methodType = .post
                param = parameters
            }
            else {
                methodType = .get
            }
            Alamofire.request(url, method: methodType, parameters: param, encoding: JSONEncoding.default, headers:headers
                ).responseJSON
                { response in

                    completion(response)
            }
        }
}
