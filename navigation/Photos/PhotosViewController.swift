//
//  PhotosViewController.swift
//  navigation
//
//  Created by Max Egorov on 3/4/22.
//

import UIKit

class PhotosViewController: UIViewController {
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        return layout
    }()
    
    private lazy var photosCV: UICollectionView = {
        let photosCV = UICollectionView(frame: .zero,
                                        collectionViewLayout: layout)
        photosCV.backgroundColor = .white
        photosCV.delegate = self
        photosCV.dataSource = self
        photosCV.register(PhotosCollectionViewCell.self,
                          forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        photosCV.translatesAutoresizingMaskIntoConstraints = false
        return photosCV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpConstraint()
        
        title = "Photo Gallery"
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setUpView() {
        view.addSubview(photosCV)
    }
    
    private func setUpConstraint() {
        let photosCVTop = photosCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let photosCVLeft = photosCV.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8)
        let photosCVRight = photosCV.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        let photosCVBottom = photosCV.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        NSLayoutConstraint.activate([photosCVTop, photosCVLeft, photosCVRight, photosCVBottom])
    }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize{
        let neededWidth = width - 2 * spacing
        let itemWidth = neededWidth / itemsPerRow
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        cell.imageCVCell.image = photosArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)!.minimumLineSpacing
        return self.itemSize(for: collectionView.frame.width, with: spacing)
    }
}
