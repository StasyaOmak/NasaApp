//
//  BookmarksViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.
//
//
//
import UIKit
import SDWebImage
import Lottie
import CoreData



class BookmarksViewController: UIViewController {
    
    private let tableView = UITableView()
    
    
    var managedObjectContext: NSManagedObjectContext?
    
    var nasaList = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCoreData()
    }
    
    func loadCoreData() {
        let request: NSFetchRequest<Photo> = Photo.fetchRequest()
        
        do {
            let result = try managedObjectContext?.fetch(request)
            nasaList = result ?? []
            print(nasaList.count)
        } catch {
            fatalError("Error in loading item into core data")
        }
    }
    
    
    //            extension BookmarksViewController {
    //
    //                func loadCoreData() {
    //
    //                }
    //
    //                func saveCoreData(){
    //
    //                }
    //
    //    func saveToDoListArrayFull() {
    //
    //    do {
    //        try managedObjectContext?.save()
    //    } catch {
    //        fatalError("Error in saving item into core data")
    //    }
    //    loadCoreData()
    //                }
    //
    //
    //                func deleteAllCoreData() {
    //
    //                }
    //    }
    //    /*
    //      MARK: - Navigation
    //
    //      In a storyboard-based application, you will often want to do a little preparation before navigation
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //      Get the new view controller using segue.destination.
    //      Pass the selected object to the new view controller.
    //     }
    //     */
    //
    //
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return nasaList.count
        }
    
}
