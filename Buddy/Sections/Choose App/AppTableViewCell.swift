import UIKit

class AppTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel?
    
    var app: AppResponse? {
        didSet {
            configure(app: app)
        }
    }
    
    private func configure(app: AppResponse?) {
        nameLabel?.text = app?.name
    }
}
