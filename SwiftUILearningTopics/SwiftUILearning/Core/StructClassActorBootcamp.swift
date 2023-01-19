//
// StructClassActorBootcamp.swift
// SwiftUILearning
//
// Created by Ahmed Ali
//

import SwiftUI

/**
 
 Values Type:
 - Struct, String, Enum, Int, etc.
 - Stored in the stack
 - Faster
 - Thread safe
 - New copy of data is created when passed or assgined
 
 Reference Types:
 - Class, Actor, Function.
 - Stored in the Heap.
 - Slower but sync.
 - Not thread safe
 - When passed or assigned, new reference or pointer is created.
 
 Stack:
 - Stores value types.
 - Variables allocated on stack are stored directly to memory, and memory is very fast.
 - Each thread has its own stack.
 
 Heap:
 - Stores reference types.
 - Shared across threads.
 
 Struct:
 - Based on values.
 - Can be mutated.
 - Stored in stack.
 
 Class:
 - Based on references or instances.
 - Stored in the heap.
 - Inheritance.
 
 Actor:
 - Same as class but thread safe.
 
 Structs are used for data models, views.
 Classes: ViewModels.
 Actors: Shared 'Managers' or 'DataStore'.
 
 */
struct StructClassActorBootcamp: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            startTest()
        }
    }
}

struct StructClassActorBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        StructClassActorBootcamp()
    }
}

extension StructClassActorBootcamp {
    func startTest() {
        SimpleLogger.log("Struct Test started!")
        SimpleLogger.printDivider()
        structTest1()
        
        SimpleLogger.printDivider()
        SimpleLogger.log("Class Test started!")
        SimpleLogger.printDivider()
        classTest1()
        
        SimpleLogger.printDivider()
        SimpleLogger.log("Actor Test started!")
        SimpleLogger.printDivider()
        actorTest1()
    }
    
    func structTest1() {
        let obj1 = MyStruct(title: "Obj1 Title")
        var obj2 = obj1
        
        SimpleLogger.log("Struct Object 1", obj1.title)
        SimpleLogger.log("Struct Object 2", obj2.title)
        
        obj2.title = "Obj2 title"
        
        SimpleLogger.printDivider()
        SimpleLogger.log("Struct Object 1", obj1.title)
        SimpleLogger.log("Struct Object 2", obj2.title)
    }
    
    func classTest1() {
        let obj1 = MyClass(title: "Obj1 Title")
        let obj2 = obj1
        
        SimpleLogger.log("Class Object 1", obj1.title)
        SimpleLogger.log("Class Object 2", obj2.title)
        
        obj2.title = "Obj2 title"
        
        SimpleLogger.printDivider()
        SimpleLogger.log("Class Object 1", obj1.title)
        SimpleLogger.log("Class Object 2", obj2.title)
    }
    
    func actorTest1() {
        Task {
            let obj1 = MyActor(title: "Obj1 Title")
            let obj2 = obj1
            
            await SimpleLogger.log("Class Object 1", obj1.title)
            await SimpleLogger.log("Class Object 2", obj2.title)
            
            await obj2.updateTitle(newTitle: "Obj2 title")
            
            SimpleLogger.printDivider()
            await SimpleLogger.log("Class Object 1", obj1.title)
            await SimpleLogger.log("Class Object 2", obj2.title)
        }
    }
}

struct MyStruct {
    var title: String
}

class MyClass {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

actor MyActor {
    var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func updateTitle(newTitle: String) {
        title = newTitle
    }
}
