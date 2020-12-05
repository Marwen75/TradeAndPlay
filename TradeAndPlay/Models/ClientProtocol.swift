//
//  SessionProtocol.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 05/12/2020.
//

import Foundation

protocol ClientProtocol {
    
    func request(withName name: String, endpoint: String, query: String, dataResponse: @escaping (Data) -> (Void), errorResponse: @escaping (Error) -> (Void))
}
