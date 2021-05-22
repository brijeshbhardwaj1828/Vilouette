//
//  ForgetPasswordVC.swift
//  EcomApp
//
//  Created by MDR SOFTECH on 20/05/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var btnSubmeet: UIButton!
    @IBOutlet weak var txtUserName: UITextField!
    
//    let parameters = [
//            "username": "t1est1@gmail.com",
//        ]
        let url = "http://vilouette.krewtechnologies.com/account/Api/forgotPassword"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitAction(_ sender: Any) {
        resetPasswordAction()
    }
    
    func resetPasswordAction(){
        
        let parameters = [
            "username": txtUserName.text
        ] as? [String:String]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON {
                    response in
                    switch (response.result) {
                    case .success(let value):
                      //  print(response)
                        let json = JSON(value)
                        print(json)
                        if let msg = json["error_msg"].string{
                            print(msg)
                       
                        
                        // the alert view
                        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)

                        // change to desired number of seconds (in this case 5 seconds)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                          // your code with delay
                          alert.dismiss(animated: true, completion: nil)
                       // }
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
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
