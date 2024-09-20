//
//  ResultsViewController.swift
//  FetcherUsersApp
//
//  Created by Арсений Варицкий on 20.09.24.
//

import UIKit

class ResultsViewController: UIViewController {
    
    private enum Constants {
        static var titleText = { "Todos" }
        static var ibmPlexSansFont = { "IBMPlexSans-SemiBold" }
        static var cellIndificator = { "cellIndificator" }
        static var headerIndificator = { "headerIndificator" }
        static var backImage = { R.image.backImage() }
        static var completedSectionTitle = { "Completed" }
        static var notCompletedSectionTitle = { "Not сompleted" }
        static var cellHeight = { CGFloat(56) }
        static var grayColor = { R.color.cB5B8B5() }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = Constants.titleText()
        label.font = UIFont(name: Constants.ibmPlexSansFont(), size: 20)
        return label
    }()
    
    var resultsModels: [TodoModel] = []
    var completedModels: [TodoModel] = []
    var notCompletedModels: [TodoModel] = []
    
    private var infoView: InfoView = {
        let view = InfoView()
        view.layer.cornerRadius = 18
        return view
    }()
    
    private let resultsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        setupNavigationBar()
        divideTasksIntoSections()
        infoView.results()
        setupCollectionView()
        
        view.addSubviews([infoView, resultsCollection])
    }
    
    private func setupConstraints() {
        infoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        resultsCollection.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func divideTasksIntoSections() {
        completedModels = resultsModels.filter { $0.completed }
        notCompletedModels = resultsModels.filter { !$0.completed }
    }

    private func setupNavigationBar() {
        navigationItem.titleView = titleLabel
        let backImage = Constants.backImage()
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        resultsCollection.collectionViewLayout = layout
        resultsCollection.backgroundColor = .clear
        
        resultsCollection.register(ResultsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIndificator()
        )
        
        resultsCollection.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: Constants.headerIndificator()
        )
        
        resultsCollection.delegate = self
        resultsCollection.dataSource = self
        resultsCollection.showsVerticalScrollIndicator = true
    }
}

extension ResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? self.notCompletedModels.count : self.completedModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIndificator(),
            for: indexPath
        ) as? ResultsCollectionViewCell else {
            return UICollectionViewCell()
        }

        let model = indexPath.section == 0 ? self.notCompletedModels[indexPath.item] : self.completedModels[indexPath.item]
        
        cell.configure(model: model)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.cellHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: Constants.headerIndificator(),
                for: indexPath
            )
            
            header.subviews.forEach { $0.removeFromSuperview() }

            let label: UILabel = {
                let label = UILabel()
                label.textColor = Constants.grayColor()
                label.font = UIFont(name: Constants.ibmPlexSansFont(), size: 15)
                label.text = indexPath.section == 0 ? Constants.notCompletedSectionTitle(): Constants.completedSectionTitle()
                label.alpha = 0.6
                return label
            }()
            
            let separator: UIView = {
                let separator = UIView()
                separator.backgroundColor = Constants.grayColor()
                separator.alpha = 0.65
                return separator
            }()
            
            header.addSubviews([label, separator])
            
            label.snp.makeConstraints {
                $0.leading.equalToSuperview()
                $0.centerY.equalToSuperview()
            }
            
            separator.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(0.5)
            }
            
            return header
        }
        return UICollectionReusableView()
    }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
         return CGSize(width: collectionView.frame.width, height: 40)
     }
}

extension ResultsViewController: ResultsCellDelegate {
    func didTapCheckmark(in cell: ResultsCollectionViewCell) {
        
        guard let indexPath = resultsCollection.indexPath(for: cell) else { return }
        
        let model = indexPath.section == 0 ? notCompletedModels[indexPath.item] : completedModels[indexPath.item]
        
        if let index = resultsModels.firstIndex(where: { $0.id == model.id }) {
            resultsModels[index].completed.toggle()
            
            divideTasksIntoSections()
            
            resultsCollection.reloadData()
        }
    }
}
