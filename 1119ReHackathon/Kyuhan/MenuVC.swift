//
//  MenuVC.swift
//  newPro
//
//  Created by Kyuhan Shin on 2017. 11. 11..
//  Copyright © 2017년 Kyuhan Shin. All rights reserved.
//

import UIKit
import Firebase

class MenuVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var Email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        let userEmail = Auth.auth().currentUser?.email
        let userName = userEmail?.split(separator: "@")
        
        name.text = "\(userName![0])님 환영합니다!"
        
        print(userName)
        
        Email.text = userEmail!
        
        
        print(userEmail)
       
    }


}


extension MenuVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "로그아웃"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        try? Auth.auth().signOut()
        
        performSegue(withIdentifier: "goToLogin", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? LoginViewController{
            
            dest.isLogout = true
            
        }
    }
    
}
