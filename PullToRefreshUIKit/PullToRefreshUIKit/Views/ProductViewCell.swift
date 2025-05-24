

import UIKit

class ProductViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var starRatingImage: UIImageView!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var categoryView: UIView!
    
    let ratingImages = [
        "0.5Star",
        "1Star",
        "1.5Star",
        "2Star",
        "2.5Star",
        "3Star",
        "3.5Star",
        "4Star",
        "4.5Star",
        "5Star"
    ]
    
    var randomRating : Int {
        return Int.random(in: 1..<800)
    }
    
    var randomIndex : Int {
        return Int.random(in: 0..<ratingImages.count)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellStyle()
    }
    
    
    
    func setCellStyle(){
        categoryView.layer.cornerRadius = 10
        addToCartButton.layer.cornerRadius = 50
    
    }
    
    func configCellWith(image: String, title: String, category : String, price : Int){
        productTitle.text = title
        categoryLabel.text = category
        starRatingImage.image = UIImage(named: ratingImages[randomIndex])
        ratingValueLabel.text = "(\(randomRating))"
        priceLabel.text = "$\(price)"
        
        if let imageURL = URL(string: image) {
                URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    if let data = data, let downloadedImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.productImage.image = downloadedImage
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.productImage.image = UIImage(named: "mockupImage") // optional placeholder
                        }
                    }
                }.resume()
            } else {
                productImage.image = UIImage(named: "mockupImage") // optional fallback
            }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
