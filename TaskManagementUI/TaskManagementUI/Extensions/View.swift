//
//  View.swift
//  TaskManagementUI
//
//  Created by Ahmed Ali on 20/01/2023.
//

import SwiftUI

extension View {
    func hAlign(_ aligment: Alignment) -> some View {
        frame(maxWidth: .infinity, alignment: aligment)
    }
    
    func vAlign(_ aligment: Alignment) -> some View {
        frame(maxHeight: .infinity, alignment: aligment)
    }
}
