//
// UIApplication.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
