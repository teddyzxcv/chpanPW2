//
//  ViewController.swift
//  chpanPW2
//
//  Created by HSE  FKN on 01.10.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private let settingsView = UIView()
    private let locationTextView = UITextView()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSettingsView()
        setupSettingsButton()
        setupLocationTextView()
        setupLocationToggle()
        setupLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    private func setupSettingsButton(){
        let settingsButton = UIButton(type: .system)
        
        settingsButton.setTitle("options", for: .normal)
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
    
    private func setupSettingsView(){
        view.addSubview(settingsView)
        
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
    
    private func setupLocationTextView(){
        view.addSubview(locationTextView)
        
        locationTextView.backgroundColor = .white
        locationTextView.layer.cornerRadius = 20
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        locationTextView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 60
        ).isActive = true
        locationTextView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
        ).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        locationTextView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 15
        ).isActive = true
        locationTextView.isUserInteractionEnabled = false
        view.sendSubviewToBack(locationTextView)
    }
    
    private func setupLocationToggle(){
        let locationToggle = UISwitch()
        settingsView.addSubview(locationToggle)
        
        locationToggle.backgroundColor = .green
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.topAnchor.constraint(
            equalTo: settingsView.topAnchor,
            constant:50
        ).isActive = true
        locationToggle.trailingAnchor.constraint(
            equalTo: settingsView.trailingAnchor,
            constant: -10
        ).isActive = true
        locationToggle.addTarget(
            self,
            action: #selector(locationToggleSwitched),
            for: .valueChanged
        )
    }
    
    @objc
    func locationToggleSwitched(_ sender: UISwitch){
        if sender.isOn {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                sender.setOn(false, animated: true)
            }
        } else {
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
    }
    
    private func setupLocationManager(){
        let locationLabel = UILabel()
        settingsView.addSubview(locationLabel)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(
            equalTo: settingsView.topAnchor,
            constant: 10
        ).isActive = true
        locationLabel.leadingAnchor.constraint(
            equalTo: settingsView.leadingAnchor,
            constant: 10
        ).isActive = true
        locationLabel.trailingAnchor.constraint(
            equalTo: locationLabel.trailingAnchor,
            constant: -10
        ).isActive = true
    }
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}

