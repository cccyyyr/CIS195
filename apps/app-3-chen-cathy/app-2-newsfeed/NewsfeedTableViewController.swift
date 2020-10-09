import UIKit

class NewsfeedTableViewController: UITableViewController {
    
    var newsItems = [NewsItem]()
    
    // MARK: IBAction
    @IBAction func didSelectAdd(_ sender: UIBarButtonItem) {
        // TODO: Present an alert view with a text field. When "Done" is pressed, a new NewsItem should be created and inserted at the START of your array of items, and the table view data should be reloaded
        print("hi")
        let ac = UIAlertController(title: "Enter Title", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {_ in
            print("cancelled")
        }
        let doneAction = UIAlertAction(title: "Done", style: .default) { [unowned ac] _ in
            let answer = ac.textFields![0]
            self.newsItems.append(NewsItem(title: answer.text ?? "Null", favorited: false))
            self.tableView.reloadData()
            
        }

        ac.addAction(doneAction)
        ac.addAction(cancelAction)
        present(ac, animated: true)
        self.tableView.reloadData()
    }

    // MARK: - Basic table view methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: How many sections? (Hint: we have 1 section and x rows)
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: How many rows in our section?
        return newsItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Deque a cell from the table view and configure its UI. Set the label and star image by using cell.viewWithTag(..)
        let cell = tableView.dequeueReusableCell(withIdentifier: "blah", for: indexPath)
        let curr = newsItems[indexPath.row]
        if let label = cell.viewWithTag(1) as? UILabel {
            label.text = curr.title
        }
        if let ima = cell.viewWithTag(2) as? UIImageView{
            if curr.favorited{
                ima.image = UIImage(named: "star-filled")?.withRenderingMode(.alwaysTemplate)
            }else{
                ima.image = UIImage(named: "star-hollow")?.withRenderingMode(.alwaysTemplate)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    // MARK: - Handle user interaction
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Deselect the cell, and toggle the "favorited" property in your model
        newsItems[indexPath.row].favorited.toggle()
        self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Swipe to delete functionality
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // TODO: If the editing style is deletion, remove the newsItem from your model and then delete the rows. CAUTION: make sure you aren't calling tableView.reloadData when you update your model -- calling both tableView.deleteRows and tableView.reloadData will make the app crash.
        if editingStyle == .delete {
                newsItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        
    }

}

