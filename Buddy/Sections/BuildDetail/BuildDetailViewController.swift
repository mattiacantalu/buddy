import UIKit

extension BuildDetailViewController {
    private struct Constants {
        static let build = "Build:"
        static let author = "Author:"
        static let summary = "Summary:"
        static let unknown = "unkwnown"
        static let noName = "no name"
        static let noMessage = "no message"
    }
}

final class BuildDetailViewController: UIViewController {
    @IBOutlet private weak var versionLabel: UILabel?
    @IBOutlet private weak var authorLabel: UILabel?
    @IBOutlet private weak var summaryLabel: UILabel?
    
    var build: BuildResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadNavigationBar()
        
        versionLabel?.text = "\(Constants.build) \(build?.tag ?? Constants.unknown)"
        authorLabel?.text = "\(Constants.author) \(build?.commit.author ?? Constants.noName)"
        summaryLabel?.text = "\(Constants.summary) \(build?.commit.message ?? Constants.noMessage)"
    }

    private func reloadNavigationBar() {
        navigationItem.title = build?.tag ?? Constants.unknown
    }
}

extension BuildDetailViewController {
    @IBAction func onInstall(_ sender: Any) {
        guard let urlString = build?.download,
            let url = URL(string: urlString),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: nil)
    }
}
