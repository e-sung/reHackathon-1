//
//  LoginViewController.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var emailtextField : UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "goToMain1", sender: nil)
            }
        }
    }
    
    
    
    // MARK: 로그인 버튼 이벤트 구현
    
    @IBAction func loginPressed(_ sender : Any) {
        
        if let email = emailtextField.text, email != "", let password = passwordTextField.text, password != "" {
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
                if(err != nil){
                    let alert = UIAlertController(title: "에러",
                                                  message: err.debugDescription, preferredStyle:UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default,
                                                  handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    self.performSegue(withIdentifier: "goToMain1", sender: nil)
                    
                }
            }
            
        }
    }

    
}
