
import Foundation

struct DateComp: Identifiable {
  
  var id: String { day.description + month.description + year.description}
  var day: Int
  var month: Int
  var year: Int
  
  
  var date: Date {
    
    let calendar = Calendar.current
    
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    
    return calendar.date(from: components) ?? Date.distantPast
  }
}

