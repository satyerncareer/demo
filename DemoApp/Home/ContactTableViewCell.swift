//
//  ContactTableViewCell.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let identifier = "ContactTableViewCell"
    
    lazy private var hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 10
        
        hStack.translatesAutoresizingMaskIntoConstraints = true
        return hStack
    }()
    
    lazy private var vStack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.distribution = .fillEqually
        vStack.translatesAutoresizingMaskIntoConstraints = true
        return vStack
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy private var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    lazy private var contactImageView: UIImageView = {
       let image = UIImageView()
        
        return image
    }()
    
    var dataSource: User? {
        didSet {
            viewSetup()
        }
    }
    
    // MARK: - overriden methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        contactImageView.image = nil
        for arrangedSubview in hStack.arrangedSubviews {
            hStack.removeArrangedSubview(arrangedSubview)
            arrangedSubview.removeFromSuperview()
        }
    }
    
    // MARK: - user defined methods
    
    func viewSetup() {
        contentView.addSubview(hStack)
        vStack.addArrangedSubViews(nameLabel, emailLabel)
        let nameParentView = UIView()
        nameParentView.addSubview(vStack)
        hStack.addArrangedSubViews(contactImageView, nameParentView)
        contactImageView.snp.makeConstraints { make in
            make.height.width.equalTo(75)
        }
        
        vStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-10)
            
        }
        
        nameLabel.text = "\(dataSource?.firstName ?? "") \(dataSource?.lastName ?? "")"
        contactImageView.loadImage(from: dataSource?.avatar)
        contactImageView.contentMode = .scaleAspectFit
        emailLabel.text = dataSource?.email
        contentView.clipsToBounds = true
        hStack.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.bottom.right.equalTo(-10)
        }
    }

}
