//
//  PhotosListViewCell.swift
//  navigation
//
//  Created by Max Egorov on 2/27/22.
//

import UIKit

class PhotosListViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        var title: String // никнейм автора публикации
        var description: String // текст публикации
        var image: String // имя картинки из каталога Assets.xcassets
        var likes: String // количество лайков
        var views: String // количество просмотров
    }
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var likeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var likeTitle: UILabel = {
        let label = UILabel()
        label.text  = "Likes: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var viewTitle: UILabel = {
        let label = UILabel()
        label.text  = "Views: "
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = self.frame.size.width
        label.textColor = .black
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.postImageView.image = nil
        self.descriptionLabel.text = nil
        self.likeTitle.text = nil
        self.viewTitle.text = nil
    }
    
    private func setupView() {
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.titleLabel)
        self.backView.addSubview(self.postImageView)
        self.backView.addSubview(self.descriptionLabel)
        self.backView.addSubview(self.likeStackView)
        self.likeStackView.addArrangedSubview(self.likeTitle)
        self.likeStackView.addArrangedSubview(self.viewTitle)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomConstraint = self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        let topConstraintTitleLabel = self.titleLabel.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 16)
        let leadingConstraintTitleLabel = self.titleLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraintTitleLabel = self.titleLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        
        let topConstraintPostImageView = self.postImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12)
        let leadingConstraintPostImageView = self.postImageView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor)
        let trailingConstraintPostImageView = self.postImageView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor)
        let widthPostImageView = self.postImageView.heightAnchor.constraint(equalTo: self.backView.widthAnchor, multiplier: 1.0)
        
        let topConstraintDescriptionLabel = self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16)
        let leadingConstraintDescriptionLabell = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraintDescriptionLabel = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        
        let topConstraintLikeStackView = self.likeStackView.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        let leadingConstraintLikeStackView = self.likeStackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16)
        let trailingConstraintLikeStackView = self.likeStackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor, constant: -16)
        let bottomConstraintLikeStackView = self.likeStackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, bottomConstraint, trailingConstraint,
            topConstraintTitleLabel, topConstraintPostImageView,widthPostImageView,
            leadingConstraintTitleLabel, trailingConstraintTitleLabel,
            topConstraintDescriptionLabel, leadingConstraintDescriptionLabell,
            trailingConstraintDescriptionLabel, topConstraintLikeStackView,
            leadingConstraintLikeStackView, trailingConstraintLikeStackView,
            bottomConstraintLikeStackView, leadingConstraintPostImageView,
            trailingConstraintPostImageView])
    }
}

extension PhotosListViewCell: ViewModelProtocol {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        
        self.titleLabel.text = viewModel.title
        self.postImageView.image = UIImage(named: viewModel.image)
        self.descriptionLabel.text = viewModel.description
        self.likeTitle.text? += viewModel.likes
        self.viewTitle.text? += viewModel.views
    }
}
