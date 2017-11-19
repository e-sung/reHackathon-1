//
//  SignUpViewController.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var emailtextField : UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let action = UITapGestureRecognizer(target: self, action: #selector(selectProfilePhoto))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(action)
        
    }
    
    
    
   
    
    
    
    
    
    @IBAction func creatButtonPressed(_ sender : Any) {
        
        Auth.auth().createUser(withEmail: emailtextField.text!, password: passwordTextField.text!){
            (user, error) in
            
            print(error)
            if error != nil {return}
            
            
            let alert = UIAlertController(title: "알림", message: "회원가입 완료", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
                self.performSegue(withIdentifier: "goToMain2", sender: nil)
            }))
            
            
            self.present(alert, animated: true){
                self.performSegue(withIdentifier: "goToMain2", sender: nil)
            }
            
            
        }
        
    }

}

// MARK: 이미지 픽커뷰 구성

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func selectProfilePhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
}
