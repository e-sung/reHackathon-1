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
    
    
    // 스플래시 화면 스킵하기
    @IBAction func skipBtnTapped(_ sender: UIButton){
        
        self.performSegue(withIdentifier: self.LOGIN_SEGUE, sender: nil)
        
    }

    

}
