//
//  ContentView.swift
//  finance_analisys
//
//  Created by Frederico del' Bidzho on 10.07.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //@Environment(\.managedObjectContext) private var viewContext
//    let context = PersistenceController.shared.container.viewContext
//    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
//    fetchRequest.sortDescriptors
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],animation: .default)
    //@FetchRequest(fetchRequest: Item.fetchRequest())
    private var items: FetchedResults<Item>
    @State var flag = false
    var body: some View {
        VStack {
            Text("push dat button")
            
            Button {
                let newItem = Item(context: viewContext)
                newItem.timestamp = Date()
//                if let item = items.first {
//                    viewContext.delete(item)
//                    do{
//                        try viewContext.save()
//
//                    } catch {
//                        let nsError = error as NSError
//                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                    }
//                }
            } label: {
                Text("push me bitch ass ling ling")
                    .padding(5)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(23)
                
            }
            
            Button {
                flag.toggle()
            } label: {
                Text("push me bitch ass ling ling")
                    .padding(5)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(23)
            }

            
            List {
                ForEach(items) {item in
                    Text(String(describing: itemFormatter.string(from: item.timestamp!)))
                }


            }

        }
        

    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView()
}
