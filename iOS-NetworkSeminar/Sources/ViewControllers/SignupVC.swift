//
//  SignupVC.swift
//  iOS-NetworkSeminar
//
//  Created by Leeseungsoo on 2018. 11. 20..
//  Copyright © 2018년 sopt. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var emailTxtView: UITextField!
    @IBOutlet weak var passwdTxtView: UITextField!
    @IBOutlet weak var nameTxtView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signup(_ sender: Any) {
        UserService.shared.signUp(name: nameTxtView.text!, email: emailTxtView.text!, password: passwdTxtView.text!, part: "iOS"){print("회원가입완료")}
        
    }
    
}
