//
//  ViewController.swift
//  Core Data
//
//  Created by Slava on 21.10.2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameFild: UITextField!
    @IBOutlet weak var displayName: UILabel!
    @IBAction func showName(_ sender: Any) {
        
        let employeesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let fetchedEmployees = try moc!.fetch(employeesFetch) as! [PersonMO]
            self.displayName.text = fetchedEmployees.first?.name
            print(fetchedEmployees.count)
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    @IBAction func saveName(_ sender: Any) {
        self.person?.name = self.displayName.text
        self.saveContext()
    }
    var container: NSPersistentContainer!
    var moc: NSManagedObjectContext?
    var person: PersonMO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameFild.delegate = self
        guard container != nil else {
            fatalError("This view needs a persistent container.")
        }
        self.moc = container.viewContext
        self.person = PersonMO(context: moc!)
        
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
        return self.nameFild.resignFirstResponder()
    }
}
