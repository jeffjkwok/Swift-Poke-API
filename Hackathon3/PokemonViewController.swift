//
//  PokemonViewController.swift
//  Hackathon3
//
//  Created by Curran Brown on 9/21/16.
//  Copyright © 2016 Curran Brown. All rights reserved.
//

import UIKit

class PokemonViewController: UITableViewController {
    var details: Details!
    var index: Int?
    var sprite: UIImage?
//    var pokemon: Pokemon?
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokeSprite: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Details.getDetails("http://pokeapi.co/api/v2/pokemon/\(index)"){
//            (details: [Details]) in
//            print(details.count)
//            self.details = details[0]
//            print(details[0].name)
//            dispatch_async(dispatch_get_main_queue(), {
//                self.updateUI()
//                self.tableView.reloadData()
//            })
        }

    }

    

//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("vc  \(details)")
//        return 4
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        // Create a generic cell
//        let cell = UITableViewCell()
//        // set the default cell label to the corresponding element in the people array
//        if indexPath.row == 0 {
//            cell.textLabel?.text = "details!.name"
//        } else if indexPath.row == 1 {
//            cell.textLabel?.text = "hi"
//        } else if indexPath.row == 2 {
//            cell.textLabel?.text = "hell"
//        } else if indexPath.row == 3 {
//            cell.textLabel?.text = "o"
//        }
//        // return the cell so that it can be rendered
//        return cell
//
//    }
    
//    func updateUI(){
//        print(details!.name)
//        nameLabel.text = details[0].name
//    }
//}
