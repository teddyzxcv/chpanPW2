//
//  SettingsViewController.swift
//  chpanPW2
//
//  Created by HSE  FKN on 01.10.2021.
//

import UIKit
import CoreLocation

final class SettingsViewController: UIViewController {
    private var location = ""
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsView()
        setupLocationToggle()
        setupCloseButton()
        title = "Settings"
        view.backgroundColor = .blue
    }

    private func setupCloseButton() {
        let button = UIButton(type: .close)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
            constant: -10
        ).isActive = true
        button.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 200
        ).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
    }

    @objc
    private func closeScreen() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    private func setupSettingsView() {
        let locationLabel = UILabel()

        view.addSubview(locationLabel)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 120
        ).isActive = true
        locationLabel.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 10
        ).isActive = true
        locationLabel.trailingAnchor.constraint(
            equalTo: locationLabel.trailingAnchor,
            constant: -10
        ).isActive = true
    }

    private func setupLocationToggle(){
        let locationToggle = UISwitch()
        view.addSubview(locationToggle)

        locationToggle.backgroundColor = .green
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant:120
        ).isActive = true
        locationToggle.trailingAnchor.constraint(
            equalTo: view.trailingAnchor,
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
            location = ""
            locationManager.stopUpdatingLocation()
        }
    }
    
}

extension SettingsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        location = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}
