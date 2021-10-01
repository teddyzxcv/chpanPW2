//
//  ViewController.swift
//  chpanPW2
//
//  Created by HSE  FKN on 01.10.2021.
//

import UIKit

class ViewController: UIViewController {
    private let settingsView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSettingsView()
        setupSettingsButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    private func setupSettingsView(){
        self.view.addSubview(settingsView)
        settingsView.backgroundColor = .red
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 10
        ).isActive = true
        settingsView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -10
        ).isActive = true
        settingsView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        settingsView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        settingsView.alpha = 0
    }
    
    private func setupSettingsButton(){
        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("settings", for: .normal)
        settingsButton.setImage(
            UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal),
            for: .normal)
        
        self.view.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 15
        ).isActive = true
        settingsButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -15
        ).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor).isActive = true
        
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed),
                                 for: .touchUpInside)
    }
    
    @objc
    private func settingsButtonPressed(){
        UIView.animate(withDuration: 0.1, animations: {
            self.settingsView.alpha = 1 - self.settingsView.alpha
        })
    }
}

