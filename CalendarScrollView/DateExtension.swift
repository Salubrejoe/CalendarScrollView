
import Foundation



extension Date {
  
  func dateComp() -> DateComp {
    
    let day = Calendar.current.component(.day, from: self)
    let month = Calendar.current.component(.month, from: self)
    let year = Calendar.current.component(.year, from: self)
    
    return DateComp(day: day, month: month, year: year)
  }
  
  func dayOfTheWeek() -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    dateFormatter.locale = Locale.current
    
    return dateFormatter.string(from: self)
  }
  
  func monthName() -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    dateFormatter.locale = Locale.current
    
    return dateFormatter.string(from: self)
  }
  
  func weekOfYear() -> Int {
    
    let calendar = Calendar.current
    let weekOfYear = calendar.component(.weekOfYear, from: self)
    return weekOfYear
  }
  
  func year() -> Int {
    
    let calendar = Calendar.current
    return calendar.component(.year, from: self)
  }
}
