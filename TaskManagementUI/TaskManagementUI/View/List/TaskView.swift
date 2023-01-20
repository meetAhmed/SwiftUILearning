//
// TaskView.swift
// TaskManagementUI
//
// Created by Ahmed Ali
//

import SwiftUI

struct TaskView: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.taskName)
                .font(.headline)
                .foregroundColor(task.taskCategory.color)
            
            if !task.taskDescription.isEmpty {
                Text(task.taskDescription)
                    .font(.subheadline)
                    .foregroundColor(task.taskCategory.color.opacity(0.8))
            }
        }
        .hAlign(.leading)
        .padding()
        .background(
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(task.taskCategory.color.opacity(0.5))
                    .frame(width: 4)
                
                Rectangle()
                    .fill(task.taskCategory.color.opacity(0.15))
            }
        )
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(task: TaskDataService.tasks.first!)
    }
}
