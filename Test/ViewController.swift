//
//  ViewController.swift
//  Test
//
//  Created by Aakash on 22/09/20.
//

//this controller is for displaying list of users in collection View

import RealmSwift
import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    let realm = try! Realm()
    
    struct details_list {
        var name: String
        var occupation: String
        var experience: String
    }
    var user_details_arr = [
        details_list(name: "Not Added", occupation: "Not Added", experience: "Not Added")
    ]
    @IBOutlet weak var next_page: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
       
        let display_details = realm.objects(user_details.self)
        for specific_details in display_details{
            let user_name = specific_details.name
            let user_occupation = specific_details.occupation
            let user_experience = specific_details.experience
            
            debugPrint(user_name)
            debugPrint(user_occupation)
            debugPrint(user_experience)
            
            self.user_details_arr.append(details_list(name: user_name, occupation: user_occupation, experience: user_experience))
            
        }
        self.user_details_arr.remove(at: 0)
        
    }
    func addTapped(){
        debugPrint("this is clicked")
    }
  
    
    
  
           
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

     
        return CGSize(width: view.frame.size.width, height: view.frame.size.width)}
           
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user_details_arr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        
        //assigning text and view design
        cell.view_content.layer.cornerRadius = 25
        cell.view_content.layer.borderWidth = 3
        cell.view_content.layer.borderColor = UIColor(red:40/255, green:171/255, blue:84/255, alpha: 1).cgColor
        cell.frame.size.width = self.view.frame.width
        cell.view_content.frame.size.width = self.view.frame.width
        
        
        
        let assignText = user_details_arr[indexPath.row]
        cell.myLabel?.text = assignText.name
        cell.myLabel2?.text = assignText.occupation
        cell.myLabel3?.text = assignText.experience
        
        
        return cell
    }
    
    
    
}

