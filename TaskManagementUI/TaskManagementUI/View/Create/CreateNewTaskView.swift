//
// CreateNewTaskView.swift
// TaskManagementUI
//
// Created by Ahmed Ali
//

import SwiftUI

struct CreateNewTaskView: View {
    var onAdd: (Task) -> Void
    
    @Environment(\.dismiss) var dismiss
    @State var taskName = ""
    @State var taskDescription = ""
    @State var taskDate: Date = .init()
    @State var taskCategory: Category = .general
    
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .contentShape(Rectangle())
                    }
                    
                    Text("Create New Task")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                }
                
                VStack(alignment: .leading) {
                    titleView("Name")
                    
                    TextField("Task Title", text: $taskName)
                        .tint(.white)
                        .padding(.top, 2)
                    
                    Divider()
                        .background(.white)
                    
                    titleView("Date")
                        .padding(.top, 15)
                    
                    HStack(alignment: .bottom, spacing: 12) {
                        HStack(spacing: 12) {
                            Text(taskDate.toString(.dayMonthYear))
                            
                            Image(systemName: "calendar")
                                .foregroundColor(.white)
                                .overlay(
                                    DatePicker("", selection: $taskDate, displayedComponents: [.date])
                                        .blendMode(.destinationOver)
                                )
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 12) {
                            Text(taskDate.toString(.hourAndMinutes))
                            
                            Image(systemName: "clock")
                                .foregroundColor(.white)
                                .overlay(
                                    DatePicker("", selection: $taskDate, displayedComponents: [.hourAndMinute])
                                        .blendMode(.destinationOver)
                                )
                        }
                    }
                    
                    Divider()
                        .background(.white)
                }
            }
            .environment(\.colorScheme, .dark)
            .hAlign(.leading)
            .padding(15)
            .background(
                taskCategory.color.opacity(0.8).ignoresSafeArea()
            )
            
            VStack(alignment: .leading, spacing: 10) {
                titleView("Description", .gray)
                
                TextField("Task Description", text: $taskDescription)
                    .padding(.top, 2)
                
                Divider()
                
                titleView("Category", .gray)
                    .padding(.top, 15)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        Text(category.rawValue.uppercased())
                            .font(.callout)
                            .hAlign(.center)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(category.color.opacity(0.25))
                            )
                            .foregroundColor(category.color)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    taskCategory = category
                                }
                            }
                    }
                }
           
                Button {
                    let task = Task(
                        dateAdded: taskDate,
                        taskName: taskName,
                        taskDescription: taskDescription,
                        taskCategory: taskCategory
                    )
                    onAdd(task)
                    dismiss()
                } label: {
                    Text("Create Task")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .padding()
                        .background(
                            Capsule()
                                .fill(taskCategory.color)
                        )
                }
                .vAlign(.bottom)
                .disabled(taskName.isEmpty)
                .opacity(taskName.isEmpty ? 0.5 : 1.0)
            }
            .padding(15)
        }
        .vAlign(.top)
    }
}

struct CreateNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewTaskView { task in
            
        }
    }
}

private extension CreateNewTaskView {
    func titleView(_ value: String, _ color: Color = .white) -> some View {
        Text(value)
            .font(.callout)
            .foregroundColor(color)
    }
}
