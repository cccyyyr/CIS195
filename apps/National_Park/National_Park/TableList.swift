//
//  TableList.swift
//  National_Park
//
//  Created by Cathy Chen on 2020/11/13.
//

import UIKit
import Kingfisher

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
        fetchParks()
    }
    
    private func fetchParks() {
        let urlString = "https://developer.nps.gov/api/v1/parks?limit=30&api_key=Yq1Cl4tGpBXRtkTvw7lcMFlzxbuitecpg1ew3ksm"
        guard let url = URL(string: urlString) else { return }
        print("here")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                print("fetching")
                if let decodedData = try? JSONDecoder().decode(OG.self, from: data) {
                    self.parks = decodedData.data
                    print("fetched")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    //TO DO: loading sign
                }else{
                    print("failed with decode")
                }
            }
        }
        
        task.resume()
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
