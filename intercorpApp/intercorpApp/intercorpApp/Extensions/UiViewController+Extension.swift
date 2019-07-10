//
//  UiViewController+Extensions.swift
//  iOSTest
//
//  Created by Fabrizio Sposetti on 05/06/2019.
//  Copyright © 2019 D&ATechnologies. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    

    func showToast(message : String, width: CGFloat) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2,
                                               y: self.view.frame.size.height-100,
                                               width: width, height: 35))
        toastLabel.center = self.view.center
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = .black
        self.view.addSubview(activityIndicator)
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
