//
//  UiToolbar+Extension.swift
//  intercorpApp
//
//  Created by Fabrizio Sposetti on 05/07/2019.
//  Copyright © 2019 Fabrizio Sposetti. All rights reserved.
//

import UIKit


extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "OK",
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
