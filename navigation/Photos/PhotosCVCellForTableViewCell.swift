//
//  PhotosCVCellForTableViewCell.swift
//  navigation
//
//  Created by Max Egorov on 3/4/22.
//

import UIKit

class PhotosCVCellForTableViewCell: UICollectionViewCell {
    lazy var imageCVCellForTVC: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageCVCellForTVC)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCVCellForTVC.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
    }
}
