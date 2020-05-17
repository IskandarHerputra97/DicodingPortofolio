//
//  ProfileViewController.swift
//  DicodingPortoFolio
//
//  Created by Iskandar Herputra Wahidiyat on 02/05/20.
//  Copyright © 2020 Iskandar Herputra Wahidiyat. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    //MARK: PROPERTIES
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let cityLabel = UILabel()
    let bioLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .orange
        setupImageView()
        setupNameLabel()
        setupEmailLabel()
        setupCityLabel()
        setupBioLabel()
        setupStackView()
        //setupScrollView()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        fetchFirebaseStorageData()
    }
    
    //MARK: SETUP UI
    func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        setScrollViewConstraints()
    }
    
    func setupStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(bioLabel)
        
        setStackViewConstraints()
    }
    
    func setupImageView() {
        view.addSubview(imageView)
    }
    
    func setupNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.textAlignment = .center
    }
    
    func setupEmailLabel() {
        view.addSubview(emailLabel)
        emailLabel.textAlignment = .center
    }
    
    func setupCityLabel() {
        view.addSubview(cityLabel)
        cityLabel.textAlignment = .center
    }
    
    func setupBioLabel() {
        view.addSubview(emailLabel)
        bioLabel.textAlignment = .center
        bioLabel.numberOfLines = 0
    }
    
    //MARK: SET CONSTRAINTS
    func setScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    //MARK: ACTIONS
    func fetchFirebaseStorageData() {
        let storageRef = Storage.storage().reference(withPath: "profileIcon.png")
        storageRef.getData(maxSize: 4 * 1024 * 1024) { [weak self] (data, error) in
            //if there is an error
            if let error = error {
                print("Got an error fetching data: \(error.localizedDescription)")
                return
            }
            if let data = data {
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}
