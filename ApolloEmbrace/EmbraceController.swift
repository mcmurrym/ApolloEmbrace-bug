//
//  EmbraceController.swift
//  ApolloEmbrace
//
//  Created by Matt McMurry on 5/23/24.
//

import Foundation
import EmbraceIO
import StdoutExporter

class EmbraceController {
    static func start() {
        do {
            let otelExport = OpenTelemetryExport(
                spanExporter: StdoutExporter()
            )

            let options = Embrace.Options(
                appId: "-----",
                export: otelExport
            )

            try Embrace
                .setup(options: options)
                .start()

        } catch let e {
            print("Error starting Embrace \(e.localizedDescription)")
        }
    }
}
