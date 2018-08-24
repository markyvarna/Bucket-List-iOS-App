//
//  DetailBcuketListViewController.swift
//  Bucket List
//
//  Created by Markus Varner on 8/23/18.
//  Copyright © 2018 Markus Varner. All rights reserved.
//

import UIKit

class DetailBcuketListViewController: UIViewController {
    
    var buckListItem : BucketListItem?

    //MARK: - Outlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var bodyTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    //MARK: Custom Method - updateViews()
    func updateViews() {
        
        guard let bucketListItem = buckListItem else {return}
        titleTextField.text = bucketListItem.title
        ageTextField.text = "\(bucketListItem.age)"
        bodyTextView.text = bucketListItem.description
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        //this makes it so as long as the title tf has a value you can save it
        guard titleTextField.text != nil else {return}
        
        //unwrap TF's and TxtView, convert age string value back to an int, call create func from Model controller
        /*this will take the parameters be enter in and go to the model controller where a new Model Obj is instantiated
         and then added to the Array of Model Obj's*/
        guard let title = titleTextField.text,
            let ageString = ageTextField.text,
            let age = Int(ageString),
            let description = bodyTextView.text else {return}
        
        if let bucketListItem = buckListItem {
            BucketListItemController.shared.update(bucketListItem: bucketListItem, newTitle: title, newAge: age, newDescription: description)
        } else {
            BucketListItemController.shared.create(title: title, age: age, description: description)
        }
        
        //pop off the top vc  from the vc stack aka go back to previous vc
        navigationController?.popViewController(animated: true)
    
    }
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        
        titleTextField.text = ""
        ageTextField.text = ""
        bodyTextView.text = ""
    }
    
}
