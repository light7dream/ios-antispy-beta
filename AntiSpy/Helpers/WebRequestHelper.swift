//
//  RequestHelper.swift
//  AntiSpy
//
//  Created by Fi on 5/10/23.
//

import Foundation

func makeAsyncRequest(clickId: String, payout: Int, completion: @escaping (Result<Data, Error>) -> Void) {
    guard let url = URL(string: "https://www.trackcpa.life/postback?cid=\(clickId)&payout=\(payout)") else {
        let error = NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        completion(.failure(error))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        if let data = data {
            completion(.success(data))
        } else {
            let error = NSError(domain: "Empty response data", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    task.resume()
}

