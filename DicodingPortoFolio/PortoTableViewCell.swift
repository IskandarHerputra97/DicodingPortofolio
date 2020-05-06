//
//  PortoTableViewCell.swift
//  DicodingPortoFolio
//
//  Created by Iskandar Herputra Wahidiyat on 02/05/20.
//  Copyright © 2020 Iskandar Herputra Wahidiyat. All rights reserved.
//

import UIKit

class PortoTableViewCell: UITableViewCell {
    
    var portoImageView = UIImageView()
    var portoTitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(portoImageView)
        addSubview(portoTitleLabel)
        
        configurePortoImageView()
        configurePortoTitleLable()
        setPortoImageViewConstraints()
        setPortoTitleLabelConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(porto: Porto) {
        portoImageView.image = porto.image
        portoTitleLabel.text = porto.name
    }
    
    func configurePortoImageView() {
        portoImageView.layer.cornerRadius = 10
        portoImageView.clipsToBounds = true
    }
    
    func configurePortoTitleLable() {
        portoTitleLabel.numberOfLines = 0
        portoTitleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setPortoImageViewConstraints() {
        portoImageView.translatesAutoresizingMaskIntoConstraints = false
        portoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        portoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        portoImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        portoImageView.widthAnchor.constraint(equalTo: portoImageView.heightAnchor, multiplier: 16/9).isActive = true
    }
    
    func setPortoTitleLabelConstraints() {
        portoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        portoTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        portoTitleLabel.leadingAnchor.constraint(equalTo: portoImageView.trailingAnchor, constant: 20).isActive = true
        portoTitleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        portoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
    
}
