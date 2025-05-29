import UIKit

protocol updatedTheMainGoals : AnyObject{
    func updateGoal(_ goalUpdated: Goals)
}

class goalDetailsViewController: UIViewController, updateGoalsDelegate {
    
    
    @IBOutlet weak var memoryImageView: UIImageView!
    @IBOutlet weak var goalTitle: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var goalToDisplay : Goals?
    weak var updateMaindelegate : updatedTheMainGoals?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissSelf)
        )
        configData(with: goalToDisplay!)
        applyTheme()
    }
    
    func updateGoal(_ goalUpdated: Goals) {
        goalToDisplay = goalUpdated
        configData(with: goalToDisplay!)
    }
    
    func applyTheme(){
        switch ThemeManager.shared.currentTheme{
        case .light:
            overrideUserInterfaceStyle = .light
            memoryImageView.tintColor = .black
            navigationItem.leftBarButtonItem?.tintColor = .black
        case .dark:
            overrideUserInterfaceStyle = .dark
            memoryImageView.tintColor = .white
            navigationItem.leftBarButtonItem?.tintColor = .white
        }
    }
    
    @IBAction func editBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let modalVc = storyboard.instantiateViewController(withIdentifier: "AddModal") as? AddModalViewController {
            modalVc.goalToEdit = goalToDisplay
            modalVc.updateDelegate = self
            let navVc = UINavigationController(rootViewController: modalVc)
            navVc.modalPresentationStyle = .formSheet // or .fullScreen
            present(navVc, animated: true, completion: nil)
        }
    }
    

    @objc func dismissSelf() {
        updateMaindelegate?.updateGoal(goalToDisplay!)
        dismiss(animated: true, completion: nil)
    }
    
    func configData(with goal : Goals){
        memoryImageView.image = goal.image
        goalTitle.text = goal.title
        noteLabel.text = goal.notes
        dateLabel.text = goal.date
    }
    

}
