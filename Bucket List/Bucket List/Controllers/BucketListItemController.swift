//
//  BucketListItemController.swift
//  Bucket List
//
//  Created by Markus Varner on 8/23/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import Foundation

class BucketListItemController {
    
    //MARk: - Shared Instance
    static let shared = BucketListItemController()
    
    //MARK: - Source of Truth
    
    var bucketList: [BucketListItem] = []
    
    //MARK: - CRUD
    func create(title: String, age: Int, description: String) {
        
        //Step: 1 - instansiate new BL item
        let bucketListItem = BucketListItem(title: title, age: age, description: description)
        //Step 2 - append new item to the array
        bucketList.append(bucketListItem)
        
        saveToPersistenceStore()
    }
    
    func update(bucketListItem: BucketListItem, newTitle: String, newAge: Int, newDescription: String) {
        
        bucketListItem.title = newTitle
        bucketListItem.age = newAge
        bucketListItem.description = newDescription
        
        saveToPersistenceStore()
        
    }
    func delete(bucketListItem: BucketListItem) {
        
        //this function is only available if we conform to equatable in the model class
        //IMPORTANT: if this presents and error, this may be because the file cant find the info.plist
        guard let index = bucketList.index(of: bucketListItem) else {return}
        bucketList.remove(at: index)
        
        saveToPersistenceStore()
    }
    
    //Build the Tracks
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //this pulls the first URL out of the URL array within File Manager
        let documenstDirectory = paths[0]
        //assign file destination
        let fileName = "bucketList.json"
        //add url to file destination
        let fullURL = documenstDirectory.appendingPathComponent(fileName)
        
        return fullURL
    }
    
    //MARK: - Turn into encoded data then save it to fileURL
    
    
    func saveToPersistenceStore() {
        
        //create an instance of json encoder which takes the data and that CAN turn it nto decodable data
        let encoder = JSONEncoder()
        
        //try to encode the data and then try to save into fileURL if it cant return a print statement telling what the error was
        do {
            let data = try encoder .encode(bucketList)
            try data.write(to: fileURL())
            
        } catch {
            print(" 🤬    Failed to encode and save it  \(error)       🤬")
        }
    }
    
    //MARK: - Load From Persistent Container
    
    //decode the Bucket List Itemes from their encoded state and return the array of BL items
    func loadFromPersistentStore() -> [BucketListItem] {
        //create an instance of a json DECODER to decode the encoded data
        let decoder  = JSONDecoder()
        
        do {
            //TRY to find the saved content
            let data = try Data(contentsOf: fileURL())
            //TRY to decode the data
            let bucketList = try decoder.decode([BucketListItem].self, from: data)
            //return it
            return bucketList
            
        } catch {
            
            print("Faile to return data \(error)")
            
        }
        return []
    }
}
