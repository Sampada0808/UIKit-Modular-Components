import UIKit

protocol BucketListTableCellDelegate : AnyObject {
    func moreDetailTapped(at indexPath : IndexPath)
}

class BucketListTableViewCell: UITableViewCell {
    
    let identifier = "BucketListTableViewCell"
    
    @IBOutlet weak var checkMarkImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreDetailsIconImage: UIImageView!
    
    weak var delegate : BucketListTableCellDelegate?
    var indexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMoreDetailsImage()
        applyTheme()
    }
    
    func applyTheme(){
        switch ThemeManager.shared.currentTheme{
        case .light:
            overrideUserInterfaceStyle = .light
            checkMarkImage.tintColor = .black
            moreDetailsIconImage.tintColor = .black
            
        case .dark:
            overrideUserInterfaceStyle = .dark
            checkMarkImage.tintColor = .white
            moreDetailsIconImage.tintColor = .white
        }
    }
    
    func setupMoreDetailsImage(){
        moreDetailsIconImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getMoreDetails))
        tapGesture.cancelsTouchesInView = true
        moreDetailsIconImage.addGestureRecognizer(tapGesture)
    }
    @objc func getMoreDetails(){
        if let indexPath = indexPath {
            delegate?.moreDetailTapped(at: indexPath)
        }
    }
    
    
    func config(with goal : Goals, indexPath : IndexPath){
        self.indexPath = indexPath
        checkMarkImage.image = goal.isCompleted == false ? UIImage(systemName: "circle") : UIImage(systemName: "checkmark.circle.fill")
        titleLabel.text = goal.title
    }
    
}
