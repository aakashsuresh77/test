//
//  add_users.swift
//  Test
//
//  Created by Aakash on 22/09/20.
//


//This controller is for adding users


import Foundation
import UIKit
import RealmSwift

class add_users: UIViewController {
    
    let realm = try! Realm()
    
    @IBOutlet weak var form_view: UIView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var occupation: UITextField!
    @IBOutlet weak var experience: UITextField!
    @IBOutlet weak var back: UIImageView!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var error_message: UILabel!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        //deleting realm database
        /*realm.beginWrite()
        realm.delete(realm.objects(user_details.self))
        try! realm.commitWrite()
 */
        
        error_message.isHidden = true
        progress.isHidden = true
        form_view.layer.cornerRadius = 13
        form_view.layer.borderWidth = 3
        form_view.layer.borderColor = UIColor(red:28/255, green:218/255, blue:146/255, alpha: 1).cgColor
        submit.layer.cornerRadius = 25
        submit.layer.borderWidth = 3
        submit.layer.borderColor = UIColor(red:110/255, green:180/255, blue:115/255, alpha: 1).cgColor
        submit.layer.backgroundColor = UIColor(red:110/255, green:180/255, blue:115/255, alpha: 1).cgColor
        
        //for testing
        display()
        
        debugPrint("This is")
        
        
        let back_clicked = UITapGestureRecognizer(target: self, action: #selector(aboutClicked(_:)))
        back.addGestureRecognizer(back_clicked)
        
    }
    @IBAction func submit_clicked(_ sender: Any) {
        if name.text == ""{
            error_message.isHidden = false
            error_message.text = "Enter Name"
        }else if occupation.text == ""{
            error_message.isHidden = false
            error_message.text = "Enter occupation"
        }else if experience.text == ""{
            error_message.isHidden = false
            error_message.text = "Enter experience"
        }else{
            progress.isHidden = false
            error_message.isHidden = true
            save()
        }
        debugPrint(name.text)
        debugPrint(occupation.text)
        debugPrint(experience.text)
    }
    @objc func aboutClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func display(){
        let display_details = realm.objects(user_details.self)
        for specific_details in display_details{
            let user_name = specific_details.name
            let user_occupation = specific_details.occupation
            let user_experience = specific_details.experience
            
            debugPrint(user_name)
            debugPrint(user_occupation)
            debugPrint(user_experience)
            
        }
    }
    
    //saves user details
    func save(){
        let details = user_details()
        details.name = name.text!
        details.occupation = occupation.text!
        details.experience = experience.text!
        
        realm.beginWrite()
        realm.add(details)
        try! realm.commitWrite()
        progress.isHidden = true
        Toast(Title: "DONE", Text: "User Details Saved", delay: 3)
        
    }
    
    //display toast after successfull saving and exits controller
    func Toast(Title:String ,Text:String, delay:Int) -> Void {
        let alert = UIAlertController(title: Title, message: Text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "close", sender: self)
        })
    }
    
}

//create db

class user_details: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var occupation: String = ""
    @objc dynamic var experience: String = ""
}
