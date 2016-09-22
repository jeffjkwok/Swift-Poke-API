//
//  PokemonModel.swift
//  Hackathon3
//
//  Created by Curran Brown on 9/21/16.
//  Copyright © 2016 Curran Brown. All rights reserved.
//

import Foundation
import UIKit

class Pokemon {
    let name: String
//    let type: String
//    let generation: String
//    let weight: String
//    let height: String
//    let pic: String
//    
    init(name: String){
//        , type: String, generation: String, weight: String, height: String, pic: String
        self.name = name
        
//        self.type = type
//        self.generation = generation
//        self.weight = weight
//        self.height = height
//        self.pic = pic
    }
    
    static func getAllPokemons(completionHandler: (pokemons: [Pokemon]) -> () ) {
        var outPokemons = [Pokemon]()
//        var count: Int = 0
        func handleJSONResponse(url: String) {
            let url = NSURL(string: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {
                data, response, error in
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                        if let results = jsonResult["results"] {
                            let resultsArray = results as! NSArray
                            for i in 0 ..< (resultsArray.count) {
                                let pokemonDictionary = resultsArray[i] as! NSDictionary
                                let name = pokemonDictionary["name"] as? String
//                                let type = pokemonDictionary["type"] as? String
//                                let generation = pokemonDictionary["generation"] as? String
//                                let weight = pokemonDictionary["weight"] as? String
//                                let height = pokemonDictionary["height"] as? String
//                                let pic = pokemonDictionary["pic"] as? String
                                let p = Pokemon(name: name!)
//                                , type: type!, generation: generation!, weight: weight!, height: height!, pic: pic!
                                outPokemons.append(p)
                            }
                            completionHandler(pokemons: outPokemons)
                        }
                        if let nextPage = jsonResult["next"] as? String! {
                            handleJSONResponse(nextPage)
                        }
                    }
                } catch {
                    print ("Something Went Wrong")
                }
            })
            task.resume()
        }
        handleJSONResponse("http://pokeapi.co/api/v2/pokemon")
    }
    
}

class Details {
    let name: String
    let types: [String]
    let id: String
    let weight: String
    let height: String
    let pic: String
    //    id weight and height are all INTs
    init(name: String, id: String, weight: String, height: String, pic: String, types:[String]){
        //        , type: String, generation: String, weight: String, height: String, pic: String
        self.name = name
        self.types = types
        self.id = id
        self.weight = weight
        self.height = height
        self.pic = pic
    }
    
    static func getDetails(url: String, var outDetails:[Details] = [], completionHandler: (Details: [Details]) -> () ) {
        var pokeName = ""
        var pokeId = ""
        var pokeHeight = ""
        var pokeWeight = ""
        var pokeSprite = ""
        var pokeTypes = [] as NSMutableArray
//        var outDetails = [Details]()
            let url = NSURL(string: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url!, completionHandler: {
                data, response, error in
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSMutableDictionary{
//                      
                        if let name = jsonResult["name"]{
//                            let newname = name.replaceRange(name.0...name.0, withText: String(name[0]).capitalizedString)
                            pokeName = (name as? String)!
                        }
                        if let id = jsonResult["id"]{
                            pokeId = (String(id) as? String)!
                        }
                        if let weight = jsonResult["weight"]{
                            pokeWeight = (String(weight) as? String)!
                        }
                        if let height = jsonResult["height"]{
                            pokeHeight = (String(height) as? String)!
                        }
                        if let sprites = jsonResult["sprites"] {
                            let spritesDictionary = sprites as! NSDictionary
                            pokeSprite = (spritesDictionary["front_default"] as? String)!
                        }
                        if let types = jsonResult["types"] {
                            for type in types as! [AnyObject]{
                                pokeTypes.addObject(type["type"]!!["name"]!!)
                            }
                        }
//                        print(pokeSprite)
//                        print("name: \(pokeName)")
//                        print("id: \(pokeId)")
//                        print("weight: \(pokeWeight)")
//                        print("height: \(pokeHeight)")
                        let d = Details(name: pokeName, id: pokeId, weight: pokeWeight, height: pokeHeight, pic: pokeSprite, types: pokeTypes as! [String])
                        outDetails.append(d)
                        print(outDetails[0].name)
                        
                        completionHandler(Details: outDetails)
                        }
                } catch {
                    print ("Something Went Wrong")
                }
            })
            task.resume()
    }
}