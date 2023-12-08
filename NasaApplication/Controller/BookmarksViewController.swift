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
    // MARK: - Private Property
    private var photoOfTheDayTwo: AstronomyPicture?
    
    // MARK: - Public Property
    var managedObjectContext: NSManagedObjectContext?
    var nasaList = [Photo]()
    var bookmarkAstronomyPictures: [AstronomyPicture] = []
    
    // MARK: - UI
    private lazy var deleteBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(deleteAllBookmarks))
    }()
    
    private lazy var labelEmptyText: UILabel = {
        let element = UILabel()
        element.text = "Your Bookmark is Empty"
        element.textColor = AppConstants.navigationBarTintColor
        element.font = .systemFont(ofSize: 16, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let bookmarkTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BookmarksTableViewCell.self, forCellReuseIdentifier: "BookmarkCell")
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
        setupConstraints()
        setupCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCoreData()
        bookmarkTableView.reloadData()
    }
    
    // MARK: - Private Method
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = AppConstants.navigationBarTintColor
        let titleLabel = UILabel()
        titleLabel.text = C.titleLabelText
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationItem.titleView = titleLabel
        
        if let navigationController = self.navigationController {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.systemBackground
            navigationController.navigationBar.standardAppearance = appearance
            navigationController.navigationBar.scrollEdgeAppearance = appearance
            navigationItem.rightBarButtonItems = [deleteBarButtonItem]
            
            bookmarkTableView.separatorColor = AppConstants.navigationBarTintColor
            bookmarkTableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            
            bookmarkTableView.delegate = self
            bookmarkTableView.dataSource = self
        }
    }
    
    @objc private func deleteAllBookmarks() {
        let alert = UIAlertController(
            title: C.titleDeleteMessage,
            message: C.deleteMessage,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: AppConstants.cancelButton, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            
            self.deleteAllCoreData()
            self.loadCoreData()
            self.bookmarkTableView.reloadData()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.addSubview(bookmarkTableView)
        view.addSubview(labelEmptyText)
    }
    
    // MARK: - CoreData Method
    private func setupCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    private func loadCoreData() {
        let request: NSFetchRequest<Photo> = Photo.fetchRequest()
        
        do {
            let result = try managedObjectContext?.fetch(request)
            nasaList = result ?? []
            labelEmptyText.isHidden = !nasaList.isEmpty
        } catch {
            fatalError("Error loading items into Core Data")
        }
    }
    
    private func deleteAllCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
        fetchRequest = NSFetchRequest(entityName: AppConstants.entityName)
        
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
}

// MARK: - UITableViewDataSource, UITableViewDelegate
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

// MARK: - Setup Constraints
extension BookmarksViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookmarkTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookmarkTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookmarkTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookmarkTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            labelEmptyText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelEmptyText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Constants
extension BookmarksViewController {
    private struct C {
        static let titleLabelText = "Bookmark"
        static let deleteMessage = "Are you sure you want to delete all bookmarks?"
        static let titleDeleteMessage = "Delete All Bookmarks"
    }
}
