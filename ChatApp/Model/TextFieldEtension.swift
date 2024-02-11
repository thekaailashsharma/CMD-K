//
//  TextFieldEtension.swift
//  ChatApp
//
//  Created by Admin on 11/02/24.
//

import SwiftUI

extension NSTextField {

    open override var focusRingType: NSFocusRingType {
        get {
            .none
        }
        set {}
    }
}
