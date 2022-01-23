//
//  Network.swift
//  Market
//
//  Created by Beytullah Özer on 24.12.2021.
//

import Foundation
import Firebase


struct Network {
    
    private let baseUrl = "http://159.223.0.153/"
    
    static let cartId: Int = 2
    
    func request<T: Decodable>(type: RequestType, completion: @escaping (Result<T, CustomError>) -> Void) {
        
        guard let url = URL(string: baseUrl + type.endPoint) else {
            Logger.log(text: "Url oluşturulamadı.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.httpMethod.rawValue
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(.failure(CustomError(message: "Data yok")))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
            }
            catch let error {
                completion(.failure(CustomError(message: error.localizedDescription)))
            }
        }
        .resume()
        
        
    }
}
