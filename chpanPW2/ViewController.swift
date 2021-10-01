//
//  ViewController.swift
//  chpanPW2
//
//  Created by HSE  FKN on 01.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    private func setupSettingsButton(){
        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("options", for: .normal)
        
    }
}

