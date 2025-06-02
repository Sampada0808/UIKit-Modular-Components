import UIKit

class ViewController: UIViewController, SideMenuViewDelegate {
    
    let spinner = LoadingSpinner()
    let bounceButton = BounceButton()
    let imageView =  UIImageView(image: UIImage(systemName: "square.and.arrow.up"))
    
    let menuBtn: UIButton = {
            let btn = UIButton()
            let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
            let image = UIImage(systemName: "line.3.horizontal", withConfiguration: config)
            btn.setImage(image, for: .normal)
            btn.tintColor = .label
            return btn
        }()

        lazy var sideMenu: SideMenuView = {
            let menu = SideMenuView(menuTitles: ["Home", "Profile", "Settings", "Logout"])
            menu.delegate = self
            return menu
        }()

    func setupMenuButton() {
            menuBtn.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(menuBtn)
            menuBtn.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
            NSLayoutConstraint.activate([
                menuBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                menuBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                menuBtn.widthAnchor.constraint(equalToConstant: 44),
                menuBtn.heightAnchor.constraint(equalToConstant: 44)
            ])
        }

        @objc func didTapMenu() {
            sideMenu.show(in: view)
        }

        func didSelectMenuItem(_ title: String) {
            print("Selected: \(title)")
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Menu Button Setup
        setupMenuButton()
        
        // MARK: - ImageView with Fade In / Fade Out Animation
        // Uncomment these lines to test image fade in and out animation
        /*
        setupImage()
        imageView.alpha = 0
        imageView.fadeIn(duration: 5.0) {
            print("Image faded in")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.imageView.fadeOut(duration: 5.0) {
                print("Image faded out")
            }
        }
        */

        // MARK: - Bounce Button Setup
        // Uncomment this to test the bounce button
        // setupBounceButton()
        
        // MARK: - Spinner Setup
        // Uncomment this to test the loading spinner
        // setupSpinner()
    }


    
    
    func setupImage(){
        // Setup imageView appearance and position
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func setupBounceButton(){
        bounceButton.setTitle("Tap Me", for: .normal)
        view.addSubview(bounceButton)
        bounceButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bounceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bounceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bounceButton.widthAnchor.constraint(equalToConstant: 120),
            bounceButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupSpinner(){
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.lineWidth = 10
        spinner.rotationSpeed = 1
        spinner.trackColor = .lightGray
        spinner.spinnerColor = .purple
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 120),
            spinner.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    

    
    
}


