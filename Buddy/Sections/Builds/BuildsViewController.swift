import UIKit

extension BuildsViewController {
    private struct Constant {
        static let buildCellIdentifier = "BuildCellIdentifier"
        static let buildDetailSegue = "BuildDetailSegue"

        struct Section {
            static let build = 0
        }
    }
}

final class BuildsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    
    private var cellForRowCallbacks: [((Int) -> Bool, (UITableView, IndexPath) -> UITableViewCell)] = []
    private var didSelectCellCallbacks: [((Int) -> Bool, (UITableView, IndexPath) -> Void)] = []
    private var numberOfRowsCallbacks: [((Int) -> Bool, () -> Int)] = []
    
    var app: AppResponse? {
        didSet {
            loadBuilds(app: app)
            reloadNavigationBar()
        }
    }
    var builds: [BuildResponse]? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCallbacks()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = (sender as? UITableViewCell).flatMap({ tableView?.indexPath(for: $0) }),
            let buildViewController = segue.destination as? BuildDetailViewController else {
                return
        }
        buildViewController.buildId = builds?[index.row].id
    }
    
    private func reloadNavigationBar() {
        navigationItem.title = app?.name
    }
    
    private func loadBuilds(app: AppResponse?) {
        guard let app = app else {
            return
        }

        Buddy.service.getBuilds(appId: app.id,
                                size: 50) { result in
            switch result {
            case .success(let response):
                self.builds = response
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    private func initializeCallbacks() {
        cellForRowCallbacks = [({ section in return section == Constant.Section.build }, buildBuildCell)]
        numberOfRowsCallbacks = [({ section in return section == Constant.Section.build }, numberOfBuilds)]
        didSelectCellCallbacks = [({ section in return section == Constant.Section.build }, didSelectBuild)]
    }
}

extension BuildsViewController {
    private func buildBuildCell(tableView: UITableView, indexPath: IndexPath) -> BuildTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.buildCellIdentifier) as? BuildTableViewCell
        cell?.build = builds?[indexPath.row]
        return cell ?? BuildTableViewCell()
    }
    
    private func numberOfBuilds() -> Int {
        return builds?.count ?? 0
    }
    
    private func didSelectBuild(tableView: UITableView, indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: Constant.buildDetailSegue, sender: cell)
    }
}

extension BuildsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsCallbacks.first(where: { $0.0(section) })?.1() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRowCallbacks.first(where: { $0.0(indexPath.section) })?.1(tableView, indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectCellCallbacks.first(where: { $0.0(indexPath.section) })?.1(tableView, indexPath)
    }
}
