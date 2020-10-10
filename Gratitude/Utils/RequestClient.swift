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
            
            print("[REQUEST-LOG]: URL: \(request.url?.absoluteURL) Status: \(httpStatusCode). Response: \(String(data: data!, encoding: .utf8)))" )
            
            if httpStatusCode >= 200 && httpStatusCode < 300 {
                do {
                    if data?.count ?? 0 > 1 {
                        let result = try decoder.decode(A.self, from: data!)
                        completionHandler(nil, result)
                    } else {
                        completionHandler(nil, nil)
                    }
                } catch {
                    completionHandler(GenericError.Known(message: error.localizedDescription), nil)
                }
            } else if httpStatusCode == 404 {
                completionHandler(GenericError.Known(message: "Resource Not Found"), nil)
            } else {
               completionHandler(GenericError.Unknown, nil)
            }
        }.resume()
    }
    
}
