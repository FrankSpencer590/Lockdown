//
//  SplashScreenViewController.swift
//  LockdownCounter
//
//  Created by Samuel Miller on 02/04/2020.
//  Copyright © 2020 RHM Computing. All rights reserved.
//

import UIKit
import CoreLocation

class SplashScreenViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var inHouseButton: UIButton!
    @IBOutlet weak var outHouseButton: UIButton!
    @IBOutlet weak var dontShowButton: UIButton!
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inHouseButton.layer.cornerRadius = 10
        outHouseButton.layer.cornerRadius = 10
        dontShowButton.layer.cornerRadius = 10
        
        
    }
    @IBAction func inHousePressed(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        
    }
    @IBAction func dontShowPressed(_ sender: Any) {
        UserDefaults.standard.setValue(false, forKey: "warnings")
        
        self.dismiss(animated: true) {
            //
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            UserDefaults.standard.setValue(locationManager.location?.coordinate.latitude,
                                           forKeyPath: "homeLat")
            
            UserDefaults.standard.setValue(locationManager.location?.coordinate.longitude,
                                           forKeyPath: "homeLon")
        } else if status == .denied {
            UserDefaults.standard.setValue(false, forKey: "warnings")
        }
        
        self.dismiss(animated: true) {
            //
        }
    }
    
    @IBAction func outHousePressed(_ sender: Any) {
        self.dismiss(animated: true) {
            //
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
