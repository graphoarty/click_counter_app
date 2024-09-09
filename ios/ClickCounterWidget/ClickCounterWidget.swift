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
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), counter: 0)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, counter: 0)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let sharedDefaults = UserDefaults.init(suiteName: "group.click-counter-app-group")
        let counterString = sharedDefaults?.integer(forKey: "counter") ?? 0
        
        let entryDate = Calendar.current.date(byAdding: .hour, value: 24, to: Date())!
        let entry = SimpleEntry(date: entryDate, configuration: configuration, counter: counterString)
        entries.append(entry)

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
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

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}
