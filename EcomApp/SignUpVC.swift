//
//  SignUpVC.swift
//  EcomApp
//
//  Created by MDR SOFTECH on 20/05/21.
//

import UIKit
import Alamofire
import SwiftyJSON
class SignUpVC: UIViewController {
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
//    let parameters = [
//            "email": "t1est1@gmail.com",
//            "password": "1234578",
//            "confirm_password": "1234578",
//            "name": "hbvjg1212",
//            "phone": "546514923"
//        ]
        let url = "http://vilouette.krewtechnologies.com/account/Api/signUp"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupPressed(_ sender: Any) {
        signUpAction()
    }
    func signUpAction(){
        
        let parameters = [
            "email": txtEmail.text,
            "password": txtPassword.text,
            "confirm_password": txtConfirmPassword.text,
            "name": txtName.text,
            "phone": txtPhone.text
        ] as? [String:String]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).responseJSON {
                    response in
                    switch (response.result) {
                    case .success(let value):
                       // print(response)
                        
                        let json = JSON(value)
                        print(json)
                        if let msg = json["Message"].string{
                            print(msg)
                        
                        // the alert view
                        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)

                        // change to desired number of seconds (in this case 5 seconds)
                        let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                          // your code with delay
                          alert.dismiss(animated: true, completion: nil)
                        //}
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
