//
//  Untitled.swift
//  laundry-app
//
//  Created by Enzo Tonatto on 19/06/25.
//

import Foundation

final class CEPService {
    static func fetchAddress(by cep: String, completion: @escaping ([String:Any]?) -> Void) {
        let cleanCep = cep.replacingOccurrences(of: "-", with: "")
        guard let url = URL(string: "https://viacep.com.br/ws/\(cleanCep)/json/") else {
            completion(nil); return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(json) }
        }.resume()
    }
}

