import UIKit

extension BuildTableViewCell {
    struct Constants {
        static let unknown = "unknown"
    }
}

class BuildTableViewCell: UITableViewCell {

    var build: BuildResponse? {
        didSet {
            configureBuild(build)
        }
    }
    
    private func configureBuild(_ build: BuildResponse?) {
        let name = build?.name ?? ""
        let buildNumber = build.flatMap({ "(\($0.buildNumber))" }) ?? ""
        textLabel?.text = "\(name) \(buildNumber)"
        detailTextLabel?.text = build?.status?.rawValue ?? Constants.unknown
    }
}
