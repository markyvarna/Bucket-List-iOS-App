//
//  BucketListTableViewController.swift
//  Bucket List
//
//  Created by Markus Varner on 8/23/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class BucketListTableViewController: UITableViewController {

    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
        
    }

    // MARK: - Table Viiew data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        //gain access of array from MC
        return BucketListItemController.shared.bucketList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketListCell", for: indexPath)
        
        //use the model controllers shared instance to get the model obj array and use its obj item values as needed
        let bucketListItem = BucketListItemController.shared.bucketList[indexPath.row]
        cell.textLabel?.text = bucketListItem.title
        cell.detailTextLabel?.text = "\(bucketListItem.age)"

        

        return cell
    }
    //MARK: - Support Editing Style
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            //call the bucketlist item
            let bucketListItem = BucketListItemController.shared.bucketList[indexPath.row]
            BucketListItemController.shared.delete(bucketListItem: bucketListItem)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //check segue id
        if segue.identifier == "goToDetail" {
            //get destination
            let destinationvc = segue.destination as? DetailBcuketListViewController
            //get index path out of source of truth
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            //get item out of source of truth with indexPath
            let bucketListItem = BucketListItemController.shared.bucketList[indexPath.row]
            //assign landing pad newly acquired obj
            destinationvc?.buckListItem = bucketListItem
        }
        
        
    }
    

}
