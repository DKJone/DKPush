//
//  ViewController.swift
//  DKPush
//
//  Created by DKJone on 05/30/2019.
//  Copyright (c) 2019 DKJone. All rights reserved.
//

import DKPush
import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        JPUSHService.setAlias("22", completion: { _, _, _ in }, seq: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
