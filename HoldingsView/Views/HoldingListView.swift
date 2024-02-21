//
//  HoldingListView.swift
//  HoldingsView
//
//  Created by akash kahalkar on 20/02/24.
//

import SwiftUI

//struct InnerHeightPreferenceKey: PreferenceKey {
//    static let defaultValue: CGFloat = .zero
//    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        value = nextValue()
//    }
//}

struct HoldingListView: View {
    
    @Bindable var viewModel: UserHoldingsViewModel
    @State private var isExpanded: Bool = false
    @State private var rotaionAngle = 0.0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            if viewModel.isLoadingData {
                ProgressView()
            } else if !viewModel.errorMessage.isEmpty {
                retryView
            } else {
                ZStack(alignment: .bottom) {
                    VStack {
                        headerView
                        holdingList.offset(y: -16)
                    }
                    holdingDetailView
                }.ignoresSafeArea(edges: .bottom)
            }
        }.task {
            await viewModel.fetchHoldingsData()
        }
    }
    
    var retryView: some View {
        VStack {
            Text(viewModel.errorMessage)
                .padding()
                .background(Color.red.gradient)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Button {
                Task {
                    await viewModel.fetchHoldingsData()
                }
            } label: {
                Text("Retry").padding()
            }
        }
    }
    
    var holdingList: some View {
        return List {
            ForEach(viewModel.holdingsData.userHolding) { holding in
                holdingContentCell(holding: holding)
            }
        }
    }
    
    var headerView: some View {
        HStack {
            Text("Upstox Holding")
                .multilineTextAlignment(.leading)
                .padding()
                .foregroundColor(.white)
                .font(.title)
                .bold()
            Spacer()
        }.frame(maxWidth: .infinity).background(Color.purple.gradient)
    }
    
    var holdingDetailView: some View {
        return VStack {
            Button {
                
                withAnimation(.linear) {
                    isExpanded.toggle()
                    if isExpanded {
                        rotaionAngle += 180
                    } else {
                        rotaionAngle = 0
                    }
                }
                
            } label: {
                Image(systemName: "chevron.up.circle.fill")
                    .resizable()
                    .foregroundColor(.purple)
                    .rotationEffect(.degrees(rotaionAngle))
                    .frame(width: 30, height: 30)
            }

            if isExpanded {
                contentCell(heading: "Current Value", value: viewModel.holdingsData.totalCurrentValue)
                contentCell(heading: "Total Investment", value: viewModel.holdingsData.totalInvestmentValue)
                contentCell(heading: "Today's Profit and Loss", value: viewModel.holdingsData.todaysPL)
                contentCell(heading: "Profit & Loss", value: viewModel.holdingsData.totalPL).padding(.vertical, 20)
            } else {
                contentCell(heading: "Profit & Loss", value: viewModel.holdingsData.totalPL).padding(.vertical, 20)
            }
            
        }.padding()
            .background(colorScheme == .light ? Color.white : Color.init(uiColor: .systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
    }
    
    private func holdingContentCell(holding: UserHolding) -> some View {
        return VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(holding.symbol).bold()
                    Text("\(holding.quantity, specifier: "%.0f")")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    HStack {
                        Text("LTP:")
                        Text(holding.ltp.getFormattedAmount())
                    }
                    HStack {
                        Text("P/L:")
                        Text(holding.individualPL.getFormattedAmount())
                    }
                }
            }
        }
    }
    
    private func contentCell(heading: String, value: Double) -> some View {
        return HStack {
            Text("\(heading):").font(.body).bold()
            Spacer()
            Text(value.getFormattedAmount())
        }.padding(.horizontal)
    }
}

#Preview {
    HoldingListView(
        viewModel: DefaultViewModelFactory.shared.getUserHoldingViewModel()
    )
}
