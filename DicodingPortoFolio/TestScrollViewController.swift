//
//  TestScrollViewController.swift
//  DicodingPortoFolio
//
//  Created by Iskandar Herputra Wahidiyat on 14/05/20.
//  Copyright © 2020 Iskandar Herputra Wahidiyat. All rights reserved.
//


import UIKit

class TestScrollViewController: UIViewController {

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let redView = UIView()
    let yellowView = UIView()
    let greenView = UIView()
    let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Page 2"
        
        setupRedView()
        setupYellowView()
        setupGreenView()
        setupTestLabel()
        
        setupScrollView()
    
        setupStackView()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
      
        scrollView.addSubview(stackView)
 
        setScrollViewConstraints()
    }
    
    func setupStackView() {
        stackView.axis = .vertical
        
        stackView.spacing = 10
        
        stackView.addArrangedSubview(redView)
        stackView.addArrangedSubview(yellowView)
        stackView.addArrangedSubview(greenView)
        stackView.addArrangedSubview(testLabel)
        
        setStackViewConstraints()
    }
    
    func setupTestLabel() {
        testLabel.text = "This is a test label"
    }
    
    func setupRedView() {
        redView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        redView.backgroundColor = .red
    }
    
    func setupYellowView() {
        yellowView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        yellowView.backgroundColor = .yellow
    }
    
    func setupGreenView() {
        greenView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
        greenView.backgroundColor = .green
    }
    
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
        // this is important for scrolling
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}
