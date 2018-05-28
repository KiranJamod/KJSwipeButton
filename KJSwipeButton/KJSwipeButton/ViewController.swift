//
//  ViewController.swift
//  KJSwipeButton
//
//  Created by Artifex on 28/05/18.
//  Copyright © 2018 Artifex. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KJSwipeButtonDelegate {

    @IBOutlet weak var viewOfSwitch: KJSwipeButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewOfSwitch.thumbOnTintColor = UIColor.darkGray
        viewOfSwitch.thumbOffTintColor = UIColor.darkGray
        
        viewOfSwitch.trackOnTintColor = UIColor.green
        viewOfSwitch.trackOffTintColor = UIColor.gray
        
        viewOfSwitch.thumbDisabledTintColor = UIColor.gray.withAlphaComponent(0.5)
        viewOfSwitch.trackDisabledTintColor = UIColor.gray.withAlphaComponent(0.5)
        
        viewOfSwitch.setStateOfView(isOn: true)
        
        viewOfSwitch.delegate = self
        
    }
    
    func busttonStatusChange(status: Bool) {
        print("\(status)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

