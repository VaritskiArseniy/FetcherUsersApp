//
//  ScanView.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 18.09.24.
//

import UIKit

class ScanView: UIView {
    
    private enum Constants {
        static var wifiOffIcon = { R.image.wifiOffIcon() }
        static var wifiOnIcon = { R.image.wifiOnIcon() }
        static var grayColor1 = { R.color.с292C29() }
        static var grayColor2 = { R.color.c1E201E() }
        static var greenColor = { R.color.cAEE67F() }
    }
    
    var scanState = false

    private lazy var logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = Constants.wifiOffIcon()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var circleView1: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.grayColor1()
        view.layer.cornerRadius = 80
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var circleView2: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.grayColor2()
        view.layer.cornerRadius = 105
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
      addSubviews([circleView2, circleView1, logoImageView])
        
    }
 
    private func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        circleView1.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(160)
        }
        
        circleView2.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(210)
        }
    }
    
    func toggle() {
        scanState.toggle()
        
        if scanState {
            logoImageView.image = Constants.wifiOnIcon()
            circleView1.backgroundColor = Constants.greenColor()
            circleView2.backgroundColor = Constants.greenColor()
            circleView1.alpha = 0.15
            circleView2.alpha = 0.10
            
        }
    }
    
    func startPosition() {
        logoImageView.image = Constants.wifiOffIcon()
        circleView1.backgroundColor = Constants.grayColor1()
        circleView2.backgroundColor = Constants.grayColor2()
        circleView1.alpha = 1
        circleView2.alpha = 1
    }
}
