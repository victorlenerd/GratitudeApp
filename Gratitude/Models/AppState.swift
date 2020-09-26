//
//  AppState.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-23.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class AppState: ObservableObject {
    @Published var isLoading: Bool?
    @Published var isOnline: Bool?
    @Published var isLoggedIn: Bool?
    
    init(isLoading: Bool, isOnline: Bool, isLoggedIn: Bool) {
        self.isLoading = isLoading
        self.isOnline = isOnline
        self.isLoggedIn = isLoggedIn
    }
}
