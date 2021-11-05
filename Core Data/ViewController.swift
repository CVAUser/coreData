//
//  ViewController.swift
//  Core Data
//
//  Created by Slava on 21.10.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var displayName: UILabel!
    
    weak var container: NSPersistentContainer!
    weak var moc: NSManagedObjectContext!
    var person: PersonMO?
    
    @IBAction func showName(_ sender: Any) {
        do {
            let employeesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
            let fetchedEmployees = try moc.fetch(employeesFetch) as! [PersonMO]
            print(fetchedEmployees)
            if fetchedEmployees.isEmpty {
                print("Employe array is empty")
                self.person = PersonMO(context: moc!)
            }
            person = fetchedEmployees.first
            self.displayName.text = person?.name
            print(fetchedEmployees.count)
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    @IBAction func saveName(_ sender: Any) {
        self.person?.name = self.displayName.text
        self.saveContext()
    }
    @IBAction func deleteName(_ sender: Any) {
        self.person?.name = nil
        self.saveContext()
    }
    
    
//    NSPersistentContainer passed from the outside and stored in local container variable
//    fatalError() generate a crash log and terminate aaplication.
//    NSManagedObjectContext retrived from container and stored in local moc variable
//    moc variable is general work object to fetch, store, update data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameField.delegate = self
        guard container != nil else {
            fatalError("This view needs a persistent container.")
        }
        self.moc = container.viewContext
    }
    
    
    func saveContext () {
        let context = self.container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("save data")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


extension ViewController {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.displayName.text = textField.text!
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.nameField.resignFirstResponder()
    }
}
