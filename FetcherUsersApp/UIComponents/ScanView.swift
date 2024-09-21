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
        static var grayColor3 = { R.color.c181818() }
        static var grayColor4 = { R.color.c151515() }
        static var greenColor = { R.color.cAEE67F() }
    }
    
    private var isAnimating = false
    
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
    
    private lazy var circleView3: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.grayColor3()
        view.layer.cornerRadius = 130
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var circleView4: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.grayColor4()
        view.layer.cornerRadius = 160
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
      addSubviews([circleView4, circleView3, circleView2, circleView1, logoImageView])
        
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
        
        circleView3.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(260)
        }
        
        circleView4.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(320)
        }
    }
    
    func toggle() {
        scanState.toggle()
        
        if scanState {
            logoImageView.image = Constants.wifiOnIcon()
            circleView1.backgroundColor = Constants.greenColor()
            circleView2.backgroundColor = Constants.greenColor()
            circleView3.backgroundColor = Constants.greenColor()
            circleView4.backgroundColor = Constants.greenColor()
            circleView1.alpha = 0.15
            circleView2.alpha = 0.10
            circleView3.alpha = 0.06
            circleView4.alpha = 0.03
        }
    }
    
    func startPosition() {
        logoImageView.image = Constants.wifiOffIcon()
        circleView1.backgroundColor = Constants.grayColor1()
        circleView2.backgroundColor = Constants.grayColor2()
        circleView3.backgroundColor = Constants.grayColor3()
        circleView4.backgroundColor = Constants.grayColor4()
        circleView1.alpha = 1
        circleView2.alpha = 1
        circleView3.alpha = 1
        circleView4.alpha = 1
    }
    
    func startAnimatingCircles() {
        guard !isAnimating else { return }
        isAnimating = true
        animatingCircles(
            view: circleView3,
            fromScale: 0.9,
            toScale: 1,
            duration: 3
        )
        animatingCircles(
            view: circleView4,
            fromScale: 0.8,
            toScale: 1,
            duration: 3
        )
    }
    
    func stopAnimatingCircles() {
        guard isAnimating else { return }
        
        isAnimating = false
        
        let currentTransform3 = circleView3.layer.presentation()?.transform ?? CATransform3DIdentity
        let currentTransform4 = circleView4.layer.presentation()?.transform ?? CATransform3DIdentity
        
        circleView3.layer.removeAllAnimations()
        circleView4.layer.removeAllAnimations()
        
        circleView3.layer.transform = currentTransform3
        circleView4.layer.transform = currentTransform4
        
        UIView.animate(withDuration: 0.5) {
            self.circleView3.transform = .identity
            self.circleView4.transform = .identity
        }
    }
    
    private func animatingCircles(view: UIView, fromScale: CGFloat, toScale: CGFloat, duration: CFTimeInterval) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = fromScale
        scaleAnimation.toValue = toScale
        scaleAnimation.duration = duration
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity
        
        view.layer.add(scaleAnimation, forKey: "scale")
    }
}
