import UIKit

class ViewController: UIViewController, AddGoalDelegate, BucketListTableCellDelegate, updatedTheMainGoals {
    
    
    @IBOutlet weak var appThemeButton: UIButton!
    @IBOutlet weak var bucketListLabel: UILabel!
    @IBOutlet weak var bucketListTableView: UITableView!
    @IBOutlet weak var doneGoalsSegementedControl: UISegmentedControl!
    
    
    var chosenTheme : AppTheme = .light
    
    let cellID = "BucketListTableViewCell"
    let sectionNames = ["Not Complete","Completed"]
    var goals :[Goals] = []
    var chosenSegment = 0
    
    var filterdData : [Goals]{
        return chosenSegment == 0 ? goals.filter {$0.isCompleted == false} : goals.filter {$0.isCompleted == true}
    }
    
    func addGoal(_ goal: Goals) {
        goals.append(goal)
        bucketListTableView.reloadData()
    }
    
    let addButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowOpacity = 0.5
        return button
    }()
    
    @objc func addButtonTapped(){
        performSegue(withIdentifier: "AddModalSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setUpAddButton()
    }
    
    func moreDetailTapped(at indexPath: IndexPath) {
        let selectedGoal = filterdData[indexPath.row]
        let editVc = goalDetailsViewController(nibName: "goalDetailsViewController", bundle: nil)
        editVc.goalToDisplay = selectedGoal
        editVc.updateMaindelegate = self
        let navController = UINavigationController(rootViewController: editVc)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddModalSegue" {
            if let addModalVC = segue.destination as? AddModalViewController {
                addModalVC.addDelegate = self
            }
        }
    }
    
    func setupTableView(){
        let cell = UINib(nibName: cellID, bundle: nil)
        bucketListTableView.register(cell, forCellReuseIdentifier: cellID)
        bucketListTableView.dataSource = self
        bucketListTableView.delegate = self
        bucketListTableView.allowsSelection = true
        bucketListTableView.dragDelegate = self
        bucketListTableView.dragInteractionEnabled = true
        bucketListTableView.isUserInteractionEnabled = true
    }
    
    func setUpAddButton(){
        let xPos = view.frame.width / 2 - 20
        let yPos =  view.frame.height - 100
        addButton.frame = CGRect(x: xPos, y: yPos, width: 50, height: 50)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        addButton.layer.cornerRadius = addButton.frame.width / 2
        view.addSubview(addButton)
    }
    
    @IBAction func segmentalControlValueChanged(_ sender: UISegmentedControl) {
        chosenSegment = sender.selectedSegmentIndex
        bucketListTableView.reloadData()
        
    }
    func updateGoal(_ goalUpdated: Goals) {
        for (index, goal) in goals.enumerated() {
               if goal.id == goalUpdated.id {
                   goals[index] = goalUpdated
                   break
               }
           }
        bucketListTableView.reloadData()
    }
    
    @IBAction func changeThemeTapped(_ sender: Any) {
        switch ThemeManager.shared.currentTheme {
            case .light:
                ThemeManager.shared.currentTheme = .dark
                overrideUserInterfaceStyle = .light
                appThemeButton.setImage(UIImage(systemName: "moon.fill"), for: .normal)
                appThemeButton.tintColor = .black
                addButton.tintColor = .white
                addButton.backgroundColor = .black
            case .dark:
                ThemeManager.shared.currentTheme = .light
                overrideUserInterfaceStyle = .dark
                appThemeButton.setImage(UIImage(systemName: "sun.max.fill"), for: .normal)
                appThemeButton.tintColor = .white
                addButton.tintColor = .black
                addButton.backgroundColor = .white
            }
            
            // Reload views
            bucketListTableView.reloadData()
    }
    

}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! BucketListTableViewCell
        let data = filterdData[indexPath.row]
        cell.selectionStyle = .none
        cell.delegate = self
        cell.config(with: data, indexPath: indexPath)
        return cell
    }
    
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = filterdData[indexPath.row]
        if let index = goals.firstIndex(where: {  $0.id == selectedIndex.id
        }){
            goals[index].isCompleted.toggle()
            bucketListTableView.reloadData()
            if goals[index].isCompleted{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM d, yyyy"

                let date = Date()
                let formattedDate = dateFormatter.string(from: date)
                goals[index].date = formattedDate
            }else{
                goals[index].date = "Not Completed"
            }
        }
    }
}

extension ViewController : UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = goals[indexPath.row]
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let mover = goals.remove(at: sourceIndexPath.row)
        goals.insert(mover, at: destinationIndexPath.row)
        
    }
    
}
