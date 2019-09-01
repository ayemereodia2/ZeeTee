//
//  RegisterVC.swift
//  ZeeTee
//
//  Created by mac on 8/13/19.
//  Copyright © 2019 wox1. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {

    @IBOutlet weak var confirmPassText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var confirmPassCheckImage: UIImageView!
    @IBOutlet weak var passImageCheck: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        passwordText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPassText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
    }
    
    @objc func textFieldDidChange(_ textField:UITextField){
        
        guard let passTxt = passwordText.text else{return}

        if textField == confirmPassText {
            passImageCheck.isHidden = false
            confirmPassCheckImage.isHidden = false
            
        }else {
            if passTxt.isEmpty {
                passImageCheck.isHidden = true
                confirmPassCheckImage.isHidden = true
                confirmPassText.text = ""
            }
        
            
        }
        
        
        // when password match, turn checkmark green
        if passwordText.text == confirmPassText.text{
        
            passImageCheck.image = UIImage(named: AppImages.GreenCheck)
            confirmPassCheckImage.image = UIImage(named: AppImages.GreenCheck)
           

        }else{
            passImageCheck.image = UIImage(named: AppImages.RedCheck)
            confirmPassCheckImage.image = UIImage(named: AppImages.RedCheck)

        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func registerClicked(_ sender: Any) {
        
        guard let email = emailText.text, email.isNotEmpty,
            let username = userNameText.text, username.isNotEmpty,
            let password = passwordText.text, password.isNotEmpty else {
                return
        }
        
        activityIndicator.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // ...
            if let error = error {
                debugPrint(error)
                return
            }
            self.activityIndicator.stopAnimating()
            print("succesfully registered new user!")
        }
        
    }
    

}
