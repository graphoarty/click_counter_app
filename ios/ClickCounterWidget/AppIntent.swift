//
//  AppIntent.swift
//  ClickCounterWidget
//
//  Created by Quinston  Pimenta  on 09/09/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")
}
