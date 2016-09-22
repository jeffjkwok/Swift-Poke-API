//
//  ViewController.swift
//  Hackathon3
//
//  Created by Curran Brown on 9/21/16.
//  Copyright © 2016 Curran Brown. All rights reserved.
//

import UIKit

class PokeDexViewController: UITableViewController {
    
    var pokemons = [Pokemon]()
    var details = [Details]()
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailsSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(pokemons.count)
        return pokemons.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PokemonCell")
        cell!.textLabel!.text = pokemons[indexPath.row].name
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "DetailsSegue") {
            let navigationController = segue.destinationViewController as! PokemonViewController
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            navigationController.index = indexPath!.row
//            navigationController.pokemon = pokemons[indexPath!.row]
            Details.getDetails("http://pokeapi.co/api/v2/pokemon/\(indexPath!.row+1)"){
                (details: [Details]) in
                navigationController.details = details[0]
                dispatch_async(dispatch_get_main_queue(), {
                    navigationController.nameLabel.text = "Name: \(details[0].name)"
                    navigationController.idLabel.text = "ID #: \(details[0].id)"
                    navigationController.weightLabel.text = "Weight: \(Double(details[0].weight)!/Double(10)) kg"
                    navigationController.heightLabel.text = "Height: \(Double(details[0].height)!/Double(10)) m"
                    self.loadImageFromUrl(details[0].pic, view: navigationController.pokeSprite)
                    var types = ""
                    var count = 0
                    for type in details[0].types{
                        count += 1
                        if count != 1{
                            types += ", \(type)"
                        } else {
                            types += type
                        }
                        navigationController.typeLabel.text = "Types: \(types)"
                    }
                    navigationController.tableView.reloadData()
                })
            }

        }
    }

    func loadImageFromUrl(url: String, view: UIImageView){
        
        // Create Url from string
        let url = NSURL(string: url)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    view.image = UIImage(data: data)
                })
            }
        }
        
        // Run task
        task.resume()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Pokemon.getAllPokemons
            {(pokemons: [Pokemon]) in
                self.pokemons = pokemons
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.tableView.reloadData()
            })
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

