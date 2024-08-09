//
//  ContentView.swift
//  finance_analisys
//
//  Created by Frederico del' Bidzho on 10.07.2024.
//

import SwiftUI
import CoreData
import UIKit
struct ContentView: View {
    @Environment(\.managedObjectContext) public var viewContext1
//    let context = PersistenceController.shared.container.viewContext
//    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
//    fetchRequest.sortDescriptors
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Purchase.timestamp, ascending: false)],animation: .default) private var purchases: FetchedResults<Purchase>
    //@FetchRequest(fetchRequest: Purchase.fetchRequest()) private var purchases
    @State private var isStatisticsShowed = false
    @State private var isSheetShowing = false

    var body: some View {
        
        ZStack {
            VStack {
                HStack {
                    Text("Журнал трат")
                        .font(.system(size: 20, weight: .regular, design: .default)
                                .italic()
                                .monospacedDigit())
                        
                        .fontWidth(.expanded)
                        

                }
                
                HStack(spacing: screen.width * 0.5){
                    Button {
                        isStatisticsShowed.toggle()
                    } label: {
                        Text("Статистика")
                            .padding(8)
                            .background(Color("Siren"))
                            .foregroundStyle(Color.white)
                            .cornerRadius(16)
                    }
                    Button {
                        isSheetShowing.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.white)
                            .frame(width: 30, height: 30)
                            .background(Color("Siren"))
                            .clipShape(Circle())
                            
                        
                    }


                }.frame(maxWidth: .infinity)
                
                List{
                    ForEach(purchases) { purchase in
                        ListObjectView(name: purchase.store!, price: Int(purchase.price))
                            .contextMenu{
                                Button {
                                    withAnimation {
                                        deleteWithButton(item: purchase)
                                    }
                                    
                                } label: {
                                    Text("delete")
                                }

                            }
                        
                    }.onDelete(perform: deleteItems)

                }.listStyle(.plain)
                    .frame(maxWidth: .infinity)
                    

                .sheet(isPresented: $isSheetShowing, content: {
                    CreatePurchaseView()
                })
            }.fullScreenCover(isPresented: $isStatisticsShowed, content: {
                DiagrammView()
            })

            
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
    private func hapticFeedback(){ //функция для вызова вибрации
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        print("brrrrrr")
    }
    private func deleteWithButton(item: Purchase) {
        
        viewContext1.delete(item)
        do {
            try viewContext1.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
            
        

            
    }
    private func deleteItems(offsets: IndexSet) { //удаление объекта из базы данных
        withAnimation {
            offsets.map { purchases[$0] }.forEach(viewContext1.delete)

            do {
                try viewContext1.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
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
