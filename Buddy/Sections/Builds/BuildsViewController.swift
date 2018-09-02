import UIKit

private struct Constant {
    static let token = "yN9KTZm4s8m5R7X1YcvZxRH7wQ1xLjgp8ibCd11lf4Ne4DJnJdsWEqbYZDrP8vH7OFG8rzHfMDvAIbToGxsQGAxhWUs6C0Sd7A4WGmPCSYDHq1dIUE3kXjyesVNv"
    static let baseUrl = "https://api.buddybuild.com/v1"
    static let buildCellIdentifier = "BuildCellIdentifier"
    static let buildDetailSegue = "BuildDetailSegue"
    
    struct Section {
        static let build = 0
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
        let build = builds?[index.row]
        buildViewController.build = build
    }
    
    private func reloadNavigationBar() {
        navigationItem.title = app?.name
    }
    
    private func loadBuilds(app: AppResponse?) {
        guard let app = app else {
            return
        }
        let config = Configuration(token: Constant.token,
                                   urlString: Constant.baseUrl)
        let buddy = BuddyService(configuration: config)
        buddy.getBuilds(appId: app.id,
                        limitTo: 50) { result in
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

// MARK: Callbacks
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

// MARK: TableView methods
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
