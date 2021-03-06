import UIKit
import Firebase
import FirebaseDatabase

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
            
            if error != nil {return}
            
            let uid = user?.uid
            let image = UIImageJPEGRepresentation(self.imageView.image!, 0.1)
            
            Storage.storage().reference().child("userImages").child(uid!).putData(image!, metadata: nil, completion: { (data, error) in
                
                let imageUrl = data?.downloadURL()?.absoluteString
                let values = ["username": self.emailtextField.text!, "profileImageURL":imageUrl, "uid": Auth.auth().currentUser?.uid]
                
                Database.database().reference().child("users").setValue(values, withCompletionBlock: { (err, ref) in
                    
                    if(err == nil) {
                        
                        self.dismiss(animated: true, completion: nil)
                        let alert = UIAlertController(title: "알림", message: "회원가입 완료", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (_) in
                            self.performSegue(withIdentifier: "goToMain2", sender: nil)
                        }))
                        
                        self.present(alert, animated: true){
                            self.performSegue(withIdentifier: "goToMain2", sender: nil)
                        }
                    }
                })
            })
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
