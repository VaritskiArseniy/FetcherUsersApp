//
//  ResultsViewController.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 20.09.24.
//

import UIKit

class ResultsViewController: UIViewController {
    
    private enum Constants {
        static var titleText = { "Todos" }
        static var ibmPlexSansFont = { "IBMPlexSans-SemiBold" }
        static var backImage = { R.image.backImage() }
    }
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = Constants.titleText()
        label.font = UIFont(name: Constants.ibmPlexSansFont(), size: 20)
        return label
    }()
    
    var resultsModels: [TodoModel] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        setupNavigationBar()
        view.addSubviews([])
        
        
    }
    
    private func setupConstraints() {
       
    }

    private func setupNavigationBar() {
        navigationItem.titleView = titleLabel
        let backImage = Constants.backImage()
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
