//
//  ViewController.swift
//  tutorial_3_cathy
//
//  Created by Cathy Chen on 2020/10/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as UIViewController
            if segue.identifier == "segueToNext" {
                destinationVC.title = "Red"
                destinationVC.view.backgroundColor = UIColor.red
            }
    }
}

