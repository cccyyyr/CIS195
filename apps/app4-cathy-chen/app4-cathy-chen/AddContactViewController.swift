//
//  AddContactViewController.swift
//  app4-cathy-chen
//
//  Created by Cathy Chen on 2020/10/23.
//

import UIKit
protocol AddContactDelegate: class {
    func didCreate(_ contact: Contact)
    
}
class AddContactViewController: UIViewController {
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    @IBOutlet weak var save: UIBarButtonItem!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var company: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var phoneNum: UITextField!
    weak var delegate: AddContactDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        save.title = "Save"
        cancel.title = "Cancel"
        // Do any additional setup after loading the view.
    }


    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {
        let newContact = createContact()
        if createContact() != nil{
            self.delegate?.didCreate(newContact!)
        }
        dismiss(animated: true, completion: nil)
    }
    func createContact() -> Contact?{
        print("hi")
        if (firstName.hasText) && (lastName.hasText) &&
            (company.hasText) && (email.hasText) && (phoneNum.hasText){
            print("yr")
            return Contact(firstName: firstName.text!, lastName: lastName.text!, company: company.text!, email: email.text!, phoneNum: phoneNum.text!)
        }
        else{
            return nil
        }
    }

}
