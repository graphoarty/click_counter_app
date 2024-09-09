//
//  ClickCounterWidget.swift
//  ClickCounterWidget
//
//  Created by Quinston  Pimenta  on 08/09/24.
//

import WidgetKit
import SwiftUI
import AppIntents

struct LogEntry: AppIntent {
    
	static var title: LocalizedStringResource = "Log An Increment"
	static var description = IntentDescription("Add 1 To The Counter")

	func perform() async throws -> some IntentResult & ReturnsValue {
		
		let sharedDefaults = UserDefaults(suiteName: "group.click-counter-app-group")
		let counter = sharedDefaults?.integer(forKey: "counter") ?? 0
		let newCount = counter + 1
		
        sharedDefaults?.set(newCount, forKey: "counter")
		WidgetCenter.shared.reloadAllTimelines()

        return .result(value: newCount)
        
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
        let counterString = sharedDefaults?.integer(forKey: "counter") ?? 0
        
        let entryDate = Calendar.current.date(byAdding: .hour, value: 24, to: Date())!
        let entry = ClickCounterWidgetEntry(date: entryDate, configuration: configuration, counter: counterString)
        entries.append(entry)

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
            Button(
                intent: LogEntry()) {
                Image(systemName: "plus")
                    .font(.largeTitle)
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
