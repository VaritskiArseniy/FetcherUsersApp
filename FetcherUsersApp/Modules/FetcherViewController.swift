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
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.centerX.equalToSuperview()
        }
        
        scanView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(view.bounds.width).offset(56)
        }
        
        resultPanelView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            $0.height.equalTo(68)
        }
    }

}
