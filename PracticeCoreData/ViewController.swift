//
//  ViewController.swift
//  PracticeCoreData
//
//  Created by SGI-Mac7 on 10/01/2018.
//  Copyright © 2018 Slash Global. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var FirstNameOutlet: UITextField!
    
    @IBOutlet weak var LastNameOutlet: UITextField!
    
    
    @IBOutlet weak var TbxFirstName: UITextField!
    
    
    @IBOutlet weak var tbxLastName: UITextField!
    
    
    @IBOutlet weak var TbxFirstNameSearchField: UITextField!
    
    
    @IBOutlet weak var TbxResultLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.TbxFirstName.delegate = self
        self.tbxLastName.delegate = self
    }
    
    
    //Hide Keyboard when user touch outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
     {
         self.view.endEditing(true)
     }
    //Hide Keyboard Key when presses Return Key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
     {
         textField.resignFirstResponder()
         return true
     }
    // Search core Data Value
    @IBAction func BtnSearchAction(_ sender: AnyObject)
      {
        let appDel_Instance = UIApplication.shared.delegate as! AppDelegate
        let database_context = appDel_Instance.persistentContainer.viewContext
        
         let entity = NSEntityDescription.entity(forEntityName: "UserTable", in: database_context)
        
        
        let request = NSFetchRequest<NSFetchRequestResult>()
        
        request.entity = entity
        
        let searchString = self.TbxFirstNameSearchField.text
        
          request.predicate = NSPredicate(format:"firstName == %@",searchString!)
        
        do
        {
                let record = try database_context.fetch(request)
        
                let rec = record as! [NSManagedObject]
            
            //  try database_context.delete(rec[0])
                
            if rec.count > 0
            {
            
            if let firstname = rec[0].value(forKey: "firstName")
               {
                
                if let lastname = rec[0].value(forKey: "lastName")
                {
                  self.TbxResultLabel.text = "\(firstname) \(lastname)"
                }
                else
                {
                   let  alertController = UIAlertController.init(title: "Warning", message: "Data is not in Core Data ", preferredStyle: .alert)
                   let  defaultAction = UIAlertAction(title: "Close Alert", style: .destructive, handler: nil)
                   alertController.addAction(defaultAction)
                   present(alertController, animated: true, completion: nil)
                }
                }
            }
            
        }
        catch
        {
            print("Error occur while ")
        }
        
      }

    
    
    
    
    
    
    
    
    
    // Save Core Data Value
    @IBAction func BtnSave(_ sender: AnyObject)
    {
        if FirstNameOutlet.text != "" || LastNameOutlet.text != "" || TbxFirstNameSearchField.text != ""
        {
          let appDel_Instance = UIApplication.shared.delegate as! AppDelegate
          let database_Context = appDel_Instance.persistentContainer.viewContext
         
       
          let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserTable", into: database_Context)
            
          newUser.setValue(self.FirstNameOutlet.text, forKey: "firstName")
          newUser.setValue(self.LastNameOutlet.text, forKey: "lastName")
          FirstNameOutlet.text = ""
          LastNameOutlet.text = ""
            
        do
        {
            try database_Context.save()
            
        }catch {
            print("Error while saving the value")
         }
       }
        else
         {
             let alertController = UIAlertController(title: "Hello  Coders", message: "Plz enter the values in textboxes", preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
             alertController.addAction(defaultAction)
            
             present(alertController, animated: true, completion: nil)
         }
    
    }
    
    
    
    
}

