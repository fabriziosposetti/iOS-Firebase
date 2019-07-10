//
//  ViewController.swift
//  intercorpApp
//
//  Created by Fabrizio Sposetti on 04/07/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Textos.Login.description
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.localizedDescription)
        } else  if result.isCancelled {
            // usuario canceló
            return
        } else {
            let viewController: UIViewController = UIStoryboard(name: Storyboards.Main, bundle: nil)
                .instantiateViewController(withIdentifier: "altaCliente") as! AltaClienteViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
         // usuario deslogueado
    }
    
    
}
