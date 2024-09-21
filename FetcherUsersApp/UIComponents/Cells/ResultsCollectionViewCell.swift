//
//  ResultsCollectionViewCell.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 20.09.24.
//

import UIKit

protocol ResultsCellDelegate: AnyObject {
    func didTapCheckmark(in cell: ResultsCollectionViewCell)
}

class ResultsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ResultsCellDelegate?
    
    private enum Constants {
        static var ibmPlexSansFont = { "IBMPlexSans-SemiBold" }
        static var doneIcon = { UIImage(systemName: "checkmark.circle.fill") }
        static var noDoneIcon = { UIImage(systemName: "multiply") }
        static var doneColor = { R.color.cAEE67F() }
        static var noDoneColor = { R.color.cB5B8B5() }
    }
    
    var onCompletionStatusChanged: ((Bool) -> Void)?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.font = UIFont(name: Constants.ibmPlexSansFont(), size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var checkmarkView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkmarkTapped))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private var model: TodoModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews([checkmarkView, titleLabel])
    }
    
    private func setupConstraints() {
        checkmarkView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkmarkView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
        }
    }
    
    @objc
    private func checkmarkTapped() {
        model?.completed.toggle()
        delegate?.didTapCheckmark(in: self)
    }
    
    private func updateUI() {
        if model?.completed == true {
            checkmarkView.tintColor = Constants.doneColor()
            checkmarkView.image = Constants.doneIcon()
        } else {
            checkmarkView.tintColor = Constants.noDoneColor()
            checkmarkView.image = Constants.noDoneIcon()
        }
    }
    
    func configure(model: TodoModel) {
        self.model = model
        titleLabel.text = model.title
        if model.completed {
            checkmarkView.tintColor = Constants.doneColor()
            checkmarkView.image = Constants.doneIcon()

        } else {
            checkmarkView.tintColor = Constants.noDoneColor()
            checkmarkView.image = Constants.noDoneIcon()
        }
    }
}
