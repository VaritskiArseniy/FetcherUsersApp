//
//  InfoView.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 20.09.24.
//

import UIKit

class InfoView: UIView {
    
    private enum Constants {
        static var backgroundColor = { R.color.с292C29_60() }
        static var tintColor = { R.color.cB5B8B5() }
        static var tapImage = { R.image.tapImage() }
        static var loadImage = { R.image.loadImage() }
        static var completedImage = { R.image.completedImage() }
        static var ibmPlexSansFont = { "IBMPlexSans-SemiBold" }
        static var tapText = { "Tap on the button to fetch todos" }
        static var loadText = { "It’ll take a couple of seconds" }
        static var completedText = { "The fetch successfully completed." }
        static var resultsText = { "Tap on the todo to change status" }
    }
    
    private var isAnimating = false
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.tapImage()
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = Constants.tintColor()
        label.font = UIFont(name: Constants.ibmPlexSansFont(), size: 14)
        label.text = Constants.tapText()
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
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
        backgroundColor = Constants.backgroundColor()
        stackView.addArrangedSubviews([imageView, label])
        addSubviews([stackView])
    }
    
    private func setupConstraints() {
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        imageView.snp.makeConstraints {
            $0.size.equalTo(28)
        }
    }
    
    func startAnimating() {
         guard !isAnimating else { return }
         isAnimating = true
         rotateView(view: imageView, duration: 3)
     }
     
     func stopAnimating() {
         isAnimating = false
         imageView.layer.removeAllAnimations()
     }
     
     private func rotateView(view: UIView, duration: CFTimeInterval) {
         let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
         rotationAnimation.toValue = CGFloat.pi * 2.0
         rotationAnimation.duration = duration
         rotationAnimation.isCumulative = true
         rotationAnimation.repeatCount = .infinity
         
         view.layer.add(rotationAnimation, forKey: "rotationAnimation")
     }
    
    func startState() {
        imageView.image = Constants.tapImage()
        label.text = Constants.tapText()
    }
    
    func loading() {
        imageView.image = Constants.loadImage()
        label.text = Constants.loadText()
        startAnimating()
    }
    
    func completed() {
        imageView.image = Constants.completedImage()
        label.text = Constants.completedText()
    }
    
    func results() {
        label.text = Constants.resultsText()
    }
}
