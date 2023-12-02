//
//  BookmarksTableViewCell.swift
//  NasaApplication
//
//  Created by Anastasiya Omak on 02/12/2023.
//

import UIKit


class BookmarksTableViewCell: UITableViewCell {
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.alignment = .center
        element.spacing = 20
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var labelStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fill
        element.spacing = 10
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let bookmarkImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let bookmarkDateLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 2
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    let bookmarkTitleLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 0
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupUI(withDataFrom: Photo){
        
        bookmarkDateLabel.text = withDataFrom.date
        bookmarkTitleLabel.text = withDataFrom.title
        bookmarkImageView.sd_setImage(with: URL(string: withDataFrom.url ?? ""))
        
    }
    
    private func setupSubviews() {
        
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(bookmarkImageView)
        mainStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(bookmarkDateLabel)
        labelStackView.addArrangedSubview(bookmarkTitleLabel)
        
        
        NSLayoutConstraint.activate([
            
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bookmarkImageView.widthAnchor.constraint(equalToConstant: 150),
            bookmarkImageView.heightAnchor.constraint(equalTo: bookmarkImageView.widthAnchor),
            bookmarkImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
            bookmarkImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 20),
            bookmarkImageView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: -20),
        ])
    }
}

