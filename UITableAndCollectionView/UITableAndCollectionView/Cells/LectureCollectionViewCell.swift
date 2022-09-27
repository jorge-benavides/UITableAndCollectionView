import UIKit

class LectureCollectionViewCell: UICollectionViewCell {

    private let iconImageView: UIImageView = {
        let avatar = UIImage(systemName: "books.vertical.fill")
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

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            nameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
        ])

        let bottomConstraint = nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
    }

    public func configure(_ lecture: Lecture) {
        nameLabel.text = lecture.name
    }

}
