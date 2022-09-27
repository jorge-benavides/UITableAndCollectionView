import UIKit

class StudentCollectionViewCell: UICollectionViewCell {

    private let iconImageView: UIImageView = {
        let avatar = UIImage(systemName: "graduationcap.fill")
        let view = UIImageView(image: avatar)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemBlue
        view.contentMode = .scaleAspectFit
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .label
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {

        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bioLabel)

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            bioLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bioLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 140),
        ])
        let bottomConstraint = bioLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
    }

    public func configure(_ student: Student) {
        nameLabel.text = student.name
        bioLabel.text = student.biography
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        layoutAttributes.frame.size = size
        return layoutAttributes
    }
}
