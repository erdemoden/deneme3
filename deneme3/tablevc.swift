//
//  tablevc.swift
//  deneme3
//
//  Created by erdem öden on 23.02.2021.
//  Copyright © 2021 erdem öden. All rights reserved.
//

import UIKit
import CoreData

class tablevc: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UIApplicationDelegate{
    var arrname = [String]()
    var arrid = [UUID]()
    @IBOutlet weak var tableview: UITableView!
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = arrname[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrname.count
       }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        arrname.removeAll(keepingCapacity: false)
        arrid.removeAll(keepingCapacity: false)
        ekle()
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    func ekle(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            let sorgu = try context.fetch(fetch)
            for  fetches in sorgu as! [NSManagedObject]{
                arrname.append(fetches.value(forKeyPath: "isim") as! String)
                arrid.append(fetches.value(forKey: "id") as! UUID)
            }
               }
               catch{
                   print("Error")
               }
    }
    func cikar(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetch.returnsObjectsAsFaults = false
        do{
            let sorgu = try context.fetch(fetch)
            for  fetches in sorgu as! [NSManagedObject]{
                context.delete(fetches)
                }
            do{
                try context.save()
                
            }
            catch{
                print("Error")
            }
            
               }
               catch{
                   print("Error")
               }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
                   let context = appdelegate.persistentContainer.viewContext
                   let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
             fetch .returnsObjectsAsFaults = false
            fetch.predicate = NSPredicate(format: "id = %@", arrid[indexPath.row].uuidString)
            do{
                 let sorgu = try context.fetch(fetch)
                if(sorgu.count>0){
                for fetches in sorgu as! [NSManagedObject]{
                        context.delete(fetches)
                        arrname.remove(at: indexPath.row)
                        arrid.remove(at: indexPath.row)
                    
                    }}
                do{
                    try context.save()
                    tableView.reloadData()
                    
                }
                catch{
                    print("Error")
                }
            }
            catch{
                print("Error")
            }
        
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
