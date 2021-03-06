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

    //MARK: - PROPERTIES
    var imageView = UIImageView()
    var tableView = UITableView()
    var portoFireStoreData = [Porto]()
    var userData = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchFirestoreData()
        fetchUserFireStoreData()
        view.backgroundColor = .red
        title = "Portofolio List"
        
        setupNavigationBarItem()
        setupTableView()
    }
    
    //MARK: - SETUP UI
    func setupNavigationBarItem() {
        let profileButton = UIButton(type: .system)
        profileButton.setImage(UIImage(named: "profileIcon24")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        profileButton.imageView?.contentMode = .scaleAspectFit
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 100
        tableView.register(PortoTableViewCell.self, forCellReuseIdentifier: "TestCell")
        
        setTableViewConstraints()
    }
    
    //MARK: - SET CONSTRAINTS
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    //MARK: ACTIONS
    @objc func profileButtonTapped() {
        let profileScreen = ProfileViewController()
        profileScreen.title = "Profil"
        profileScreen.nameLabel.text = userData[0].name
        profileScreen.emailLabel.text = userData[0].email
        profileScreen.cityLabel.text = userData[0].city
        profileScreen.bioLabel.text = userData[0].bio
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
        
        cell.set(porto: portofolio, indexPathRow: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let portoDetailViewController = PortoDetailViewController()
       
        //portoDetailViewController.portoImageView.image =
        portoDetailViewController.indexPathRow = indexPath.row
        portoDetailViewController.portoNameLabel.text = portoFireStoreData[indexPath.row].name
        portoDetailViewController.portoDescriptionLabel.text = portoFireStoreData[indexPath.row].description
        navigationController?.pushViewController(portoDetailViewController, animated: true)
    }
}

extension PortoListViewController {
    //Fetch title porto nya
    func fetchFirestoreData() {
        let db = Firestore.firestore()
        
        db.collection("portofolio").getDocuments{ (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let documentData = document.data()
                    
                    let name = documentData["name"] as? String ?? ""
                    let description = documentData["description"] as? String ?? ""
                    let newPorto = Porto(name: name, description: description)

                    self.portoFireStoreData.append(newPorto)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func fetchUserFireStoreData() {
        let db = Firestore.firestore()
        
        db.collection("user").getDocuments{ (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents {
                    let documentData = document.data()
                    
                    let name = documentData["name"] as? String ?? ""
                    let email = documentData["email"] as? String ?? ""
                    let city = documentData["city"] as? String ?? ""
                    let bio = documentData["bio"] as? String ?? ""
                    let newUser = User(name: name, email: email, city: city, bio: bio)
                    
                    self.userData.append(newUser)
                }
            }
        }
    }
}
