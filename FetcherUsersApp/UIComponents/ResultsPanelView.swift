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
    }


    
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
      addSubviews([])
        
    }
 
    private func setupConstraints() {

    }
}
