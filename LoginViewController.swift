//
//  LoginViewController.swift
//  EcomApp
//
//  Created by MDR SOFTECH on 20/05/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var cusId = String()
    
    let parameters = [
            "username": "t1est1@gmail.com",
            "password": "1234578"
        ]

    
        let url = "http://vilouette.krewtechnologies.com/account/Api/login"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func login(_ sender: Any) {
        print("hello")
        loginAction()
    }
    
    func loginAction(){
        
//        let parameters = [
//            "username": txtUserName.text,
//            "password": txtPassword.text
//        ] as? [String:String]
//
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON {
                    response in

                    switch (response.result) {

                    case .success(let value):
                      //  print(response)
                        let json = JSON(value)
                        print(json)
                        if let msg = json["Message"].string{
                            print(msg)
                            if let customerId = json["customerID"].string{
                                
                                self.cusId = customerId
                            }
                            
                            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                                                    self.present(alert, animated: true, completion: nil)
                                                    let when = DispatchTime.now() + 2
                                                    DispatchQueue.main.asyncAfter(deadline: when){
                                                      alert.dismiss(animated: true, completion: nil)
           let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                                                        
                                                        vc?.custId = self.cusId
                    self.navigationController?.pushViewController(vc!, animated: true)
                                                }
                            
                        }
                        break
                    case .failure:
                        print(Error.self)
                    }
                }
        
     
    }
  
}
