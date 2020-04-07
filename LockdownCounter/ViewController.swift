//
//  ViewController.swift
//  LockdownCounter
//
//  Created by Samuel Miller on 30/03/2020.
//  Copyright © 2020 RHM Computing. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

class ViewController: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
    @IBOutlet weak var counterLabel: UILabel!
    
    var locationManager = CLLocationManager()
    
    var notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.double(forKey: "homeLat") == 0.0 && UserDefaults.standard.double(forKey: "homeLon") == 0.0 && UserDefaults.standard.bool(forKey: "warnings"){
            
            performSegue(withIdentifier: "firstLaunch", sender: nil) // open splash screen
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counterLabel.text = String(describing: GlobalData.Data.days) + " days in lockdown"

        if UserDefaults.standard.double(forKey: "homeLat") != 0.0 && UserDefaults.standard.double(forKey: "homeLon") != 0.0 && CLLocationManager.authorizationStatus() != .denied && UserDefaults.standard.bool(forKey: "warnings"){
            
            // MARK: - Location Stuff
            if UserDefaults.standard.bool(forKey: "warnings") {
                notificationCenter.delegate = self
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()

            
                /*
                if UserDefaults.standard.double(forKey: "homeLat") == 0.0 && UserDefaults.standard.double(forKey: "homeLon") == 0.0 {
                    UserDefaults.standard.setValue(locationManager.location?.coordinate.latitude,
                                                   forKeyPath: "homeLat")
                    
                    UserDefaults.standard.setValue(locationManager.location?.coordinate.longitude,
                                                   forKeyPath: "homeLon")
        
                }
 */
                
                let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude:
                    UserDefaults.standard.double(forKey: "homeLat") as CLLocationDegrees,
                                                                             longitude:
                    UserDefaults.standard.double(forKey: "homeLon") as CLLocationDegrees),
                                              radius: 40,
                                              identifier: "Home")
                
                region.notifyOnExit = true
                region.notifyOnEntry = false
                locationManager.startMonitoring(for: region)
                
                let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
                
                let content = UNMutableNotificationContent()
                
                content.title = "Warning"
                content.body  = "Keep your social distance"
                content.sound = UNNotificationSound.default
                content.badge = 1
                
                
                let identifier = "warningNotification"
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

                notificationCenter.add(request) { (error) in
                    if let error = error {
                        print("Error \(error.localizedDescription)")
                    }
                }
                
                if !region.contains(locationManager.location!.coordinate) {
                    counterLabel.textColor = .systemRed
                }
                
        
            }
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            UserDefaults.standard.setValue(false, forKey: "warnings")
        } else if status == .authorizedAlways || status == .authorizedWhenInUse {
            UserDefaults.standard.setValue(true, forKey: "warnings")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        UserDefaults.standard.setValue(CLLocationManager().location?.coordinate,
                                       forKeyPath: "homeCoords")
    }
    
/*
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }


}

