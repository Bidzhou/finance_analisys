//
//  CreatePurchaseView.swift
//  finance_analisys
//
//  Created by Frederico del' Bidzho on 12.07.2024.
//

import SwiftUI
import CoreData

struct CreatePurchaseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dissmis
    @State private var name: String = ""
    @State private var price: Int64? = nil
    @State private var isUsePattern = false
    @State private var isSelectDate = false
    @State private var date = Date()
    private let purchaseTypes = ["Еда", "Транспорт", "Курение", "Алкоголь"]
    var body: some View {
        VStack {
            
            Image(systemName: "cart.circle.fill")
                .resizable()
                .frame(width: screen.width * 0.25, height: screen.height*0.12)
                .foregroundStyle(Color("Siren"))
            
            Button {
                withAnimation {
                    isUsePattern.toggle()
                }
                if isUsePattern{
                    name = purchaseTypes[0]
                } else {
                    name = ""
                }
                
            } label: {
                if isUsePattern{
                    Text("Не использовать шаблон")
                        .foregroundStyle(Color.white)

                } else {
                    Text("Использовать шаблон")
                        .foregroundStyle(Color.white)

                }
                
            }.padding(8)
                .background(Gradient(colors: [Color("Siren"), Color("Siren_60"), Color("Siren")]))
                .cornerRadius(8)
                .padding()
                

            if isUsePattern {
                Picker("jaj", selection: $name) {
                    ForEach(purchaseTypes, id: \.self) { purchase in
                        Text(purchase)
                    }
                }.pickerStyle(.wheel)
            } else {
                TextField("Введите тип покупки", text: $name)
                    .padding(10)
                    .background(Color("Siren_60"))
                    .cornerRadius(16)
                    .padding()
                
            }

            TextField("Цена", value: $price, format: .number)
                .keyboardType(.numberPad)
                .padding(10)
                .background(Color("Siren_60"))
                .cornerRadius(16)
                .padding()
            
            if isSelectDate{
                DatePicker("",
                           selection: $date,
                           displayedComponents: [.date])
                    .datePickerStyle(.wheel)
                    .frame(alignment: .center)
                    .padding(.trailing, 20)
            }
            
            

            Button {
                if isSelectDate {
                    date = Date()
                }
                withAnimation {
                    isSelectDate.toggle()
                }
                
                
            } label: {
                //надо нормально менять переменну даты
                if isSelectDate {
                    Text("Сегодня")
                } else {
                    Text("Выбрать дату")
                }
                
            }



            
            Button {
                if !name.isEmpty && price != nil {
                    let newPurchase = Purchase(context: viewContext)
                    newPurchase.price = self.price!
                    newPurchase.store = self.name
                    newPurchase.timestamp = date
                    do{
                        try viewContext.save()

                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                    
                    dissmis()
                }
            } label: {
                Text("Create")
                    .foregroundStyle(.white)
                    .padding(10)
                    .padding(.horizontal, 20)
                    .background(Color("Siren"))
                    .cornerRadius(16)
            }
            
        }
        

        
        

            
    }
}

#Preview {
    CreatePurchaseView()
}
