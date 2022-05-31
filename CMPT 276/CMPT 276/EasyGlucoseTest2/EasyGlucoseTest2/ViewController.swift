//
//  ViewController.swift
//  EasyGlucoseTest2
//
//  Created by Faisal Atif on 2018-06-27.
//  Copyright © 2018 Faisal Atif. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var testData: Int = 0
    
    
    @IBOutlet weak var inputValue: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        
    }
    
    //A button function that saves data
    @IBAction func inputButton(_ sender: Any) {
        //Storing
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        //The value that's being saved to the core (187)
        newUser.setValue(187, forKey: "glucoseInput")
        
        do{
            //saves the data to the core
            try context.save()
            print("saved")
        }
            //To catch an error, if there's an error, so the program wouldn't crash
        catch{
             //ERROR
            print("error")
        }
        
        
        
    }
    
    //A button function that loads and prints data
    @IBAction func outputButton(_ sender: Any) {
        //Fetching
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            //Checks if we have any data saved
            if results.count > 0{
                for results in results as! [NSManagedObject]{
                    //glucoseInput is the attribute name in the core
                    if let glucoseInput = results.value(forKey: "glucoseInput"){
                        print(glucoseInput)
                    }
                }
            }
        }
        catch{
            //ERROR
            print("error")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

