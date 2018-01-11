//
//  secondVC.swift
//  PracticeCoreData
//
//  Created by SGI-Mac7 on 10/01/2018.
//  Copyright © 2018 Slash Global. All rights reserved.
//

import UIKit
import CoreData

class secondVC: UIViewController, UIWebViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var mytableOutlet: UITableView!
    var userArry:[NSManagedObject] = []
    override func viewDidLoad()
         {
        super.viewDidLoad()
        
        self.mytableOutlet.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.fetchData()
        self.mytableOutlet.reloadData()
        

          }
    
    func fetchData()
    {
        let appDelegate_Instance = UIApplication.shared.delegate as! AppDelegate
        let databaseContext:NSManagedObjectContext = appDelegate_Instance.persistentContainer.viewContext
        do
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserTable")
            
            
            let result = try databaseContext.fetch(request)
            
            
            for item in result as! [NSManagedObject]
            {
                
                self.userArry.append(item)
            }
        }
        catch
        {
             print("Error While Fetching")
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            let app_Del_Instance = UIApplication.shared.delegate as! AppDelegate
            
            let database_Context:NSManagedObjectContext = app_Del_Instance.persistentContainer.viewContext
            
            database_Context.delete(self.userArry[indexPath.row])
            do
            {
                try database_Context.save()
                self.userArry.removeAll()
                self.fetchData()
                self.mytableOutlet.reloadData()
            }
            catch
            {
                print("error in showing data")
            }
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArry.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let firstName = self.userArry[indexPath.row].value(forKey: "firstName") as! String
        let lastName = self.userArry[indexPath.row].value(forKey: "lastName") as! String

        Cell?.textLabel?.text = "\(firstName);\(lastName)"
        return Cell!
    }
    
    
    

   }
