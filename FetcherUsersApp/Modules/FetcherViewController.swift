//
//  ViewController.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 18.09.24.
//

import UIKit
import SnapKit
import RswiftResources

class FetcherViewController: UIViewController {
    
    private enum Constants {
        static var backgroundColor = { R.color.c111411() }
        static var titleText = { "Fetcher" }
        static var ibmPlexSansFont = { "IBMPlexSans-SemiBold" }
    }
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.text = Constants.titleText()
        label.font = UIFont(name: Constants.ibmPlexSansFont(), size: 20)
        return label
    }()
    
    private var todoModels: [TodoModel] = []
    
    private var scanView = ScanView()
    
    private var resultPanelView: ResultsPanelView = {
        let view = ResultsPanelView()
        view.layer.cornerRadius = 34
        return view
    }()
    
    private var infoView: InfoView = {
        let view = InfoView()
        view.layer.cornerRadius = 18
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scanView.startPosition()
        resultPanelView.resultButtonDisenable()
        infoView.startState()
    }
    
    private func setupUI() {
        view.backgroundColor = Constants.backgroundColor()
        view.addSubviews([scanView, resultPanelView, infoView])
        
        navigationItem.titleView = titleLabel
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scanTap))
        scanView.addGestureRecognizer(tapGesture)
        
        resultPanelView.onResultsButtonTapped = { [weak self] in
                 self?.resultButtonPress()
             }
    }
    
    private func setupConstraints() {
        
        scanView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(210)
        }
        
        resultPanelView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.height.equalTo(68)
        }
        
        infoView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(resultPanelView.snp.top).offset(-24)
            $0.height.equalTo(60)
        }
    }
    
    private func fetchTodos() {
        infoView.loading()
        scanView.startAnimatingCircles()
        let userId: Int? = resultPanelView.getIsSwitchOn() ? nil : 5
        
        ApiManager.shared.fetchTodoItems(userId: userId) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.scanView.stopAnimatingCircles()
                self?.infoView.stopAnimating()
            }
            
            switch result {
            case .success(let todoModels):
                self?.todoModels = todoModels
                DispatchQueue.main.async {
                    self?.updateUIWithFetchedData()
                }
            case .failure(let error):
                print("Error fetching todo items: \(error.localizedDescription)")
            }
        }
    }

    private func updateUIWithFetchedData() {
        resultPanelView.resultButtonEnable()
        infoView.completed()
    }
    
    private func resultButtonPress() {
        let resultsVC = ResultsViewController()
        resultsVC.resultsModels = todoModels
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    @objc
    private func scanTap() {
        scanView.toggle()
        fetchTodos()
    }
}
