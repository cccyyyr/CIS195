//
//  DetailViewController.swift
//  app4-cathy-chen
//
//  Created by Cathy Chen on 2020/10/23.
//

import UIKit

class DetailViewController: UIViewController {
    var contact: Contact? = nil

    @IBOutlet weak var pfp: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var phone: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (contact != nil){
            firstName.text = contact!.firstName
            lastName.text = contact!.lastName
            company.text = contact!.company
            phone.text = contact!.company
            email.text = contact!.email
        }
    }


}
