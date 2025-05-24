import Foundation


struct ProductAPIResponse: Decodable {
    let products: [ProductsInfo]
}

struct ProductsInfo: Decodable {
    let title: String
    let image: String
    let price: Int
    let category: String

    enum CodingKeys: String, CodingKey {
        case title, image, price, category
    }
}

