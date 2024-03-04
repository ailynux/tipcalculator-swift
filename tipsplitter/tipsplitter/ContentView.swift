//
//  ContentView.swift
//  tipsplitter
//
//  Created by Ailyn Diaz on 2/27/24.
//  CSC iOS --> TIP CALCULATOR

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // Image "calc"
                Image("calc")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .padding(.bottom, 30)

                Text("TAB SPLIT")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)

                Form {
                    Section(header: Text("Bill Details").foregroundColor(.blue)) {
                        HStack {
                            Text("Amount")
                                .foregroundColor(.blue)
                            Spacer()
                            TextField("", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .keyboardType(.decimalPad)
                                .focused($amountIsFocused)
                        }

                        Stepper(value: $numberOfPeople, in: 1...100, label: {
                            Text("Number of people: \(numberOfPeople)")
                                .foregroundColor(.orange)
                        })
                    }

                    Section(header: Text("Tip Percentage").foregroundColor(.green)) {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .foregroundColor(.green)
                    }

                    Section(header: Text("Total").foregroundColor(.blue)) {
                        HStack {
                            Text("Total per person")
                                .foregroundColor(.blue)
                            Spacer()
                            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(tipPercentage == 0 ? .red : .primary)
                                .animation(.easeInOut)
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
