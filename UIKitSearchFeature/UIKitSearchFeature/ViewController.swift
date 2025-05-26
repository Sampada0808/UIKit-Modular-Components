import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var DictionaryStackView: UIStackView!
    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var DictionaryStackViewTopConstraints: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainWordLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    @IBOutlet weak var antonmysLabel: UILabel!
    @IBOutlet weak var synomynLabel: UILabel!
    @IBOutlet weak var phoneticsLabel: UILabel!
    @IBOutlet weak var defintionLabel: UILabel!
    var audioFile = ""
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupInitialUIView()
    }

    
    func setupInitialUIView() {
        // Step 1: Move the stack to center (override top constraint)
        let centerY = view.frame.height / 2 - 150
        DictionaryStackViewTopConstraints.constant = centerY
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.delegate = self
        // Step 2: Layout immediately
        view.layoutIfNeeded()
        scrollView.alpha = 0

        
    }
    func descriptionOf(word: String){
        sampleWordsData.forEach { WordInformation in
            if WordInformation.word == word {
                self.mainWordLabel.text = WordInformation.word
                self.defintionLabel.text = WordInformation.definitions
                self.phoneticsLabel.text = WordInformation.phonetic
                self.synomynLabel.text = WordInformation.synonyms.joined(separator: ",")
                self.antonmysLabel.text =  WordInformation.antonyms.joined(separator: ",")
                self.exampleLabel.text = WordInformation.example
                audioFile = WordInformation.audio
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.DictionaryStackViewTopConstraints.constant = 20 // Or your original value
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()

            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            UIView.animate(withDuration: 0.8, delay: 0, options: [.curveEaseOut]) {
                self.view.layoutIfNeeded()
                self.scrollView.alpha = 1

            }
        }
    }
    
    func playAudio(){
        guard let audioWord = URL(string: audioFile) else{
            return
        }
        let player = AVPlayer(url: audioWord)
        player.play()
        
        
    }
    
    @IBAction func pronounciationBtnTapped(_ sender: Any) {
        playAudio()
    }
    
}

extension ViewController : UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("User Started editing the text")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let wordSearch = searchBar.text, wordSearch.count > 2  else{
            let alert = UIAlertController(title: "Invalid", message: "Please enter some word", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        descriptionOf(word: wordSearch.lowercased())
        
    }
    
}
