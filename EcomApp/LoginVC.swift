//
//  LoginVC.swift
//  SideMenu
//
//  Created by MDR SOFTECH on 15/05/21.
//  Copyright © 2021 kukushi. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    let parameters = [
            "username": "t1est1@gmail.com",
            "password": "1234578"
        ]
        let url = "http://vilouette.krewtechnologies.com/account/Api/login"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        // Do any additional setup after loading the view.
    }
    @IBAction func loginPressed(_ sender: Any) {
        print("hello")
    }
    @IBAction func login(_ sender: Any) {
        print("hello")
    }
    
    func loginAction(){
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON {
                    response in
                    switch (response.result) {
                    case .success:
                        print(response)
                        break
                    case .failure:
                        print(Error.self)
                    }
                }

        
    }
  
}
