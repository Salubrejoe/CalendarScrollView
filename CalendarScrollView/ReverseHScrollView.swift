
import SwiftUI


struct ReversedHorizontalScrollView<Content: View>: View {
  
  private let content: Content
  private let spacing: CGFloat
  private let showsIndicators: Bool
  
  init(showsIndicators: Bool = false, spacing: CGFloat = 8, @ViewBuilder content: () -> Content) {
    self.spacing = spacing
    self.showsIndicators = showsIndicators
    self.content = content()
  }
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(alignment: .center, spacing: spacing) {
        if UIDevice.isAvailable16_4 {
          content
        } else {
          content
            .rotation3DEffect(Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
        }
      }
      
    }
    .scrollIndicators(.never)
    .flipsForRightToLeftLayoutDirection(!UIDevice.isAvailable16_4)
    .environment(\.layoutDirection, .rightToLeft)
  }
  
}

extension UIDevice {
  
  static var isAvailable16_4: Bool {
    if #available(iOS 16.4, *) {
      return true
    }
    return false
  }
  
}
