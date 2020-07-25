//
//  Swift+Extension.swift
//  MVVM_Exercise
//
//  Created by akash on 24/07/20.
//  Copyright © 2020 akash. All rights reserved.
//

import Foundation

extension String {
    
    func checkAndAppend(prefix: String) -> String {
        if !self.hasPrefix(prefix) {
            return "\(prefix)\(self)"
        }
        return self
    }
}
