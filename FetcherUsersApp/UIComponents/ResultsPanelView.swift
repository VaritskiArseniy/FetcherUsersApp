//
//  ResultsPanelView.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 18.09.24.
//

import UIKit

class ResultsPanelView: UIView {
    
    private enum Constants {
        static var backgroundColor = { R.color.с292C29_60() }
        static var buttonText = { "Show Results" }
        static var greenColor = { R.color.cAEE67F() }
    }
    
    private lazy var resultsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.buttonText(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 22
        button.backgroundColor = Constants.greenColor()
        button.alpha = 0.3
        button.isEnabled = false
        return button
    }()
    
    private var customSwitch = CustomSwitch()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = Constants.backgroundColor()
        addSubviews([resultsButton, customSwitch])
    }
    
    private func setupConstraints() {
        resultsButton.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(12)
            $0.width.equalTo(155)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        customSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(36)
            $0.width.equalTo(71)
            $0.centerY.equalToSuperview()
        }
        
    }
    
    func resultButtonEnable() {
        resultsButton.alpha = 1
        resultsButton.isEnabled = true
    }
    
    func getIsSwitchOn() -> Bool {
        return customSwitch.getIsOn()
    }
}
