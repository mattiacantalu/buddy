import UIKit

extension BuildDetailViewController {
    private struct Constants {
        static let build = "Build:"
        static let author = "Author:"
        static let status = "Status:"
        static let tag = "Tag:"
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
    @IBOutlet private weak var statusLabel: UILabel?
    @IBOutlet private weak var tagLabel: UILabel?
    @IBOutlet private weak var installButton: UIButton?

    private var build: BuildResponse? {
        didSet {
            reloadView(build)
        }
    }

    var buildId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        getBuild()
    }

    private func getBuild() {
        guard let buildId = buildId else {
            return
        }

        let config = Configuration(token: ClientConstant.token,
                                   baseUrl: ClientConstant.baseUrl)
        let buddy = BuddyService(configuration: config)
        buddy.getBuild(number: buildId) { result in
            switch result {
            case .success(let response):
                self.build = response
            case .failure(let error):
                print("error: \(error)")
            }
        }
    }

    private func reloadView(_ build: BuildResponse?) {
        navigationItem.title = build?.tag ?? Constants.unknown
        installButton?.isEnabled = build?.download != nil ? true : false

        versionLabel?.text = "\(Constants.build) \(build?.buildNumber ?? 0)"
        authorLabel?.text = "\(Constants.author) \(build?.commit.author ?? Constants.noName)"
        statusLabel?.text = "\(Constants.status) \(build?.status?.rawValue ?? Constants.unknown)"
        tagLabel?.text = "\(Constants.tag) \(build?.tag ?? Constants.unknown)"
        summaryLabel?.text = "\(Constants.summary) \(build?.commit.message ?? Constants.noMessage)"
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
