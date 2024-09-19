//
//  ScanView.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 18.09.24.
//

import UIKit

class ScanView: UIView {
    
    private enum Constants {
        static var wifiIcon = { R.image.wifiIcon() }
    }

    private lazy var logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = Constants.wifiIcon()
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
      addSubviews([logoImageView])
        
    }
 
    private func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
        }
    }
}
