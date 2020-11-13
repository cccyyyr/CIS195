//
//  TableList.swift
//  National_Park
//
//  Created by Cathy Chen on 2020/11/13.
//

import UIKit
import Kingfisher
import Firebase

struct Img: Codable {
    var credit: String?
    var altText: String?
    var title: String?
    var caption: String?
    var url: String
    private enum CodingKeys: String, CodingKey {
        case url
    }
}
struct Park: Codable {
    var activities: String?
    var addresses: String?
    var contacts: String?
    var description: String
    var designation: String
    var directionalUrl: URL?
    var entranceFees: String?
    var entrancePasses: String?
    var fullName: String?
    var id: String?
    var images: [Img]
    var latLong: String?
    var latitude: String?
    var longitude: String?
    var name: String
    var operatingHours: String?
    var parkCode: String?
    var states: String?
    var topics: String?
    var url: String?
    var weatherInfo: String?
    private enum CodingKeys: String, CodingKey {
        case name, description, designation, images
    }
    
}
struct OG: Codable {
    var total: String?
    var data: [Park]
    var limit: String?
    var start: String?
    private enum CodingKeys: String, CodingKey {
        case data
    }
}
class TableViewController: UITableViewController {
    
    var parks = [Park]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
//      I commented out because it's already in the database
//        loadData()
        fetchDb()
    }
    @objc func refresh(sender:AnyObject)
    {
        fetchDb()
        self.refreshControl?.endRefreshing()
    }
    let db = Firestore.firestore()
    private func fetchDb(){
        for i in 0...29 {
            let docRef = self.db.collection("parks").document("\(i)")
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    var curr_image: [Img] = []
                    if let imgUrl = document.get("image") as? String{
                        let img = Img(credit: nil, altText: nil, title: nil, caption: nil, url: imgUrl)
                        curr_image = [img]
                    }
                    let name = document.get("name") as! String
                    let descri = document.get("description") as! String
                    let desg = document.get("designation") as! String
                    let p = Park(activities: nil, addresses: nil, contacts: nil, description: descri, designation: desg, directionalUrl: nil, entranceFees: nil, entrancePasses: nil, fullName: nil, id: nil, images: curr_image, latLong: nil, latitude: nil, longitude: nil, name: name, operatingHours: nil, parkCode: nil, states: nil, topics: nil, url: nil, weatherInfo: nil)
                    self.parks.append(p)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("can't find document \(i)")
                }
            }
        }
       
    }
        
    private func loadData() {
        let urlString = "https://developer.nps.gov/api/v1/parks?limit=30&api_key=Yq1Cl4tGpBXRtkTvw7lcMFlzxbuitecpg1ew3ksm"
        guard let url = URL(string: urlString) else { return }
        print("here")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                      error == nil else {
                      print(error?.localizedDescription ?? "Response Error")
                      return }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                var curr = 0
                let jsonArray = jsonResponse["data"] as! [[String: Any]]
                    for p in jsonArray{
                        let simplified:NSMutableDictionary = ["dummy": 1]
                        simplified["name"] = p["name"]
                        guard let allImage = p["images"] as? [[String: Any]] else {return}
                        if allImage.count > 0{
                            simplified["image"]=allImage[0]["url"]
                        } else {
                            simplified["image"]=nil
                        }
                        simplified["designation"] = p["designation"]
                        simplified["description"] = p["description"]
                        self.db.collection("parks").document("\(curr)").setData(simplified as! [String : Any])
                        curr += 1
                    }
            } catch let parsingError {
                    print("Error", parsingError)
            }
        }
        task.resume()
//                if let decodedData = try? JSONDecoder().decode(OG.self, from: data) {
//                    self.parks = decodedData.data
//
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//
//                }else{
//                    print("failed with decode")
//                }
        }
            
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let park = parks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkCell")!
        if let name = cell.viewWithTag(1) as? UILabel {
            name.text = park.name
        }
        if let desi = cell.viewWithTag(2) as? UILabel {
            desi.text = park.designation
        }
        if var pic = cell.viewWithTag(3) as? UIImageView {
            if park.images.count > 0{
                pic.kf.setImage(with: URL(string: park.images[0].url))
            } else{
                pic = UIImageView(image: UIImage(systemName: "film"))
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            guard let VC = segue.destination as? ViewController,
                let index = tableView.indexPathForSelectedRow?.row
                else {
                    return
            }
            VC.park = parks[index]
        }
    }

}
