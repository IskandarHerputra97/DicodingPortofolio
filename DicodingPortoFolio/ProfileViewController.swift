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
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .yellow
    }
    

    override func viewWillAppear(_ animated: Bool) {
        setupImageView()
        fetchFirebaseStorageData()
    }
    
    //MARK: SETUP UI
    func setupImageView() {
        view.addSubview(imageView)
        //imageView.image = UIImage(named: "ios1")
        
        setImageViewConstraints()
    }
    
    //MARK: SET CONSTRAINTS
    func setImageViewConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: ACTIONS
    func fetchFirebaseStorageData() {
        let storageRef = Storage.storage().reference(withPath: "ios2.jpg")
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
