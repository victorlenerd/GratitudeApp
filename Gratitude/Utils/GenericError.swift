//
//  GenericError.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-14.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//
import Foundation

enum GenericError: Error {
    case Unknown
    case Known(message: String)
}

extension GenericError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .Unknown:
            return NSLocalizedString("Something went wrong!", comment: "An Error Occured")
        case .Known(message: let message):
            return NSLocalizedString(message, comment: "An Error Occured")
        }
    }
}
