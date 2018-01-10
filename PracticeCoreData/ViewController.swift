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
    
    override func viewDidLoad() {
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


    @IBAction func BtnSave(_ sender: AnyObject)
    {
        let appDel_Instance = UIApplication.shared.delegate as! AppDelegate
        let database_Context = appDel_Instance.persistentContainer.viewContext
        
        //  let entityInstanceNewUser = NSEntityDescription.entity(forEntityName: "UserTable", in: database_Context)
      let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserTable", into: database_Context)
        
        
        
        newUser.setValue(self.FirstNameOutlet.text, forKey: "firstName")
        newUser.setValue(self.LastNameOutlet.text, forKey: "lastName")
        FirstNameOutlet.text = ""
        LastNameOutlet.text = ""
        
        
        
        
/*        newUser.setValue(self.FirstNameOutlet.text, forKey: "firstName")
        newUser.setValue(self.LastNameOutlet.text, forKey: "lastName")
        FirstNameOutlet.text = ""
        LastNameOutlet.text = ""
*/
        
        do
        {
            try database_Context.save()
            
        }catch {
            print("Error while saving the value")
         }
    }
    
    
    @IBAction func BtnShowData(_ sender: AnyObject)
    {
        
    }
}

