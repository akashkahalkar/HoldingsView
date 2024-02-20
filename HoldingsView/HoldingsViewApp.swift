//
//  HoldingsViewApp.swift
//  HoldingsView
//
//  Created by akash kahalkar on 20/02/24.
//

import SwiftUI
import SwiftData

@main
struct HoldingsViewApp: App {
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            UserHolding.self
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            let viewModel = DefaultViewModelFactory.shared.getUserHoldingViewModel()
            HoldingListView(viewModel: viewModel)
        }
        //.modelContainer(sharedModelContainer)
    }
}
