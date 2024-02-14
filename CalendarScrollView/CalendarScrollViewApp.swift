//
//  CalendarScrollViewApp.swift
//  CalendarScrollView
//
//  Created by Lore P on 10/02/2024.
//

import SwiftUI

@main
struct CalendarScrollViewApp: App {
  
  @State private var intervalSelection: IntervalSelection = .day
  
    var body: some Scene {
        WindowGroup {
            
          NavigationStack {
            
            CalendarView(intervalSelection: $intervalSelection, content: { model in
              
              TestContentView(model: model)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationTitle("Calendar")
          }
        }
    }
}


struct TestContentView: View {
  
  let model: (any CalendarModel)
  
  var body: some View {
    
    if let dayModel = model as? DayModel {
      
      Text("Day \(model.description)")
        .font(.largeTitle)
      
    } else if let weekModel = model as? WeekModel {
      
      Text("Week \(model.description)")
        .font(.largeTitle)
      
    } else if let weekModel = model as? MonthModel {
      
      Text("Month \(model.description)")
        .font(.largeTitle)
      
    } else if let weekModel = model as? YearModel {
      
      Text("Year \(model.description)")
        .font(.largeTitle)
      
    }
  }
}
