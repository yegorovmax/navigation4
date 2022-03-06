//
//  PhotosCollectionViewCell.swift
//  navigation
//
//  Created by Max Egorov on 3/4/22.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    lazy var imageCVCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageCVCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCVCell.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
}

