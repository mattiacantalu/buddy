import UIKit

class BuildTableViewCell: UITableViewCell {
    @IBOutlet weak var buildNumberLabel: UILabel?
    @IBOutlet weak var appNameLabel: UILabel?
    
    var build: BuildResponse? {
        didSet {
            configureBuild(build)
        }
    }
    
    private func configureBuild(_ build: BuildResponse?) {
        appNameLabel?.text = build?.name
        buildNumberLabel?.text = build.flatMap({ "(\($0.buildNumber))" })
    }
}
