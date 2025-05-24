import Foundation


enum ProductAPIError : Error {
    case dataReturnError
    case dataPreprocessingError
}


struct ProductApiService {
    var resourceURL : URL
    
    init(){
        let destinationUrl = "https://fakestoreapi.in/api/products"
        
        guard let resourceURL = URL(string: destinationUrl) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getProduct(completetion : @escaping(Result<[ProductsInfo], ProductAPIError>) -> Void) {
        let listings = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completetion(.failure(.dataReturnError))
                return
            }
            do {
                let decoder = JSONDecoder()
                let productAPIresponse = try decoder.decode(ProductAPIResponse.self, from: jsonData)
                completetion(.success(productAPIresponse.products))
            } catch {
                print("Decoding error: \(error)")
                completetion(.failure(.dataPreprocessingError))
            }
        }
        listings.resume()
    }

    
}
