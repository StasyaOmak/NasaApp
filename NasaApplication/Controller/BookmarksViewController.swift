//
//  BookmarksViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 25/11/2023.



import UIKit
import SDWebImage
import Lottie
import CoreData



class BookmarksViewController: UIViewController {
    
    private let tableView = UITableView()
    var managedObjectContext: NSManagedObjectContext?
    var nasaList = [Photo]()
    var bookmarkAstronomyPictures: [AstronomyPicture] = []
    private var photoOfTheDayTwo: AstronomyPicture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bookmarkTableView)
        
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self
        
        if let navigationController = self.navigationController {
                    let appearance = UINavigationBarAppearance()
                    appearance.backgroundColor = UIColor.systemBackground
                    navigationController.navigationBar.standardAppearance = appearance
                    navigationController.navigationBar.scrollEdgeAppearance = appearance
                }
        
        setConstraints()
       
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCoreData()
        bookmarkTableView.reloadData()
    }
    
    func loadCoreData() {
        let request: NSFetchRequest<Photo> = Photo.fetchRequest()
        
        do {
            let result = try managedObjectContext?.fetch(request)
            nasaList = result ?? []
            print(nasaList.count)
        } catch {
            fatalError("Error loading items into Core Data")
        }
    }
    
    private let bookmarkTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BookmarksTableViewCell.self, forCellReuseIdentifier: "BookmarkCell")
        return tableView
    }()
    
    func deleteAllCoreData() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: "Photo")
        
        let deleteRequest = NSBatchDeleteRequest(
            fetchRequest: fetchRequest
        )
        
        deleteRequest.resultType = .resultTypeObjectIDs
        
        let batchDelete = try? managedObjectContext!.execute(deleteRequest)
        as? NSBatchDeleteResult
        
        guard let deleteResult = batchDelete?.result
                as? [NSManagedObjectID]
        else { return }
        
        let deletedObjects: [AnyHashable: Any] = [
            NSDeletedObjectsKey: deleteResult
        ]
        
        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: deletedObjects,
            into: [managedObjectContext!]
        )
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            bookmarkTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookmarkTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookmarkTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookmarkTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = nasaList[indexPath.row]
        let detailVC = BookmarkPhotoDetailViewController()
        detailVC.bookmarkPhoto = convertPhotoToAstronomyPicture(photo)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func convertPhotoToAstronomyPicture(_ photo: Photo) -> AstronomyPicture {
        return AstronomyPicture(date: photo.date ?? "", explanation: photo.explanation ?? "", title: photo.title ?? "", url: photo.url ?? "")
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
