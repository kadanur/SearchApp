//
//  File.swift
//  SearchApp
//
//  Created by M Kaan Adanur on 29.04.2022.
//

import Foundation

struct AccountRaw: Codable {
    let results: [Account]
}

struct Account: Codable {
    let name: String
    let date: String
    let iban: String
    let price: String
}
