import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    var productList = [ProductsInfo]()
    
    let cellId = "ProductViewCell"
    let UimageView = UIImageView()
    let emptyImage : UIImage = {
        let image = UIImage(named: "EmptyIcon")!
        return image
    }()
    
    let text : UILabel = {
        let message = UILabel()
        message.text = "There is no product, please refresh"
        message.font = UIFont(name: "Arial", size: 24)
        message.textAlignment = .center
        message.numberOfLines = 0
        return message
    }()
    
    var showTable = false
    
    @IBOutlet weak var productTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButton.isHidden = true
        productLabel.isHidden = true
        let xPos = view.frame.width / 2 - 100
        let yPos = view.frame.height / 2
        text.frame = CGRect(x: xPos, y: yPos, width:  view.frame.width - 80, height: 50)
        UimageView.frame = CGRectMake(xPos + 10 , yPos - 220, 200, 200)
        text.sizeToFit()
        tableSetup()
        UimageView.image = emptyImage
        view.addSubview(text)
        view.addSubview(UimageView)
    }
    
    func getProductListings() {
        let productService = ProductApiService()
        productService.getProduct { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .success(let product):
                    self.productList = product
                    self.showTable = true
                    self.refreshButton.isHidden = false
                    self.productLabel.isHidden = false

                    [self.text, self.UimageView].forEach { view in
                        UIView.animate(withDuration: 0.5) {
                            view.alpha = 0
                        }
                    }

                    self.productTable.reloadData()
                case .failure(let error):
                    print("Error loading products:", error)
                }

                // Always stop refreshing animation
                self.productTable.refreshControl?.endRefreshing()
            }
        }
    }

    
    func tableSetup(){
        let customProductCell = UINib(nibName: cellId, bundle: nil)
        productTable.register(customProductCell, forCellReuseIdentifier: cellId)
        productTable.dataSource = self
        productTable.delegate = self
        productTable.refreshControl = UIRefreshControl()
        productTable.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
    }
    
    @objc func handleRefreshControl() {
        getProductListings()
    }
    
    @IBAction func refreshBtnTapped(_ sender: Any) {
        self.productTable.refreshControl?.beginRefreshing()
        handleRefreshControl()
    }
    


}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showTable {
            return productList.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ProductViewCell
        cell.selectionStyle = .none
        cell.configCellWith(image: product.image, title: product.title, category: product.category, price: product.price)
        return cell
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

