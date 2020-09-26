//
//  ViewController.swift
//  tutorial2_chen_cathy
//
//  Created by Cathy Chen on 2020/9/18.
//  Copyright © 2020 Cathy Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad()")
        // Do any additional setup after loading the view.
        // Only do it once, unlike willAppear etc.
        // The content view is not necessarily created when the controller is first instantiated. Instead, it is lazily created the first time the system or any code accesses the controller’s view property.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear()")
        //Catch my view up to the changes (changes to data and such) when i was off-screen.

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear()")
        //Stuff like start a timer or start observing stuff (GPS)
        //Start doing expensive things like loading a picture off of network; give the spinning wheel thing and also give the option to go back, so we can load in the backgroud.
        // SO appear or not? different during video and document
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear()")
        //Undo what i did in viewDidAppear. Like stop observing GPS etc.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear()")
        //Clean up mvc and clean memmory up. 
    }
    //It goes in the order viewDidLoad -> viewWillAppear -> viewDidAppear -> viewWillDisAppear -> willDidDisappear.
}

