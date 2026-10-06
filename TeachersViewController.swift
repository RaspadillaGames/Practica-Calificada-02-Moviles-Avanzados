import UIKit

class TeachersViewController: UITableViewController, UISearchResultsUpdating {

    // 8 docentes (nombre, curso)
    let teachers = [
        (name: "John Doe", subject: "Mathematics"),
        (name: "Anna Smith", subject: "Physics"),
        (name: "Robert Johnson", subject: "Chemistry"),
        (name: "Maria Brown", subject: "Biology"),
        (name: "David Wilson", subject: "History"),
        (name: "Emily Garcia", subject: "English"),
        (name: "Thomas Martinez", subject: "Computer Science"),
        (name: "Laura Taylor", subject: "Art")
    ]

    var filtered: [(name: String, subject: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Teachers"
        filtered = teachers

        // Buscador
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
    }

    // Filtra mientras se escribe
    func updateSearchResults(for searchController: UISearchController) {
        let text = (searchController.searchBar.text ?? "").lowercased()
        if text.isEmpty {
            filtered = teachers
        } else {
            filtered = teachers.filter {
                $0.name.lowercased().contains(text) || $0.subject.lowercased().contains(text)
            }
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let teacher = filtered[indexPath.row]
        cell.textLabel?.text = teacher.name
        cell.detailTextLabel?.text = teacher.subject
        cell.imageView?.image = UIImage(systemName: "person.circle.fill")
        return cell
    }
}
