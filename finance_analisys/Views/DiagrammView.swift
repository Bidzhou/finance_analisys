//
//  DiagrammView.swift
//  finance_analisys
//
//  Created by Frederico del' Bidzho on 15.07.2024.
//

import SwiftUI
import Charts

struct DiagrammView: View {
    @State private var isReverseSort = false
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Purchase.timestamp, ascending: true)]) private var purchases: FetchedResults<Purchase>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Purchase.timestamp, ascending: false)]) private var purchasesReversed: FetchedResults<Purchase>
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Purchase.store, ascending: false)]) private var purchasesByCategories: FetchedResults<Purchase>

    @Environment(\.dismiss) var dissmis
    @State private var selectedAngle: Int?
    

    var body: some View {
    
        HStack(spacing: screen.width*0.58) {
            Button {
                dissmis()
            } label: {
                Image(systemName: "arrow.backward")
                    .foregroundStyle(Color.white)
                    .frame(width: 30, height: 30)
                    .background(Color("Siren"))
                    .clipShape(Circle())
            }
            Button {
                withAnimation {
                    isReverseSort.toggle()
                }
                
            } label: {
                Text("reverse")
                    .padding(8)
                    .background(Color("Siren"))
                    .foregroundStyle(Color.white)
                    .cornerRadius(16)
                
            }

        }


        Chart(purchasesByCategories, id: \.price) { purchase in
            
            SectorMark(
                angle: .value("price", Int(purchase.price)),
                innerRadius: .ratio(0.6),
                angularInset: 0.2
                
                )
            .cornerRadius(5)
            //.opacity(purchase.store == selectedItem?.store ? 1 : 0.3 )
            .foregroundStyle(by: .value("store", purchase.store!))
            
        }.chartLegend(alignment: .center, spacing: 16)
        
        .chartBackground { chartProxy in
            GeometryReader{ geometry in
                
                let frame = geometry[chartProxy.plotFrame!]
                VStack{
                    let sumSales = purchases.reduce(into: [String: Int]()) { partialResult, purchase in
                        partialResult[purchase.store, default: 0] += Int(purchase.price)
                    }
                    //let storeName = sumSales.max(by: {$0.value < $1.value})
                    var total = 0
                    let categoryRanges = purchases.map {
                        let newTotal = total + Int($0.price)
                        let result = (category: $0.store,
                                      range: Int(total) ..< Int(newTotal))
                        total = newTotal
                        return result
                      }
                    
                    var selectedItem: Purchase? {
                      guard let selectedAngle else { return nil }
                      if let selected = categoryRanges.firstIndex(where: {
                        $0.range.contains(selectedAngle)
                      }) {

                        return purchases[selected]
                      }
                      return nil
                    }

                    Text(selectedItem?.store ?? "Over all")
                      .font(.title)
                    Text("\(sumSales[selectedItem?.store] ?? total)" + " Rub")
                      
                    
                }
                .position(x: frame.midX, y: frame.midY)
            }
        }
        .chartAngleSelection(value: $selectedAngle)
        
        
        List{
            if isReverseSort{
                ForEach(purchasesReversed){ purchase in
                    ListObjectView(name: purchase.store!, price: Int(purchase.price))
                }
            } else {
                ForEach(purchases){ purchase in
                    ListObjectView(name: purchase.store!, price: Int(purchase.price))
                }
            }
        }
    }
}

#Preview {
    DiagrammView()
}
