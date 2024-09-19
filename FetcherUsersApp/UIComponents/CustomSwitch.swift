//
//  CustomSwitch.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 19.09.24.
//

import UIKit
import SnapKit

class CustomSwitch: UIView {
    
    private enum Constants {
        static var greenColor = { R.color.cAEE67F() }
        static var offColor = { UIColor.gray }
        static var onImage = { UIImage(systemName: "person.fill") }
        static var offImage = { UIImage(systemName: "person.slash.fill") }
        static var imageOnColor = { R.color.c203008_60() }
    }
    
    var valueChanged: ((Bool) -> Void)?
    
    private var isOn = false
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.offColor()
        view.layer.cornerRadius = 18
        return view
    }()
    
    private lazy var toggleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 2
        return view
    }()
    
    private lazy var onImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.onImage()
        imageView.tintColor = Constants.imageOnColor()
        return imageView
    }()
    
    private lazy var offImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.offImage()
        imageView.tintColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        addGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews([backgroundView, onImageView, offImageView, toggleView])
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(32)
            $0.width.equalTo(60)
        }
        
        toggleView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(3)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(28)
        }
        
        onImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(11)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }
        
        offImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(11)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(18)
        }
    }
    
    private func addGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSwitch))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapSwitch() {
        toggleSwitch(animated: true)
    }
    
    private func toggleSwitch(animated: Bool) {
        isOn.toggle()
        
        let togglePosition = isOn ? self.frame.width - toggleView.frame.width - 4 : 2
        let backgroundColor = isOn ? Constants.greenColor() : Constants.offColor()
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.toggleView.snp.updateConstraints { make in
                    make.leading.equalToSuperview().offset(togglePosition)
                }
                self.backgroundView.backgroundColor = backgroundColor
                self.layoutIfNeeded()
            }
        } else {
            toggleView.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(togglePosition)
            }
            backgroundView.backgroundColor = backgroundColor
        }
        
        valueChanged?(isOn)
    }
    
    func setOn(_ isOn: Bool, animated: Bool) {
        self.isOn = isOn
        toggleSwitch(animated: animated)
    }
    
    func getIsOn() -> Bool {
        return self.isOn
    }
}
