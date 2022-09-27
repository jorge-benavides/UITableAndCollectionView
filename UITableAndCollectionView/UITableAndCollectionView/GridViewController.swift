import UIKit

class GridViewController: UIViewController, UICollectionViewDataSource {

    struct CellConfig {
        let identifier: String
        let classType: UICollectionViewCell.Type
    }

    enum CellType: Int, CaseIterable {
        case lecture = 0, student
        var config: CellConfig {
            switch self {
            case .lecture:
                return CellConfig(identifier: "LectureCollectionViewCell", classType: LectureCollectionViewCell.self)
            case .student:
                return CellConfig(identifier: "StudentCollectionViewCell", classType: StudentCollectionViewCell.self)
            }
        }
    }

    private let course = CourseInfo()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        CellType.allCases.forEach {
            collectionView.register($0.config.classType, forCellWithReuseIdentifier: $0.config.identifier)
        }
        return collectionView
    }()

    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 60, height: 60))
        toolbar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()

    lazy
    private var gesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(gesture:)))
        gesture.minimumPressDuration = 0.02
        gesture.isEnabled = false
        return gesture
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(toolbar)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        collectionView.dataSource = self

        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed(_:)))
        ]

        collectionView.addGestureRecognizer(gesture)
    }

    @objc func editButtonPressed(_ sender: UIBarButtonItem) {
        gesture.isEnabled.toggle()
        sender.tintColor = gesture.isEnabled ? .red : .link
    }

    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case .began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case .ended:
            collectionView.performBatchUpdates({ [weak self] in
                self?.collectionView.endInteractiveMovement()
            })
        break
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        CellType.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: return the number of rows for students and lectures
        2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = CellType(rawValue: indexPath.section) else {
            fatalError("unregistred cell")
        }
        switch cellType {
        case .lecture:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.config.identifier, for: indexPath) as! LectureCollectionViewCell
            cell.configure(course.lecture(for: indexPath.row))
            return cell
        case .student:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.config.identifier, for: indexPath) as! StudentCollectionViewCell
            cell.configure(course.student(for: indexPath.row))
            return cell
        }
    }

    // TODO: implement editing method for rows
    // TODO: restring editing between sections
}
