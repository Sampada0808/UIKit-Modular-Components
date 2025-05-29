import UIKit

protocol AddGoalDelegate : AnyObject{
    func addGoal(_ goal : Goals)
}

protocol updateGoalsDelegate : AnyObject {
    func updateGoal(_ goalUpdated : Goals)
}

class AddModalViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var memoryImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    
    var goalToEdit : Goals?
    
    weak var addDelegate : AddGoalDelegate?
    weak var updateDelegate : updateGoalsDelegate?
    let placeholderForTitle = "Please Enter your goal"
    let placeholderForNote = "Please add some description related to you goal/acheivement"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        applyTheme()
        titleTextField.delegate = self
        noteTextView.delegate = self
        if let goal = goalToEdit {
            goalToUpdate(with: goal)
            saveButton.setTitle("Update", for: .normal)
        }
    }
    
    func applyTheme() {
        switch ThemeManager.shared.currentTheme {
        case .light:
            if goalToEdit != nil {
                titleTextField.textColor = .black
                noteTextView.textColor = .black
            }
            titleTextField.textColor = .lightGray
            noteTextView.textColor = .lightGray
            overrideUserInterfaceStyle = .light
            memoryImageView.tintColor = .white
            saveButton.backgroundColor = .white
            saveButton.tintColor = .black

        case .dark:
            if goalToEdit != nil {
                titleTextField.textColor = .white
                noteTextView.textColor = .white
            }
            overrideUserInterfaceStyle = .dark
            memoryImageView.tintColor = .black
            saveButton.backgroundColor = .white
            saveButton.tintColor = .black
            
        }
    }

    
    func setUpView(){
        titleTextField.text = placeholderForTitle
        noteTextView.text = placeholderForNote
        memoryImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        memoryImageView.addGestureRecognizer(tapGesture)
        memoryImageView.contentMode = .scaleAspectFit
    }
    
    @objc func imageTapped(){
        print("Tapped here ")
        showImagePickerOptions()
    
    }
    
    func goalToUpdate(with goal : Goals){
        titleTextField.text = goalToEdit?.title
        noteTextView.text = goalToEdit?.notes
        memoryImageView.image = goalToEdit?.image
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text , title != placeholderForTitle else{
            let alertVC = UIAlertController(title: "Invalid Input", message: "Please enter a goal", preferredStyle:.alert)
            let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(cancelBtn)
            self.present(alertVC, animated: true, completion: nil)
            return
        }
        let goalTitle = title.trimmingCharacters(in: .whitespacesAndNewlines).capitalized
        let image = memoryImageView.image != UIImage(systemName: "photo.badge.plus") ? memoryImageView.image :  UIImage(systemName: "photo.on.rectangle.angled") 
        let notes = noteTextView.text == placeholderForNote ? placeholderForNote : noteTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)

            if var goal = goalToEdit {
                // Update existing goal
                goal.title = goalTitle
                goal.notes = notes
                goal.image = image
                updateDelegate?.updateGoal(goal)
            } else {
                // Add new goal
                let goal = Goals(title: goalTitle, notes: notes, image: image, isCompleted: false, date: "Not Completed")
                addDelegate?.addGoal(goal)
            }

            dismiss(animated: true)
    }
}


//MARK: Image Picker
//To select photo from library or camera
extension AddModalViewController {
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    func showImagePickerOptions(){
        let alertVC = UIAlertController(title: "Pick a Photo", message: "Chooser a picture from libray or camera", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (action) in
            guard let self = self else{
                return
            }
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.present(cameraImagePicker, animated: true){
                
            }
        }
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] (action) in
            guard let self = self else{
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true){
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension AddModalViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == placeholderForTitle{
            textField.text = ""
            textField.textColor = .black
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true{
            titleTextField.textColor = .lightGray
            titleTextField.text = placeholderForTitle
        }
    }
}

extension AddModalViewController : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if noteTextView.text == placeholderForNote{
            noteTextView.text = ""
            noteTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if noteTextView.text?.isEmpty ?? true{
            noteTextView.textColor = .lightGray
            noteTextView.text = placeholderForNote
        }
    }
}


extension AddModalViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.memoryImageView.image =  image
        self.dismiss(animated: true, completion: nil)
    }
}
