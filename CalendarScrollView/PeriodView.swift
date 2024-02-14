
import SwiftUI

struct PeriodView<T: CalendarModel, Content: View>: View {
  
  @Binding var periods: [T]
  
  @Binding var positionId: Int?
  
  let content: (T) -> Content
  
  var body: some View {
    
    GeometryReader { proxy in
      
      ReversedHorizontalScrollView {
        
        LazyHStack(spacing: 0) {
          
          ForEach(periods, id: \.id) { period in
            
            content(period)
              .frame(width: proxy.size.width)
              .id(periods.firstIndex(where: { $0.id == period.id }))
          }
        }
        .scrollTargetLayout()
      }
      .scrollPosition(id: $positionId)
      .scrollIndicators(.never)
      .scrollTargetBehavior(.paging)
    }
  }
}
