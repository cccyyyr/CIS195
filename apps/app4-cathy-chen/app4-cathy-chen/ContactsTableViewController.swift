//
//  ContactsTableViewController.swift
//  app4-cathy-chen
//
//  Created by Cathy Chen on 2020/10/23.
//

import UIKit

class ContactsTableViewController: UITableViewController, AddContactDelegate {
    
    
    let myself = Contact(firstName: "Cathy", lastName: "Chen", company: "Penn", email: "blahh@gmail.com", phoneNum: "5128390522")
    let myFriend = Contact(firstName: "Hi", lastName: "Hello", company: "Penn", email: "bloop@gmail.com", phoneNum: "1112223333")
    var idx: Int = -1
    var contactList:[Contact] = []
    func didCreate(_ contact: Contact) {
        contactList.append(contact)
        contactList.sort(by: { (x, y) -> Bool in
            x.lastName < y.lastName
        })
        self.tableView.reloadData()
        
    }
    @IBOutlet weak var addContact: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactList.append(myself)
        contactList.append(myFriend)
        
    }
    
    @IBAction func add_contact(_ sender: Any) {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Deque a cell from the table view and configure its UI. Set the label and star image by using cell.viewWithTag(..)
        let cell = tableView.dequeueReusableCell(withIdentifier: "blah", for: indexPath)
        let curr = contactList[indexPath.row]
        if let label = cell.viewWithTag(2) as? UILabel {
            label.text = curr.firstName + " " + curr.lastName
        }
        
        cell.detailTextLabel!.text = curr.company
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    // MARK: - Handle user interaction
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            guard let DVC = segue.destination as? DetailViewController,
                let index = tableView.indexPathForSelectedRow?.row
                else {
                    return
            }
            DVC.contact = contactList[index]
        } else if segue.identifier == "toAdd"{
            guard let AVC = segue.destination as? UINavigationController,
                  let ACVC = AVC.topViewController as?
                    AddContactViewController
                else{
                    return
            }
            ACVC.delegate = self
        }
    }

}
