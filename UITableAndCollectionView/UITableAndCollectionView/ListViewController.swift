import UIKit

class ListViewController: UIViewController, UITableViewDataSource {

    struct CellConfig {
        let headerTitle: String
        let identifier: String
        let classType: UITableViewCell.Type
    }
    
    enum CellType: Int, CaseIterable {
        case lecture = 0, student
        var config: CellConfig {
            switch self {
            case .lecture:
                return CellConfig(headerTitle: "Lectures",
                                  identifier: "LectureTableViewCell",
                                  classType: LectureTableViewCell.self)
            case .student:
                return CellConfig(headerTitle: "Students",
                                  identifier: "StudentTableViewCell",
                                  classType: StudentTableViewCell.self)
            }
        }
    }

    private let course = CourseInfo()

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: .init(x: 0, y: 0, width: 60, height: 60))
        toolbar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(toolbar)
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: toolbar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        tableView.dataSource = self
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed(_:)))
        ]
    }

    @objc func editButtonPressed(_ sender: UIBarButtonItem) {
        sender.tintColor = tableView.isEditing ? .red : .link
        // TODO: Enable editing
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        CellType.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: return the number of rows for students and lectures
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: return the custom Cell clases
        let cellType = CellType(rawValue: indexPath.section)
        let cell = UITableViewCell()
        switch cellType {
        case .lecture:
            cell.textLabel?.text = course.lecture(for: indexPath.row).name
        case .student:
            cell.textLabel?.text = course.student(for: indexPath.row).name
        case .none:
            break
        }
        return cell
    }

    // TODO: Add a header for each section
    // TODO: implement editing method for rows
    // TODO: restring editing between sections
    // TODO: when editing mode remove the delete icon and the identation
}
