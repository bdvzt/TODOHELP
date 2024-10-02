//
//  TODOAPPApp.swift
//  TODOAPP
//
//  Created by Zayata Budaeva on 02.10.2024.
//

import SwiftUI

@main
struct TODOAPPApp: App {
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
            WindowGroup {
                NavigationView{
                    ListView()
                }
                .environmentObject(listViewModel)
            }
        }
}
