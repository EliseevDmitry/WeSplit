//
//  ContentView.swift
//  WeSplit
//
//  Created by Dmitriy Eliseev on 22.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - PROPORTIES
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    @State private var isZeroTip: Bool = false
    //let tipPercentages = [10, 15, 20, 25, 0]
    
    //вычисляемые свойства:
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandeTotal = checkAmount + tipValue
        return grandeTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalAmount / peopleCount
        return amountPerPerson
    }
    
    //MARK: - BODY
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    //Locale.current.currency?.identifier - текущая региональная валюта
                    //.keyboardType(.decimalPad) - тип клавиатуры
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        //ForEach(2..<100) { item in
                        //Text("\(item) people")
                        //}
                        
                        //Идентично:
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink) //работает с NavigationStack
                }//: SECTION 1
                
                Section("How much do you want to tip?"){
                    Picker("Tip persentage", selection: $tipPercentage) {
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    //.pickerStyle(.segmented)
                    .pickerStyle(.navigationLink)
                    .onAppear(perform: {
                        if tipPercentage == 0 {
                            isZeroTip = true
                        } else {
                            isZeroTip = false
                        }
                    })
                }//: SECTION 2
             
                Section("Total amount for the check"){
                    Text(totalAmount,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .foregroundStyle(isZeroTip ? .red : .black)
                }//: SECTION 3
                
                Section("Amount per person"){
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                }//: SECTION 4
            }//: FORM
            .navigationTitle("WeSplit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }//: NAVIGATIONSTACK
    }//: BODY
}

//MARK: - PREVIEW
#Preview {
    ContentView()
}
