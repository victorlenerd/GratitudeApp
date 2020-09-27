//
//  TimeAgo.swift
//  Gratitude
//
//  Created by Nwaokocha Victor on 2020-09-27.
//  Copyright © 2020 Nwaokocha Victor. All rights reserved.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
