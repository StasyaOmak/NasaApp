//
//  BookmarkPhotoDetailViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 01/12/2023.
//

import Foundation
import SDWebImage
import CoreData

class BookmarkPhotoDetailViewController: UIViewController {
    var bookmarkPhoto: AstronomyPicture?
    private let photoNetworkManager = PhotoNetworkManager()
    private var isMarked = false
    var managedObjectContext: NSManagedObjectContext?
    
    private var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 10
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let dateLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .left
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 18, weight: .bold)
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let dayImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let titleLabel: UILabel = {
        let element = UILabel()
        element.textAlignment = .center
        element.font = .systemFont(ofSize: 22, weight: .bold)
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let textLabel: UITextView = {
        let element = UITextView()
        element.textAlignment = .justified
        element.font = .systemFont(ofSize: 14, weight: .bold)
        element.isEditable = false
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var removeBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: AppConstants.bookmarkFillSysImage), style: .plain, target: self, action: #selector(removeBarButtonItemTapped))
    }()
    
    private lazy var actionBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionBarButtonTapped))
    }()
    
    func checkCoreData() {
        let fetchRequest: NSFetchRequest<Photo>
        fetchRequest = Photo.fetchRequest()
        
        guard let title = bookmarkPhoto?.title else {
            print("Don't have a photo")
            return
        }
        fetchRequest.predicate = NSPredicate(
            format: "title LIKE %@", title
        )
        
        if (try? managedObjectContext?.fetch(fetchRequest).first) != nil {
            removeBarButtonItem.image = UIImage(systemName: AppConstants.bookmarkFillSysImage)
        } else {
            removeBarButtonItem.image = UIImage(systemName: AppConstants.bookmarkSysImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNavigationBar()
        setupConstraints()
        setupCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkCoreData()
    }
    
    func setupCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveBookmarkArrayFull() {
        let entity = NSEntityDescription.entity(forEntityName: AppConstants.entityName, in: self.managedObjectContext!)
        let list = NSManagedObject(entity: entity!, insertInto: self.managedObjectContext)
        
        list.setValue(bookmarkPhoto?.date, forKey: "date")
        list.setValue(bookmarkPhoto?.explanation, forKey: "explanation")
        list.setValue(bookmarkPhoto?.title, forKey: "title")
        list.setValue(bookmarkPhoto?.url, forKey: "url")
        
        saveCoreData()
    }
    
    func saveCoreData(){
        do {
            try managedObjectContext?.save()
        } catch {
            fatalError("Error in saving item into core data")
        }
    }
    
    @objc private func removeBarButtonItemTapped() {
        let fetchRequest: NSFetchRequest<Photo>
        fetchRequest = Photo.fetchRequest()
        
        guard let title = bookmarkPhoto?.title else {
            print("Don't have a photo")
            return
        }
        
        fetchRequest.predicate = NSPredicate(
            format: "title LIKE %@", title
        )
        
        if let object = try? managedObjectContext?.fetch(fetchRequest).first {
            managedObjectContext?.delete(object)
            saveCoreData()
        } else {
            saveBookmarkArrayFull()
        }
        checkCoreData()
    }
    
    @objc private func actionBarButtonTapped() {
        print("Action Bar Button Tapped")
        
        guard let image = dayImageView.image else {
            print("No image to share")
            return
        }
        
        let text = """
            Date: \(dateLabel.text ?? "")
            Title: \(titleLabel.text ?? "")
            Explanation: \(textLabel.text ?? "")
        """
        
        let objectsToShare: [Any] = [image, text]
        let shareController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, completed, _, error in
            if completed {
                print("Sharing succeeded")
            } else {
                print("Sharing failed: \(String(describing: error))")
            }
        }
        
        present(shareController, animated: true, completion: nil)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItems = [actionBarButtonItem, removeBarButtonItem]
        actionBarButtonItem.tintColor = AppConstants.navigationBarTintColor
        removeBarButtonItem.tintColor = AppConstants.navigationBarTintColor
        actionBarButtonItem.isEnabled = true
        removeBarButtonItem.isEnabled = true
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(dateLabel)
        mainStackView.addArrangedSubview(dayImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(textLabel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstants.dateFormatOld
        if let date = dateFormatter.date(from: bookmarkPhoto?.date ?? "") {
            dateFormatter.dateFormat = AppConstants.dateFormatNew
            let formattedDate = dateFormatter.string(from: date)
            dateLabel.text =  formattedDate
        }
        
        titleLabel.text = bookmarkPhoto?.title
        textLabel.text = bookmarkPhoto?.explanation
        
        guard let url = URL(string: bookmarkPhoto?.url ?? "") else { return }
        dayImageView.sd_setImage(with: url) { [weak self] image, _, _, _ in
            if image == nil {
                self?.dayImageView.image = UIImage(named: "nasa")
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            
            dayImageView.heightAnchor.constraint(equalToConstant: 280),
            dayImageView.widthAnchor.constraint(equalToConstant: 250),
            dayImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            dayImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            dayImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor,constant: 10),
            
            textLabel.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}


