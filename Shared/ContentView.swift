//
//  ContentView.swift
//  Shared
//
//  Created by Steve Yu on 2020/11/14.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)])
    var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    Text(task.title ?? "Untitled")
                        .onTapGesture {
                            updateTask(task)
                        }
                }
                .onDelete(perform: deleteTasks)
            }
            .navigationTitle("Todo List 📝")
            .navigationBarItems(trailing: Button("Add Task", action: {
                addTask()
            }))
        }
    }
    
    private func updateTask(_ task: Task) {
        withAnimation {
            task.title = "updated"
            saveContext()
        }
    }
    
    private func deleteTasks(offsets: IndexSet) {
        withAnimation {
            offsets.forEach{viewContext.delete(tasks[$0])}
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    private func addTask() {
        withAnimation {
            let newTask = Task(context: viewContext)
            newTask.title = "New Task \(Date())"
            newTask.date = Date()
            saveContext()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
