//
//  RequestClient.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-19.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

typealias CompletionHandler<ResultType: Decodable> = (_ error: Error?, _ result: ResultType?) -> Void

struct RequestClient<A: Decodable> {
    
    func fetch(request: URLRequest, completionHandler: @escaping CompletionHandler<A>) {
        URLSession.shared.dataTask(with: request) { (data: Data?, response, error: Error?) in
            guard let httpStatusCode = (response as? HTTPURLResponse)?.statusCode else {
                completionHandler(GenericError.Unknown, nil)
                return
            }
            
            if let err = error {
                completionHandler(GenericError.Known(message: err.localizedDescription), nil)
            }
            
            let decoder = JSONDecoder()
            
            if httpStatusCode >= 200 && httpStatusCode < 300 {
                do {
                    let result = try decoder.decode(A.self, from: data!)
                    completionHandler(nil, result)
                } catch {
                    completionHandler(GenericError.Known(message: error.localizedDescription), nil)
                }
            } else {
               completionHandler(GenericError.Unknown, nil)
            }
        }.resume()
    }
    
}
