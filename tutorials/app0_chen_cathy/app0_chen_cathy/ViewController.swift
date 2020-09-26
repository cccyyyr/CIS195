//
//  ViewController.swift
//  app0_chen_cathy
//
//  Created by Cathy Chen on 2020/9/11.
//  Copyright © 2020 Cathy Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myButton: UIButton!
    var number = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = number
        // Do any additional setup after loading the view.
    }

    @IBAction func add(_ sender: UIButton) {
        number.append(sender.titleLabel?.text ?? "")
        myLabel.text = number
    }
    
}

