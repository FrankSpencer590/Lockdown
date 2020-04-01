//
//  ViewController.swift
//  LockdownCounter
//
//  Created by Samuel Miller on 30/03/2020.
//  Copyright © 2020 RHM Computing. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let isoDate = "2020-03-23T00:00:00+0000"

        let dateFormatter = ISO8601DateFormatter()
        let startDate = dateFormatter.date(from:isoDate)!
        let currentDate = Date()
        
        let secondsSince = currentDate.timeIntervalSince(startDate)
        let daysSince = secondsSince / 60 / 60 / 24
        
        counterLabel.text = String(describing: Int(floor(daysSince))) + " days in lockdown"
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}

