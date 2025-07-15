//
//  AnimatableRectangle.swift
//  ReactionTimeApp
//
//  Created by Toby Weir on 15/07/2025.
//
//This code is taken from this stack overflow answer https://stackoverflow.com/a/76939842
//It adds the extensions needed to animate changes to a rounded rectangle corner radius, allowing for animating a circle becoming a rectangle

import SwiftUI

public struct CornerRadiusKey: EnvironmentKey {
    public static let defaultValue: Double = 0
}

extension EnvironmentValues {
    var cornerRadius: Double {
        get { return self[CornerRadiusKey.self] }
        set { self[CornerRadiusKey.self] = newValue }
    }
}

struct AnimatableRoundedRectangle: View {
    @Environment(\.cornerRadius) var cornerRadius: Double

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
    }
}

struct AnimatableRoundedRectangleModifier: ViewModifier, Animatable {
    var cornerRadius: Double

    var animatableData: Double {
        get { cornerRadius }
        set { cornerRadius = newValue }
    }

    func body(content: Content) -> some View {
        return content
            .environment(\.cornerRadius, cornerRadius)
    }
}

extension AnyTransition {
    static func cornerRadius(identity: Double, active: Double) -> AnyTransition {
        AnyTransition.modifier(
            active: AnimatableRoundedRectangleModifier(cornerRadius: active),
            identity: AnimatableRoundedRectangleModifier(cornerRadius: identity)
        )
    }
}
