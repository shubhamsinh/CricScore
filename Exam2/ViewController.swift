//
//  ViewController.swift
//  Exam2
//
//  Created by Shubhamsinh Rahevar on 22/02/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }
                else{
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                    UserDefaults.standard.set(email, forKey: "email")
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        emailTextField.layer.cornerRadius = 50
        loginButton.layer.cornerRadius = 25
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "email") != nil{
            performSegue(withIdentifier: "goToHome", sender: self)
        }
        
    }
    
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 0.0/255.0, green: 100/255.0, blue: 150/100, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0.0/255.0, green: 180/255.0, blue: 255.0/200.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}

