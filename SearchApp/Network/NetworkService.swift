//
//  NetworkService.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 29.04.2022.
//

import Foundation

struct NetworkService {
    public static func fetchData(url: URL, completion: @escaping ([Account]?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error1")
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(AccountRaw.self, from: data)
                    completion(result.results)
                } catch {
                    print("error2")
                    print(error.localizedDescription)
                    print(String(describing: error))
                    completion(nil)
                }
            }
        }.resume()
    }

}
