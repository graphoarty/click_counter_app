//
//  ClickCounterWidget.swift
//  ClickCounterWidget
//
//  Created by Quinston  Pimenta  on 08/09/24.
//

import WidgetKit
import SwiftUI
import AppIntents

struct IncrementEntry: AppIntent {
    
	static var title: LocalizedStringResource = "Increment Counter"

	func perform() async throws -> some IntentResult & ReturnsValue {
		
		let sharedDefaults = UserDefaults(suiteName: "group.click-counter-app-group")
		let counter = sharedDefaults?.integer(forKey: "counter") ?? 0
		let incrementer = sharedDefaults?.integer(forKey: "incrementer") ?? 1
        sharedDefaults?.setValue(counter + incrementer, forKey: "counter")

        return .result()
        
	}

}

struct DecrementEntry: AppIntent {
    
	static var title: LocalizedStringResource = "Decrement Counter"

	func perform() async throws -> some IntentResult & ReturnsValue {
		
		let sharedDefaults = UserDefaults(suiteName: "group.click-counter-app-group")
		let counter = sharedDefaults?.integer(forKey: "counter") ?? 0
        sharedDefaults?.setValue(counter - 1, forKey: "counter")

        return .result()
        
	}

}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> ClickCounterWidgetEntry {
        ClickCounterWidgetEntry(date: Date(), configuration: ConfigurationAppIntent(), counter: 0)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> ClickCounterWidgetEntry {
        ClickCounterWidgetEntry(date: Date(), configuration: configuration, counter: 0)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<ClickCounterWidgetEntry> {
        var entries: [ClickCounterWidgetEntry] = []
        
        let sharedDefaults = UserDefaults.init(suiteName: "group.click-counter-app-group")
        let counter = sharedDefaults?.integer(forKey: "counter") ?? 0

		let currentDate = Date()
        for secondOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .second, value: secondOffset, to: currentDate)!
            let entry = ClickCounterWidgetEntry(date: entryDate, configuration: configuration, counter: counter)
        	entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct ClickCounterWidgetEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let counter: Int
}

struct ClickCounterWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(String(entry.counter)).font(.title)
                .contentTransition(.numericText())
            HStack{
				Button(
					intent: DecrementEntry()) {
					Image(systemName: "minus.circle")
						.font(.largeTitle)
				}
				Button(
					intent: IncrementEntry()) {
					Image(systemName: "plus.circle")
						.font(.largeTitle)
				}
			}
        }
    }
}

struct ClickCounterWidget: Widget {
    let kind: String = "ClickCounterWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ClickCounterWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}
