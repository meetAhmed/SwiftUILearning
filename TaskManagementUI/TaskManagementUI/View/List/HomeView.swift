//
//  HomeView.swift
//  TaskManagementUI
//
//  Created by Ahmed Ali on 20/01/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var tasks: [Task] = TaskDataService.tasks
    @State private var currentDate: Date = .init()
    @State private var addNewTask = false
    @Environment(\.colorScheme) var colorScheme
    let darkBlueColor: Color = Color("DarkBlueColor")
    
    var body: some View {
        ScrollView {
            VStack {
                timelineRow
            }
        }
        .safeAreaInset(edge: .top) {
            header
        }
        .fullScreenCover(isPresented: $addNewTask) {
            CreateNewTaskView { task in
                tasks.append(task)
                print("New task added: \(tasks.count)")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

private extension HomeView {
    var header: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Today")
                        .font(.headline)
                    
                    Text("Welcome, Username")
                        .font(.subheadline)
                }
                .hAlign(.leading)
                
                Button {
                    addNewTask.toggle()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        Text("Add Task")
                    }
                    .font(.callout)
                    .padding(15)
                    .background(
                        Capsule()
                            .fill(.blue)
                    )
                    .foregroundColor(.white)
                    .shadow(radius: 5)
                }
            }
            
            Text(Date().toString(.monthYearOnly))
                .font(.headline)
                .hAlign(.leading)
                .padding(.top, 15)
            
            weekRow
                .padding(.vertical, 10)
                .padding(.horizontal, -15)
        }
        .padding()
        .background(
            ZStack {
                colorScheme == .dark ? darkBlueColor : Color.white
            }
            .cornerRadius(10)
            .ignoresSafeArea()
        )
    }
    
    var weekRow: some View {
        HStack(spacing: 0) {
            ForEach(Calendar.current.currentWeek) { day in
                let status = Calendar.current.isDate(day.date, inSameDayAs: currentDate)
                VStack(spacing: 6) {
                    Text(day.string.prefix(3))
                        .font(.headline)
                    
                    Text(day.date.toString(.dayAsNumOnly))
                        .font(status ? .headline : .subheadline)
                }
                .foregroundColor(status ? .blue : .gray)
                .hAlign(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentDate = day.date
                    }
                }
            }
        }
    }
    
    var timelineRow: some View {
        ScrollViewReader { proxy in
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
            VStack {
                ForEach(hours, id: \.self) { hour in
                    timelineHourRow(hour)
                        .id(hour)
                }
            }
            .padding()
            .onAppear {
                proxy.scrollTo(midHour)
            }
        }
    }
    
    func timelineHourRow(_ hour: Date) -> some View {
        HStack(alignment: .top) {
            Text(hour.toString(.hourWithAmOrPm))
                .font(.subheadline)
                .frame(width: 50, alignment: .leading)
            
            let filteredTasks = tasks.filterTasksFor(date: currentDate, time: hour, tasks: tasks)
            
            if filteredTasks.isEmpty {
                Rectangle()
                    .stroke(
                        .gray.opacity(1),
                        style: StrokeStyle(
                            lineWidth: 0.5,
                            lineCap: .butt,
                            lineJoin: .bevel,
                            dash: [5],
                            dashPhase: 5
                        )
                    )
                    .frame(height: 0.5)
                    .offset(y: 10)
            } else {
                VStack {
                    ForEach(filteredTasks) { task in
                        TaskView(task: task)
                    }
                }
            }
        }
        .hAlign(.leading)
        .padding(.vertical, 15)
    }
}
