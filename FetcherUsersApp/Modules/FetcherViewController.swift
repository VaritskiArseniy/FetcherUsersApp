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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubviews([titleLabel,scanView, resultPanelView])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scanTap))
        scanView.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
        
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
    }
    
    private func fetchTodos() {
        let userId: Int? = resultPanelView.getIsSwitchOn() ? nil : 5
        
        ApiManager.shared.fetchTodoItems(userId: userId) { [weak self] result in
            switch result {
            case .success(let todoModels):
                self?.todoModels = todoModels
                DispatchQueue.main.async {
                    self?.updateUIWithFetchedData()
                }
                print("Fetched todo items: \(todoModels)")
            case .failure(let error):
                print("Error fetching todo items: \(error.localizedDescription)")
            }
        }
    }

    private func updateUIWithFetchedData() {
        resultPanelView.resultButtonEnable()
    }
    
    @objc
    private func scanTap() {
        scanView.toggle()
        fetchTodos()
        
    }
}
