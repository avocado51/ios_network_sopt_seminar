//
//  LoginVC.swift
//  iOS-NetworkSeminar
//
//  Created by Leeseungsoo on 2018. 11. 20..
//  Copyright © 2018년 sopt. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwdTextView: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func login(_ sender: Any) {
        LoginService.shared.login(email : emailTextView.text!, password : passwdTextView.text! ) {(token) in
            print(self.gsno(token.token))
            UserDefaults.standard.set(self.gsno(token.token), forKey: "token")
            
        }
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
   @IBAction func unwindToLoginVC(segue:UIStoryboardSegue){}
    

}
