//
//  BookmarksTableViewCell.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 02/12/2023.
//

import UIKit

class BookmarksTableViewCell: UITableViewCell {
    private let systName = BookmarkConstants()
    private var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.alignment = .center
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var labelStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fill
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private var labelStackViewTwo: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.spacing = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let bookmarkImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleToFill
        element.layer.masksToBounds = true
        element.layer.cornerRadius = 5
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOpacity = 0.5
        element.layer.shadowOffset = CGSize(width: 0, height: 2)
        element.layer.shadowRadius = 7
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let bookmarkDateLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let bookmarkTitleLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        element.font = UIFont.boldSystemFont(ofSize: 18)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private let calendarIconImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "calendar")
        element.tintColor = UIColor.systemGray
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupUI(withDataFrom: Photo){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = AppConstants.dateFormatOld
        
        if let dateString = withDataFrom.date, let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = AppConstants.dateFormatNew
            let formattedDate = dateFormatter.string(from: date)
            bookmarkDateLabel.text = formattedDate
        } else {
            bookmarkDateLabel.text = systName.bookmarkLabel
        }
        
        bookmarkTitleLabel.text = withDataFrom.title
        bookmarkImageView.sd_setImage(with: URL(string: withDataFrom.url ?? ""))
        
    }
    
    private func setupSubviews() {
        
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(bookmarkImageView)
        mainStackView.addArrangedSubview(labelStackView)
        
        labelStackView.addArrangedSubview(bookmarkTitleLabel)
        labelStackView.addArrangedSubview(labelStackViewTwo)
        
        labelStackViewTwo.addArrangedSubview(calendarIconImageView)
        labelStackViewTwo.addArrangedSubview(bookmarkDateLabel)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            bookmarkImageView.heightAnchor.constraint(equalToConstant: 180),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: 150),
            bookmarkImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            bookmarkImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 5),
            bookmarkImageView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -5),
            
            calendarIconImageView.widthAnchor.constraint(equalToConstant: 20),
            calendarIconImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
extension BookmarksTableViewCell {
    private struct BookmarkConstants {
        let bookmarkLabel = "Invalid date format"
    }
}

