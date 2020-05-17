//
//  PortoDetailViewController.swift
//  DicodingPortoFolio
//
//  Created by Iskandar Herputra Wahidiyat on 13/05/20.
//  Copyright © 2020 Iskandar Herputra Wahidiyat. All rights reserved.
//

import UIKit
import Firebase

class PortoDetailViewController: UIViewController {

    //MARK: - PROPERTIES
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let portoImageView = UIImageView()
    let portoNameLabel = UILabel()
    let portoDescriptionLabel = UILabel()
    var indexPathRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Portofolio Detail"
        fetchFirebaseStorageData(index: indexPathRow ?? 0)
        
        setupPortoImageView()
        setupPortoNameLabel()
        setupPortoDescriptionLabel()
        
        setupScrollView()
        
        setupStackView()
    }
    
    //MARK: - SETUP UI
    func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        setScrollViewConstraints()
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.addArrangedSubview(portoImageView)
        stackView.addArrangedSubview(portoNameLabel)
        stackView.addArrangedSubview(portoDescriptionLabel)
        
        setStackViewConstraints()
    }
    
    func setupPortoImageView() {
        portoImageView.image = UIImage(named: "ios1")
        
        portoImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setupPortoNameLabel() {
        //portoNameLabel.text = "Portofolio name"
        portoNameLabel.textAlignment = .center

        portoNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupPortoDescriptionLabel() {
        //portoDescriptionLabel.text = "Portofolio description"
        portoDescriptionLabel.textAlignment = .center
        portoDescriptionLabel.numberOfLines = 0
        
        portoDescriptionLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    //MARK: - SET CONSTRAINTS
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func fetchFirebaseStorageData(index: Int) {
        let storageRef = Storage.storage().reference(withPath: "ios\(index+1).jpg")
        storageRef.getData(maxSize: 4 * 1024 * 1024) { [weak self] (data, error) in
            //if there is an error
            if let error = error {
                print("Got an error fetching data: \(error.localizedDescription)")
                return
            }
            if let data = data {
                self?.portoImageView.image = UIImage(data: data)
            }
        }
    }
}

