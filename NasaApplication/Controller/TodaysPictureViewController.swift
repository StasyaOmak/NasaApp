//
//  TodaysPictureViewController.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 26/11/2023.
//

import UIKit
import SDWebImage
import Lottie
import CoreData

class TodaysPictureViewController: UIViewController {
    private let constant = Constants()
    var managedObjectContext: NSManagedObjectContext?
    var nasaList = [Photo]()
    
    private var photoOfTheDay: AstronomyPicture?
    private let photoNetworkManager = PhotoOfTheDayNetworkManager()
    var animationView = LottieAnimationView()
    private var isMarked = false
    
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
        element.clipsToBounds = true
        element.layer.cornerRadius = 5
        element.isUserInteractionEnabled = true
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
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: AppConstants.bookmarkSysImage), style: .plain, target: self, action: #selector(addBarButtonTapped))
    }()
    
    private lazy var actionBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(actionBarButtonTapped))
    }()
    
    func checkCoreData() {
        let fetchRequest: NSFetchRequest<Photo>
        fetchRequest = Photo.fetchRequest()
        
        guard let title = photoOfTheDay?.title else {
            print("Don't have a photoOfTheDay")
            return
        }
        fetchRequest.predicate = NSPredicate(
            format: "title LIKE %@", title
        )
        
        if (try? managedObjectContext?.fetch(fetchRequest).first) != nil {
            addBarButtonItem.image = UIImage(systemName: AppConstants.bookmarkFillSysImage)
        } else {
            addBarButtonItem.image = UIImage(systemName: AppConstants.bookmarkSysImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupNavigationBar()
        setupConstraints()
        setupAnimation()
        animationView.play()
        fetchAstronomyData()
        setupCoreData()
    }
    
    private func fetchAstronomyData() {
        let networkManager = PhotoOfTheDayNetworkManager()
        networkManager.fetchData { [weak self] (result) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self?.photoOfTheDay = success
                    self?.checkCoreData()
                    self?.setupViews()
                    self?.animationView.stop()
                    self?.animationView.removeFromSuperview()
                    self?.view.setNeedsDisplay()
                }
            case .failure(let failure):
                print(failure)
                DispatchQueue.main.async {
                    self?.animationView.stop()
                    self?.animationView.removeFromSuperview()
                    self?.setupErrorAnimation()
                }
            }
        }
    }
    
    func setupCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveBookmarkArrayFull() {
        let entity = NSEntityDescription.entity(forEntityName: AppConstants.entityName, in: self.managedObjectContext!)
        let list = NSManagedObject(entity: entity!, insertInto: self.managedObjectContext)
        
        list.setValue(photoOfTheDay?.date, forKey: "date")
        list.setValue(photoOfTheDay?.explanation, forKey: "explanation")
        list.setValue(photoOfTheDay?.title, forKey: "title")
        list.setValue(photoOfTheDay?.url, forKey: "url")
        
        saveCoreData()
    }
    
    func saveCoreData(){
        do {
            try managedObjectContext?.save()
        } catch {
            fatalError("Error in saving item into core data")
        }
    }
    
    @objc private func addBarButtonTapped(){
        let fetchRequest: NSFetchRequest<Photo>
        fetchRequest = Photo.fetchRequest()
        
        guard let title = photoOfTheDay?.title else {
            print("Don't have photoOfTheDay")
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
        print("You can share an image")
        
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
        navigationItem.rightBarButtonItems = [actionBarButtonItem, addBarButtonItem]
        actionBarButtonItem.tintColor = AppConstants.navigationBarTintColor
        addBarButtonItem.tintColor = AppConstants.navigationBarTintColor
        
        actionBarButtonItem.isEnabled = true
        addBarButtonItem.isEnabled = true
        
        let titleLabel = UILabel()
        titleLabel.text = constant.titleLabelText
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationItem.titleView = titleLabel
    }
    
    private func setupAnimation() {
        animationView.animation = LottieAnimation.named(AppConstants.loadingAnimation)
        animationView.frame = CGRect(x: (Int(view.bounds.width) - AppConstants.animationFrame) / 2, y: (Int(view.bounds.height) - AppConstants.animationFrame) / 2, width: AppConstants.animationFrame, height: AppConstants.animationFrame)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = AppConstants.loadingAnSpeed
        animationView.play()
    }
    
    private func setupErrorAnimation() {
        animationView = LottieAnimationView(name: AppConstants.errorAnimation)
        animationView.frame = CGRect(x: (Int(view.bounds.width) - AppConstants.animationFrame) / 2, y: (Int(view.bounds.height) - AppConstants.animationFrame) / 2, width: AppConstants.animationFrame, height: AppConstants.animationFrame)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = AppConstants.errorAnSpeed
        view.addSubview(animationView)
        animationView.play()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = AppConstants.navigationBarTintColor
        
        view.addSubview(scrollView)
        view.addSubview(animationView)
        
        scrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(dateLabel)
        mainStackView.addArrangedSubview(dayImageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(textLabel)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstants.dateFormatOld
        if let date = dateFormatter.date(from: photoOfTheDay?.date ?? "") {
            dateFormatter.dateFormat = AppConstants.dateFormatNew
            let formattedDate = dateFormatter.string(from: date)
            dateLabel.text =  formattedDate
        }

        titleLabel.text = photoOfTheDay?.title
        textLabel.text = photoOfTheDay?.explanation
        
        guard let url = URL(string: photoOfTheDay?.url ?? "") else { return }
        dayImageView.sd_setImage(with: url)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        dayImageView.addGestureRecognizer(longPressGesture)
        
    }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: AppConstants.animationDuration) {
                self.dayImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        } else if gesture.state == .ended {
            UIView.animate(withDuration: AppConstants.animationDuration) {
                self.dayImageView.transform = CGAffineTransform.identity
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
            dayImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dayImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dayImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            
            textLabel.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}

extension TodaysPictureViewController {
    private struct Constants {
        let titleLabelText = "Image Of The Day"
    }
}
