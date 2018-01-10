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
    var userArry:[String] = []
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

            let firstName = item.value(forKey: "firstName") as! String
            let lastName = item.value(forKey: "lastName") as! String
                
                self.userArry.append(firstName+" "+lastName)
                
                
            }
        }
        catch
        {
             print("Error While Fetching")
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArry.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        Cell?.textLabel?.text = self.userArry[indexPath.row]
        return Cell!
    }
    
    
    

   }
