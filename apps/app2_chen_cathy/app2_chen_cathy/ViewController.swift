//
//  ViewController.swift
//  app2_chen_cathy
//
//  Created by Cathy Chen on 2020/9/18.
//  Copyright © 2020 Cathy Chen. All rights reserved.
//
//  ViewController.swift
//  app2_chen_cathy
//
//  Created by Cathy Chen on 2020/9/18.
//  Copyright © 2020 Cathy Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var b4: UIButton!
    @IBOutlet weak var b5: UIButton!
    @IBOutlet weak var b6: UIButton!
    @IBOutlet weak var b7: UIButton!
    @IBOutlet weak var b8: UIButton!
    @IBOutlet weak var b9: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var ttt: UILabel!
    @IBOutlet var allButtons: [UIButton]!
//    var gb = GameBoard()
    var xInputs: [Int] = []
    var oInputs: [Int] = []
    var xTurn = true {
        didSet {
            if xTurn{
                status.text = "It's player 1's turn"
            } else {
                status.text = "It's player 2's turn"
            }
        }
    }
    var oHasWon = false {
        didSet {
            if oHasWon  {
                inGame = false
                status.text = "Player 2 has won!"
                if let text = score2.text, let value = Int(text) {
                    score2.text = String(value + 1)
                }
            }
        }
    }
    var xHasWon = true {
        didSet {
            if xHasWon  {
                inGame = false
                status.text = "Player 1 has won!"
                if let text = score1.text, let value = Int(text) {
                    score1.text = String(value + 1)
                }
            }
        }
    }
    var inGame = true {
        didSet {
            if inGame  {
                for button in allButtons! {
                    button.setImage(UIImage(named: "mark-none"),for:.normal)
                    button.tintColor = .systemBlue
                }
                oInputs.removeAll()
                xInputs.removeAll()
                occupied.removeAll()
                xHasWon = false
                oHasWon = false
                xTurn = true
            }
        }
    }
    var occupied: [Int] = [] {
        didSet{
            if occupied.count == 9 && inGame {
                status.text = "Draw!"
                inGame = false
                for button in allButtons! {
                    button.tintColor = .systemGray
                }
            }
        }
    }
    let winning = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 2, 3], [2, 5, 8], [3, 6, 9], [3, 5, 7], [1, 5, 9]]
    let markedO = UIImage(named: "mark-o")?.withRenderingMode(.alwaysTemplate)
    let markedX = UIImage(named: "mark-x")?.withRenderingMode(.alwaysTemplate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        b1.tag = 1
        b2.tag = 2
        b3.tag = 3
        b4.tag = 4
        b5.tag = 5
        b6.tag = 6
        b7.tag = 7
        b8.tag = 8
        b9.tag = 9
        score1.text = String(0)
        score2.text = String(0)
        allButtons = allButtons.sorted(by: { (x, y) -> Bool in
            x.tag < y.tag
        })
        print(allButtons.count)
    }
    @IBAction func press(_ sender: UIButton) {
        if (inGame && !occupied.contains(sender.tag)){
            if xTurn{
                sender.setImage(markedX, for: .normal)
                xInputs.append(sender.tag)
                check(xInputs)
            } else {
                sender.setImage(markedO,for:.normal)
                oInputs.append(sender.tag)
                check(oInputs)
            }
            occupied.append(sender.tag)
        }
    }
    func check(_ inputs: [Int]){
        for ec in winning{
            var yes = 0
            for i in ec{
                if inputs.contains(i){
                    yes += 1
                }
            }
            if yes == 3{
                for x in ec{
                    allButtons[x-1].tintColor = .systemYellow
                }
                if xTurn{
                    xHasWon = true
                } else {
                    oHasWon = true
                }
                return
            }
        }
        xTurn = !xTurn
        return
    }
    
    @IBAction func clear(_ sender: UIButton) {
        inGame = true
    }
}
//struct GameBoard {
//    var allButtons: [UIButton]!
//
//    var xInputs: [Int] = []
//    var oInputs: [Int] = []
//    var xTurn = true
//    var oHasWon = false
//    var xHasWon = true
//    var inGame = true
//    var occupied: [Int] = []
//    var status = ""
//    let winning = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 2, 3], [2, 5, 8], [3, 6, 9], [3, 5, 7], [1, 5, 9]]
//    let markedO = UIImage(named: "mark-o")?.withRenderingMode(.alwaysTemplate)
//    let markedX = UIImage(named: "mark-x")?.withRenderingMode(.alwaysTemplate)
//    func check(_ inputs: [Int]) -> (Bool, [Int]) {
//        for ec in winning{
//            var yes = 0
//            for i in ec{
//                if inputs.contains(i){
//                    yes += 1
//                }
//            }
//            if yes == 3{
//                return (true, ec)
//            }
//        }
//        return (false, [])
//    }
//    mutating func newGame(_ buttons: [UIButton]) {
//        for button in buttons {
//            button.setImage(UIImage(named: "mark-none"),for:.normal)
//            button.tintColor = .systemBlue
//            oInputs.removeAll()
//            xInputs.removeAll()
//            occupied.removeAll()
//            xHasWon = false
//            oHasWon = false
//            inGame = true
//            xTurn = true
//            status = "It's player 1's turn"
//        }
//    }
//
//    func checkForX() -> (Bool, [Int]){
//        return check(xInputs)
//    }
//    func checkForO() -> (Bool, [Int]){
//        return check(oInputs)
//    }
//    mutating func buttonClicked(_ clicked: Int){
//        if (inGame && !occupied.contains(clicked)){
//            occupied.append(clicked)
//            if xTurn{
//                sender.setImage(markedX, for: .normal)
//
//            }else{
//                sender.setImage(markedO,for:.normal)
//                xTurn = true
//                oInputs.append(clicked)
//                status = "It's player 1's turn"
//                if check(oInputs).0{
//                    oHasWon = true
//                    inGame = false
//                    status = "Player 2 has won!"
//                    if let text = score2.text, let value = Int(text) {
//                        score2.text = String(value + 1)
//                    }
//
//                    for o in check(oInputs).1{
//                        find(o).tintColor = .systemYellow
//                    }
//                } else {
//                    status.text = "It's player 1's turn"
//                }
//            }
//            if inGame && occupied.count == 9{
//                status.text = "Draw!"
//                inGame = false
//                for button in allButtons! {
//                    button.tintColor = .systemGray
//                }
//            }
//        }
//    }
//
//
//}
