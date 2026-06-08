# CalendarScrollView

A SwiftUI component for an infinitely back-scrolling calendar. Pick an interval — **Day**, **Week**, **Month**, or **Year** — and swipe horizontally through the past one page at a time. New periods are generated lazily as you reach the end, so the timeline never runs out.

## Features

- 📆 **Four interval modes** — switch between Day / Week / Month / Year with a segmented control.
- ♾️ **Lazy infinite scroll** — older periods are appended on demand as you page back through time.
- 📄 **Paged horizontal scrolling** — one period fills the screen and snaps into place (`.scrollTargetBehavior(.paging)`).
- ◀️ **Reversed scroll direction** — starts on *today* and scrolls backwards into the past via `ReversedHorizontalScrollView`.
- 🧩 **Bring your own content** — `CalendarView` takes a view builder, so you decide how each period is rendered.

## Requirements

- iOS 17.2+
- Xcode 15+
- Swift 5

## Usage

`CalendarView` is driven by an `IntervalSelection` binding and a content closure that receives the current `CalendarModel` (a `DayModel`, `WeekModel`, `MonthModel`, or `YearModel`):

```swift
import SwiftUI

struct RootView: View {
  @State private var intervalSelection: IntervalSelection = .day

  var body: some View {
    NavigationStack {
      CalendarView(intervalSelection: $intervalSelection) { model in
        // Render whatever you want for this period.
        if let day = model as? DayModel {
          Text("Day \(day.description)")
            .font(.largeTitle)
        } else if let week = model as? WeekModel {
          Text("Week \(week.description)")
        } else if let month = model as? MonthModel {
          Text("Month \(month.description)")
        } else if let year = model as? YearModel {
          Text("Year \(year.description)")
        }
      }
      .navigationTitle("Calendar")
    }
  }
}
```

Each model exposes `startDate`, `endDate`, and a human-readable `description`, so your content closure can lay out the period however you like.

## How it works

- **`CalendarModel`** — a protocol (`Identifiable`, `CustomStringConvertible`) with `startDate`, `endDate`, and an `init(minus:)` that builds the period *N* steps before today. `DayModel`, `WeekModel`, `MonthModel`, and `YearModel` each implement it using `Calendar` math.
- **`CalendarView`** — hosts the segmented `Picker`, swaps in the right `PeriodView`, and appends two new periods whenever the visible position reaches the last loaded item (`loadMoreIfNeeded`).
- **`PeriodView`** — a generic paging `LazyHStack` wrapped in `ReversedHorizontalScrollView`, tracking the visible page through `scrollPosition`.
- **`ReversedHorizontalScrollView`** — flips the layout direction (with a `rotation3DEffect` fallback below iOS 16.4) so the scroll runs from today into the past.

## Project structure

| File | Responsibility |
| --- | --- |
| `CalendarScrollViewApp.swift` | App entry point and a sample content view |
| `CalendarView.swift` | Top-level calendar UI, interval picker, lazy loading |
| `PeriodView.swift` | Generic paged horizontal scroller for a list of periods |
| `ReverseHScrollView.swift` | Right-to-left scroll container |
| `CalendarModel.swift` | `CalendarModel` protocol and the Day/Week/Month/Year models |
| `DateExtension.swift` / `DateComp.swift` | Date helpers used by the models |

## License

No license file is currently included. Add one if you intend others to reuse this code.
