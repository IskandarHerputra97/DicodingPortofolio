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
    let stackView = UIStackView()
    let portoImageView = UIImageView()
    let portoNameLabel = UILabel()
    let portoDescriptionLabel = UILabel()
    var indexPathRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .magenta
        title = "Portofolio Detail"
        fetchFirebaseStorageData(index: indexPathRow!)
        
        setupPortoImageView()
        setupPortoNameLabel()
        setupPortoDescriptionLabel()
        setupStackView()
    }
    
    //MARK: - SETUP UI
    func setupStackView() {
        view.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        
        //stackView.addArrangedSubview(portoImageView)
        stackView.addArrangedSubview(portoNameLabel)
        stackView.addArrangedSubview(portoDescriptionLabel)
        
        setStackViewConstraints()
    }
    
    func setupPortoImageView() {
        view.addSubview(portoImageView)
        
        //portoImageView.image = UIImage(named: "ios1")
        
        setPortoImageViewConstraints()
    }
    
    func setupPortoNameLabel() {
        view.addSubview(portoNameLabel)
        
        //portoNameLabel.text = "Portofolio name"
        portoNameLabel.textAlignment = .center
    }
    
    func setupPortoDescriptionLabel() {
        view.addSubview(portoDescriptionLabel)
        
        //portoDescriptionLabel.text = "Portofolio description"
        portoDescriptionLabel.textAlignment = .center
        portoDescriptionLabel.numberOfLines = 0
    }
    
    //MARK: - SET CONSTRAINTS
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: portoImageView.bottomAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        //stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setPortoImageViewConstraints() {
        portoImageView.translatesAutoresizingMaskIntoConstraints = false
        portoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        portoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        portoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        //portoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300).isActive = true
        portoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        //portoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
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

