//
//  Localization.swift
//  ThreeT
//
//  Created by Martin Albrecht on 29.04.20.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//

import Foundation

extension String {
    func localizedFormat(comment: String = "") -> String {
        NSLocalizedString(self, comment: comment)
    }
}
