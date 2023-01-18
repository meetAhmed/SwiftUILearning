//
// SimpleLogger.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import Foundation

class SimpleLogger {
    static func log(_ text: String?...) {
        var toPrint = ""
        for str in text {
            toPrint += (str ?? "Nil") + " "
        }
        print("SimpleLogger", toPrint)
    }
    
    static func printDivider() {
        print("SimpleLogger", "----------------------------------------------")
    }
}
