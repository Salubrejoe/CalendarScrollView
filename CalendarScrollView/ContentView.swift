
import SwiftUI

struct ContentView: View {
  
  @State private var intervalSelection: IntervalSelection = .week
  
  var body: some View {
    
    NavigationStack {
      
//      CalendarView(intervalSelection: $intervalSelection) {
        
        Text("Pizza")
//      }
    }
  }
}

#Preview {
  ContentView()
}
