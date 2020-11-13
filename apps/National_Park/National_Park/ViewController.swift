//
//  ViewController.swift
//  National_Park
//
//  Created by Cathy Chen on 2020/11/13.
//

import UIKit

class ViewController: UIViewController {
    var park: Park? = nil
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desig: UILabel!
    @IBOutlet weak var descrip: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if park?.images.count ?? 0 > 0{
            img.kf.setImage(with: URL(string: park!.images[0].url))
        } else{
            img = UIImageView(image: UIImage(systemName: "film"))
        }
        name.text = park?.name
        desig.text = park?.designation
        descrip.text = park?.description
        desig.textColor = .systemOrange
    }


}

