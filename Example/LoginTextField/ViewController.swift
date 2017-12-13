//
//  ViewController.swift
//  LoginTextField
//
//  Created by Arda Oğul Üçpınar on 12/13/2017.
//  Copyright (c) 2017 Arda Oğul Üçpınar. All rights reserved.
//

import UIKit
import LoginTextField

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let x = LoginTextField.init(frame: CGRect.zero)
        x.borderStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

