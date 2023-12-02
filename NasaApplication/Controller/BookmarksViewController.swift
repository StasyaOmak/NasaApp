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
        
        view.addSubview(bookmarkTableView)
        
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self
        
        setConstraints()
        
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
    
    private let bookmarkTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BookmarksTableViewCell.self, forCellReuseIdentifier: "BookmarkCell")
        return tableView
    }()
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            bookmarkTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookmarkTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookmarkTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookmarkTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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
    
    
}

extension BookmarksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkCell", for: indexPath) as! BookmarksTableViewCell
        
        let photo = nasaList[indexPath.row]
        cell.setupUI(withDataFrom: photo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
