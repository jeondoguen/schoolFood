//
//  CustomTableViewCell.swift
//  SchoolFood
//
//  Created by 전도균 on 2022/08/13.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func didTapStepper(amount: Int, quantity: Int, tag: Int)
}

class CustomTableViewCell: UITableViewCell {
    
    let myTitle = UILabel()
    let mySubTitle = UILabel()
    let myImageView = UIImageView()
    let countLabel = UILabel()
    let myStepper = UIStepper()
    
    private var menu: Menu?
    
    weak var delegate: CustomTableViewCellDelegate?
    
    var quantity = 0 {
        willSet {
            countLabel.text = String(newValue) + "개"
        }
    }
            
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myTitle)
        contentView.addSubview(mySubTitle)
        contentView.addSubview(myImageView)
        contentView.addSubview(countLabel)
        contentView.addSubview(myStepper)
        
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.contentMode = .scaleAspectFit
        
        myTitle.font = .systemFont(ofSize: 17)
        myTitle.translatesAutoresizingMaskIntoConstraints = false

        mySubTitle.font = .systemFont(ofSize: 12)
        mySubTitle.translatesAutoresizingMaskIntoConstraints = false
        
        countLabel.font = .systemFont(ofSize: 15)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.text = String(quantity) + "개"
        
        myStepper.translatesAutoresizingMaskIntoConstraints = false
        myStepper.addTarget(self, action: #selector(didTapStepper(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            myImageView.widthAnchor.constraint(equalToConstant: 100),
            myImageView.heightAnchor.constraint(equalToConstant: 60),
            
            myTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            myTitle.leadingAnchor.constraint(equalTo: myImageView.leadingAnchor, constant: 90),
            
            mySubTitle.topAnchor.constraint(equalTo: myTitle.bottomAnchor, constant: 5),
            mySubTitle.leadingAnchor.constraint(equalTo: myTitle.leadingAnchor),
            
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor), 
            countLabel.trailingAnchor.constraint(equalTo: myStepper.leadingAnchor, constant: -30),
            
            myStepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            myStepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func didTapStepper(_ sender: UIStepper) {
        guard let price = menu?.price else { return }
        let amount = price * (Int(sender.value) - quantity)
        quantity = Int(sender.value)
        delegate?.didTapStepper(amount: amount, quantity: quantity, tag: tag)
    }
    
    func setData(menu: Menu, quantity: Int) {
        self.menu = menu
        self.quantity = quantity
        myStepper.value = Double(quantity)
        myImageView.image = menu.image
        myTitle.text = menu.title
        mySubTitle.text = menu.priceTag
    }
    
}
