//
//  SplashViewController.swift
//  1119ReHackathon
//
//  Created by 황재욱 on 2017. 11. 19..
//  Copyright © 2017년 황재욱. All rights reserved.
//

import UIKit
import LTMorphingLabel
import SnapKit


class SplashViewController: UIViewController {
    
    // MARK : - UI
    
    @IBOutlet weak var spMessages: LTMorphingLabel!
    var snowingLogo: UIImageView = {
        
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        logo.image = #imageLiteral(resourceName: "if_snow-2_110818")
        
        return logo
        
    }()
    
    // MARK : - Properties
    
    let LOGIN_SEGUE = "goToLogin"
    
    var timer = Timer()
    var textArray: [String] = ["추운 겨울을", "따뜻하게 만들어 줄", "당신을 위한 앱", "ENTER THE WINTER"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(snowingLogo)
        setConstraintsLogo()
        
        snowingLogo.center.x -= self.view.center.x
        
        
        UIView.animate(withDuration: 3) {
            self.snowingLogo.center.x += self.view.center.x
            
            self.snowingLogo.alpha = 0
        }
        
        
        ltFallingMessageEvent()
        
    }
    
    
    // 로고 제약조건 함수
    func setConstraintsLogo(){
        
        snowingLogo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(self.view.frame.width / 3)
            make.height.equalTo(self.view.frame.height / 4)
            
        }
        
    }
    
    // LT 메세지 스플래시 효과
    
    func ltFallingMessageEvent(){
        
        var i = 0
        
        self.spMessages.morphingEffect = .fall
        self.spMessages.morphingDuration = 4
        
        timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true){_ in
            if i <= 3{
                self.spMessages.text = self.textArray[i]
                i += 1
                if i == 3{
                    self.spMessages.textColor = #colorLiteral(red: 0.9040181041, green: 0.1651062369, blue: 0.309209466, alpha: 1)
                    self.spMessages.text = self.textArray[i]
                    i += 1
                }
                
            }else{
                self.timer.invalidate()
                self.spMessages.text = ""
                self.performSegue(withIdentifier: self.LOGIN_SEGUE, sender: nil)
            }
        }
    }
    
    
    // 스플래시 화면 스킵하기
    @IBAction func skipBtnTapped(_ sender: UIButton){
        
        self.performSegue(withIdentifier: self.LOGIN_SEGUE, sender: nil)
        
    }

    

}
