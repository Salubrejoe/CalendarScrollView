
import Foundation


enum IntervalSelection: String, CaseIterable {
  case day = "Day"
  case week = "Week"
  case month = "Month"
  case year = "Year"
}


protocol CalendarModel: Identifiable, CustomStringConvertible {
  
  var id: UUID { get }
  var startDate: Date { get }
  var endDate: Date { get }
  
  init(minus: Int)
}

extension CalendarModel {
  
  static var items: [Self] { [.init(minus: 0), .init(minus: 1), .init(minus: 2)] }
}


struct CalendarPeriods {
  
  var dayModel   = DayModel.items
  var weekModel  = WeekModel.items
  var monthModel = MonthModel.items
  var yearModel  = YearModel.items
}


// MARK: - DAY
class DayModel: CalendarModel, Equatable {
  var description: String { startDate.dayOfTheWeek() }
  static func == (lhs: DayModel, rhs: DayModel) -> Bool {
    lhs.id == rhs.id
  }
  
  var id = UUID()
  
  var startDate: Date
  var endDate: Date
  
  required init(minus numberOfDays: Int) {
    let calendar = Calendar.current
    
    let currentDate = Date()
    
    guard let startDate = calendar.date(byAdding: .day, value: -numberOfDays, to: currentDate) else {
      fatalError("\n[Day Model] - Failed to calculate start date\n\n")
    }
    
    guard let startOfDay = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: startDate) else {
      fatalError("\n[Day Model] - Failed to set start date to 00:00\n\n")
    }
    
    self.startDate = startOfDay
    
    guard let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay) else {
      fatalError("\n[Day Model] - Failed to set end date to 24:00\n\n")
    }
    
    self.endDate = endOfDay
  }
}



// MARK: - WEEK
class WeekModel: CalendarModel, Equatable {
  var description: String { startDate.weekOfYear().description }
  
  
  static func == (lhs: WeekModel, rhs: WeekModel) -> Bool {
    lhs.id == rhs.id
  }
  
  var id = UUID()
  
  var startDate: Date
  var endDate: Date
  
  required init(minus numberOfWeeks: Int) {
    let calendar = Calendar.current
    
    guard let firstDayOfCurrentWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: .now)) else {
      fatalError("\n[Week Model] - Failed to get the first day of the current week\n\n")
    }
    let monday = calendar.date(byAdding: .weekOfMonth, value: -numberOfWeeks, to: firstDayOfCurrentWeek)!
    startDate = monday
    let sunday = calendar.date(byAdding: .day, value: 6, to: startDate)!
    endDate = sunday
  }
}




// MARK: - MONTH
class MonthModel: CalendarModel, Equatable {
  var description: String { startDate.monthName() }
  
  
  static func == (lhs: MonthModel, rhs: MonthModel) -> Bool {
    lhs.id == rhs.id
  }
  
  var id = UUID()
  
  var startDate: Date
  var endDate: Date
  
  required init(minus numberOfMonths: Int) {
    let calendar = Calendar.current
    
    guard let firstDayOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: .now)) else {
      fatalError("\n[Month Model] - Failed to get the first day of the current month\n\n")
    }
    
    guard let startDate = calendar.date(byAdding: .month, value: -numberOfMonths, to: firstDayOfCurrentMonth) else {
      fatalError("\n[Month Model] - Failed to calculate start date\n\n")
    }
    
    self.startDate = startDate
    
    guard let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) else {
      fatalError("\n[Month Model] - Failed to calculate end date\n\n")
    }
    
    self.endDate = endDate
  }
}



// MARK: - YEAR
class YearModel: CalendarModel, Equatable {
  var description: String { startDate.year().description }
  
  static func == (lhs: YearModel, rhs: YearModel) -> Bool {
    lhs.id == rhs.id
  }
  
  var id = UUID()
  
  var startDate: Date
  var endDate: Date
  
  required init(minus numberOfYears: Int) {
    let calendar = Calendar.current
    
    guard let firstDayOfCurrentYear = calendar.date(from: calendar.dateComponents([.year], from: .now)) else {
      fatalError("\n[Year Model] - Failed to get the first day of the current year\n\n")
    }
    
    guard let startDate = calendar.date(byAdding: .year, value: -numberOfYears, to: firstDayOfCurrentYear) else {
      fatalError("\n[Year Model] - Failed to calculate start date\n\n")
    }
    
    self.startDate = startDate
    
    guard let endDate = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: startDate) else {
      fatalError("\n[Year Model] - Failed to calculate end date\n\n")
    }
    
    self.endDate = endDate
    
  }
}

/*
 
 protocol CalendarRepresentable {
 associatedtype T: Identifiable & CalendarRepresentable
 
 init(minus: Int)
 
 var id: UUID { get }
 var startDate: Date { get }
 var endDate: Date { get }
 
 static var defaultTimeIntervals: [T] { get }
 }
 
 extension CalendarRepresentable {
 
 static var defaultTimeIntervals: [T] {
 var intervals = [T]()
 intervals.append(T(minus: 0))
 intervals.append(T(minus: 1))
 intervals.append(T(minus: 2))
 return intervals
 }
 }
 
 struct WeekModel: Identifiable, CalendarRepresentable {
 typealias T = WeekModel
 
 var id = UUID()
 var startDate: Date
 var endDate: Date
 
 init(minus numberOfWeeks: Int) {
 let calendar = Calendar.current
 
 guard let firstDayOfCurrentWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: .now)) else {
 fatalError("\n[Week Model] - Failed to get the first day of the current week\n\n")
 }
 let monday = calendar.date(byAdding: .weekOfMonth, value: -numberOfWeeks, to: firstDayOfCurrentWeek)!
 startDate = monday
 let sunday = calendar.date(byAdding: .day, value: 6, to: startDate)!
 endDate = sunday
 }
 }
 
 struct YearModel: Identifiable, CalendarRepresentable {
 typealias T = YearModel
 
 
 var id = UUID()
 var startDate: Date
 var endDate: Date
 
 init(minus numberOfYears: Int) {
 let calendar = Calendar.current
 
 guard let firstDayOfCurrentYear = calendar.date(from: calendar.dateComponents([.year], from: .now)) else {
 fatalError("\n[Year Model] - Failed to get the first day of the current year\n\n")
 }
 
 guard let startDate = calendar.date(byAdding: .year, value: -numberOfYears, to: firstDayOfCurrentYear) else {
 fatalError("\n[Year Model] - Failed to calculate start date\n\n")
 }
 
 self.startDate = startDate
 
 guard let endDate = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: startDate) else {
 fatalError("\n[Year Model] - Failed to calculate end date\n\n")
 }
 
 self.endDate = endDate
 
 }
 }
 
 
 struct MonthModel: Identifiable, CalendarRepresentable {
 typealias T = MonthModel
 
 var id = UUID()
 var startDate: Date
 var endDate: Date
 
 init(minus numberOfMonths: Int) {
 let calendar = Calendar.current
 
 guard let firstDayOfCurrentMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: .now)) else {
 fatalError("\n[Month Model] - Failed to get the first day of the current month\n\n")
 }
 
 guard let startDate = calendar.date(byAdding: .month, value: -numberOfMonths, to: firstDayOfCurrentMonth) else {
 fatalError("\n[Month Model] - Failed to calculate start date\n\n")
 }
 
 self.startDate = startDate
 
 guard let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) else {
 fatalError("\n[Month Model] - Failed to calculate end date\n\n")
 }
 
 self.endDate = endDate
 }
 }
 
 
 
 
 
 struct DayModel: Identifiable, CalendarRepresentable {
 typealias T = DayModel
 
 var id = UUID()
 var startDate: Date
 var endDate: Date
 
 init(minus numberOfDays: Int) {
 guard let today = Calendar.current.date(byAdding: .day, value: -numberOfDays, to: .now) else {
 fatalError("\n[Day Model] - Failed to get today\n\n")
 }
 startDate = today
 endDate = today
 }
 }

 */
