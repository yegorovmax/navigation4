//
//  PhotosTableViewCell.swift
//  navigation
//
//  Created by Max Egorov on 3/4/22.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    private let itemsPerRow: CGFloat = 4
    
    private lazy var layoutTableViewCell: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var photosCVTableViewCell: UICollectionView = {
        let photosCV = UICollectionView(frame: .zero,
                                        collectionViewLayout: layoutTableViewCell)
        photosCV.backgroundColor = .white
        photosCV.delegate = self
        photosCV.dataSource = self
        photosCV.register(PhotosCVCellForTableViewCell.self,
                          forCellWithReuseIdentifier: "PhotosCVCellForTableViewCell")
        photosCV.clipsToBounds = true
        photosCV.translatesAutoresizingMaskIntoConstraints = false
        return photosCV
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.tintColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var tableViewBarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        addSubview(label)
        addSubview(tableViewBarButton)
        addSubview(photosCVTableViewCell)
    }
    
    func setUpConstraints() {
        let labelTop = label.topAnchor.constraint(equalTo: self.topAnchor, constant: 12)
        let labelLeft = label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)


        let photosCVTableViewCellTop = photosCVTableViewCell.topAnchor.constraint(equalTo: self.label.bottomAnchor, constant: 12)
        let photosCVTableViewCellLeft = photosCVTableViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12)
        let photosCVTableViewCellRight = photosCVTableViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        let photosCVTableViewCellBottom = photosCVTableViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        

        let tableViewBarButtonCentreY = tableViewBarButton.centerYAnchor.constraint(equalTo: self.label.centerYAnchor)
        let tableViewBarButtonRight = tableViewBarButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        let tableViewBarButtonAspectRatio = tableViewBarButton.heightAnchor.constraint(equalTo: self.tableViewBarButton.widthAnchor, multiplier: 1.0)
        
        NSLayoutConstraint.activate([labelTop, labelLeft,
                                     photosCVTableViewCellTop, photosCVTableViewCellLeft, photosCVTableViewCellRight, photosCVTableViewCellBottom,
                                     tableViewBarButtonCentreY, tableViewBarButtonRight, tableViewBarButtonAspectRatio
                                    ])
    }
    
    private func itemSize(width: CGFloat, height: CGFloat, spacing: CGFloat) -> CGSize{
        let neededWidth = width - spacing * 4
        let itemWidth = neededWidth / itemsPerRow
        return CGSize(width: itemWidth, height: height)
    }
}


extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCVCellForTableViewCell", for: indexPath) as! PhotosCVCellForTableViewCell
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 6
        cell.clipsToBounds = true
        cell.imageCVCellForTVC.image = photosArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)!.minimumInteritemSpacing
        return self.itemSize(width: collectionView.frame.width, height: collectionView.frame.height, spacing: spacing)
    }
}
