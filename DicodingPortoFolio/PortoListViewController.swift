//
//  PortoListViewController.swift
//  DicodingPortoFolio
//
//  Created by Iskandar Herputra Wahidiyat on 02/05/20.
//  Copyright © 2020 Iskandar Herputra Wahidiyat. All rights reserved.
//

import UIKit
import Firebase

class PortoListViewController: UIViewController {

    //MARK: PROPERTIES -
    var tableView = UITableView()
    var portoFireStoreData = [Porto]()
    var tempImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchFirestoreData()
        view.backgroundColor = .red
        title = "Portofolio List"
        
        setupNavigationBarItem()
        setupTableView()
    }
    
    //MARK: SETUP UI
    func setupNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(addProfileButtonTapped))
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        tableView.register(PortoTableViewCell.self, forCellReuseIdentifier: "TestCell")
        
        setTableViewConstraints()
    }
    
    //MARK: SET CONSTRAINTS
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    //MARK: ACTIONS
    @objc func addProfileButtonTapped() {
        let profileScreen = ProfileViewController()
        profileScreen.title = "Profil"
        navigationController?.pushViewController(profileScreen, animated: true)
    }
}

extension PortoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return portoFireStoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell") as! PortoTableViewCell
        let portofolio = portoFireStoreData[indexPath.row]
        cell.set(porto: portofolio)
        
        return cell
    }
    
    
}

extension PortoListViewController {
    //Fetch image porto nya
    func fetchFirebaseStorageData() {
        let storageRef = Storage.storage().reference(withPath: "ios2.jpg")
        storageRef.getData(maxSize: 4 * 1024 * 1024) { [weak self] (data, error) in
            //if there is an error
            if let error = error {
                print("Got an error fetching data: \(error.localizedDescription)")
                return
            }
            if let data = data {
                //self?.imageView.image = UIImage(data: data)
                let tempImage = UIImage(data: data)
            }
        }
    }
    
    //Fetch title porto nya
    func fetchFirestoreData() {
        let db = Firestore.firestore()
//        let storageRef = Storage.storage().reference(withPath: "ios2.jpg")
//        //var tempImage: UIImage?
//        storageRef.getData(maxSize: 4 * 1024 * 1024) { [weak self] (data, error) in
//            //if there is an error
//            if let error = error {
//                print("Got an error fetching data: \(error.localizedDescription)")
//                return
//            }
//            if let data = data {
//                //self?.imageView.image = UIImage(data: data)
//                self!.tempImage = UIImage(data: data)
//                print("tempImage = \(self!.tempImage)")
//                //tempImage = UIImage(named: "ios1")
//            }
//        }
        
        db.collection("portofolio").getDocuments{ (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let documentData = document.data()
                    
                    let storageRef = Storage.storage().reference(withPath: "ios2.jpg")
                    //var tempImage: UIImage?
                    storageRef.getData(maxSize: 4 * 1024 * 1024) { [weak self] (data, error) in
                        //if there is an error
                        if let error = error {
                            print("Got an error fetching data: \(error.localizedDescription)")
                            return
                        }
                        if let data = data {
                            //self?.imageView.image = UIImage(data: data)
                            self!.tempImage = UIImage(data: data)
                            print("tempImage = \(self!.tempImage)")
                            //tempImage = UIImage(named: "ios1")
                        }
                    }
                    
                    let name = documentData["name"] as? String ?? ""
                    let description = documentData["description"] as? String ?? ""
                    //let newPorto = Porto(name: name, description: description)
                    let newPorto = Porto(image: UIImage(named: "ios1")!, name: name, description: description)
                    print("newPorto = \(newPorto)")
                    self.portoFireStoreData.append(newPorto)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
