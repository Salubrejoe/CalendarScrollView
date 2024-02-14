
import SwiftUI


//protocol ViewBuildero {
//  func buildDescription<T: CalendarModel>(_ period: T) -> AnyView
//}



struct CalendarView<Content: View>: View {
  
  @State private var calendarPeriods = CalendarPeriods()
  
  @Binding var intervalSelection: IntervalSelection
  @State private var positionId: Int?
  
  let content: (any CalendarModel) -> Content
  
  
  init(
    intervalSelection: Binding<IntervalSelection>,
    @ViewBuilder content: @escaping (any CalendarModel) -> Content
    
  ) {
    
    self._intervalSelection = intervalSelection
    self.content = content
  }

  var body: some View {
    
    GeometryReader { geo in
      
      
      VStack {
        
        segmentControl
        
        periodView
      }
      .padding()
      .animation(.easeInOut, value: intervalSelection)
      .onChange(of: positionId, loadMoreIfNeeded)
    }
  }
  
  
  @ViewBuilder
  private var periodView: some View {
    
    switch intervalSelection {
    case .day:
      PeriodView(periods: $calendarPeriods.dayModel, positionId: $positionId, content: descriptionOf)
    case .week:
      PeriodView(periods: $calendarPeriods.weekModel, positionId: $positionId, content: descriptionOf)
    case .month:
      PeriodView(periods: $calendarPeriods.monthModel, positionId: $positionId, content: descriptionOf)
    case .year:
      PeriodView(periods: $calendarPeriods.yearModel, positionId: $positionId, content: descriptionOf)
    }
  }
  
  @ViewBuilder
  private func descriptionOf<T: CalendarModel>(_ period: T) -> some View {
    
    VStack {
      
      Text(period.startDate.description)
      Text(period.endDate.description)
      
      content(period as! (any CalendarModel))
    }
  }
  
  @ViewBuilder
  private var segmentControl: some View {
    
    Picker("Calendar Selection", selection: $intervalSelection) {
      ForEach(IntervalSelection.allCases, id: \.self) { selection in
        Text(selection.rawValue).tag(selection)
      }
    }
    .pickerStyle(.segmented)
  }
  
  private func loadMoreIfNeeded() {
    
    switch intervalSelection {
    case .day:
      loadMoreIfNeeded(for: &calendarPeriods.dayModel)
    case .week:
      loadMoreIfNeeded(for: &calendarPeriods.weekModel)
    case .month:
      loadMoreIfNeeded(for: &calendarPeriods.monthModel)
    case .year:
      loadMoreIfNeeded(for: &calendarPeriods.yearModel)
    }

  }
  
  private func loadMoreIfNeeded<T>(for items: inout [T]) where T: Identifiable & CalendarModel {
    
    if let positionId = positionId, positionId == items.count - 1 {
      
      
      let newItems = [
        T.init(minus: positionId + 1),
        T.init(minus: positionId + 2)
      ]
      
      items.append(contentsOf: newItems)
    }
  }
}
//
//#Preview {
//  CalendarView()
//}


//    switch calendarSelection {
//    case .day:
//      if let positionId, positionId == days..count - 1 {
//
//        let newDays = [
//          DayModello(minus: positionId + 1),
//          DayModello(minus: positionId + 2)
//        ]
//
//        days.append(contentsOf: newDays)
//      }
//
//    case .week:
//      if let positionId, positionId == weeks.count - 1 {
//
//        let newWeeks = [
//          WeekModello(minus: positionId + 1),
//          WeekModello(minus: positionId + 2)
//        ]
//
//        weeks.append(contentsOf: newWeeks)
//      }
//
//    case .month:
//      if let positionId, positionId == months.count - 1 {
//
//        let newMonths = [
//          MonthModello(minus: positionId + 1),
//          MonthModello(minus: positionId + 2)
//        ]
//
//        months.append(contentsOf: newMonths)
//      }
//
//    case .year:
//      if let positionId, positionId == years.count - 1 {
//
//        let newYears = [
//          YearModello(minus: positionId + 1),
//          YearModello(minus: positionId + 2)
//        ]
//
//        years.append(contentsOf: newYears)
//
//      }
//    }


//      let newItems = (positionId..<positionId + 2).map { T.init(minus: $0) }


//
//        Picker("Calendar Selection", selection: $selection) {
//          Text("Day")
//            .tag(CalendarSelection.day)
//          Text("Week")
//            .tag(CalendarSelection.week)
//          Text("Month")
//            .tag(CalendarSelection.month)
//          Text("Year")
//            .tag(CalendarSelection.year)
//        }
//        .pickerStyle(.segmented)
//


//          Group {
//
//            switch selection {
//            case .day:
//              dayView(with: geo)
//            case .week:
//              weekView(with: geo)
//            case .month:
//              monthView(with: geo)
//            case .year:
//              yearView(with: geo)
//            }
//          }



//@ViewBuilder
//  private func weekView(with geo: GeometryProxy) -> some View {
//    LazyHStack(spacing: 0) {
//
//      ForEach(weeks) { week in
//
//        VStack(spacing: 20) {
//
//          let date = week.startDate
//
//          Text("Start Date: \(week.startDate.formatted(date: .numeric, time: .shortened))")
//            .foregroundStyle(.secondary)
//            .padding(.top)
//          Text("End Date: \(week.endDate.formatted(date: .numeric, time: .shortened))")
//            .foregroundStyle(.secondary)
//
//          Spacer()
//
//          Text("Week \(date.weekOfYear())")
//            .font(.title)
//
//          Text(date.monthName())
//            .font(.title2)
//
//          Spacer()
//
//          Text(positionId?.description ?? "-404")
//            .font(.largeTitle)
//            .foregroundStyle(.secondary)
//            .padding(.bottom)
//
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//        .border(Color.white)
//        .id(weeks.firstIndex(where: { $0.id == week.id }))
//        .frame(width: geo.size.width)
//
//      }
//    }
//  }
