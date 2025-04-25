//
//  AnyAppAlert.swift
//  AIChat
//
//  Created by ChenZhen on 25/4/25.
//
import SwiftUI
import Foundation

struct AnyAppAlert: Sendable {
    var title: String
    var subtitle: String?
    var buttons: @Sendable () -> AnyView

    init(
        title: String,
        subtitle: String? = nil,
        buttons: @escaping (@Sendable () -> AnyView) = { AnyView(Button("OK", action: {})) }
    ) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons
    }

    init(error: Error) {
        self.init(
            title: "Error",
            subtitle: error.localizedDescription
        )
    }
}

enum AlertType {
    case alert, confirmationDialog
}

extension View {

    @ViewBuilder
    func showCustomAlert(type: AlertType = .alert, alert: Binding<AnyAppAlert?>) -> some View {

        switch type {
        case .alert:
            self
                .alert(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
        case .confirmationDialog:
            self
                .confirmationDialog(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert)) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.subtitle {
                        Text(subtitle)
                    }
                }
        }

    }
}
