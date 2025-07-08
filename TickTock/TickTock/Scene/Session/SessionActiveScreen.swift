//
//  SessionActiveScreen.swift
//  TickTock
//
//  Created by David Gunzburg on 01/07/2025.
//

import SwiftUI

struct SessionActiveScreen: View {
    
    @Environment(\.modalMode) var modalMode
    @Environment(StoreManager.self) private var storeManager
    @Environment(Coordinator.self) private var coordinator
    @State private var isTimerRunning = false
    @State private var timeAtPublish = Date()
    @State private var timeAtStart = Date()
    @State private var timerString = ""
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let defaultTimeString = "00:00:00"
    
    var elapsedTimeLabel: some View {
        Text(timerString)
            .font(Font.superLargeTitle())
            .onReceive(timer, perform: updateElapsedTime)
    }
    var startTimerButton: some View {
        Button(action: didPressStart) {
            Text(Translation.Session.activeSessionStartButton.val)
        }
        .accentColor(.labelLinks)
        .disabled(isTimerRunning)
    }
    var stopTimerButton: some View {
        Button(action: didPressStop) {
            Text(Translation.Session.activeSessionStopButton.val)
        }
        .accentColor(.labelLinks)
        .disabled(!isTimerRunning)
    }
    var createSessionButton: some View {
        Button(action: didPressCreateSession) {
            Text(Translation.General.buttonCreate.val)
        }
        .accentColor(.labelLinks)
        .disabled(!isSessionValid())
    }
    
    var body: some View {
        VStack(spacing: Spacing.interItem * 2) {
            elapsedTimeLabel
            HStack(spacing: Spacing.interItem * 2) {
                startTimerButton
                stopTimerButton
            }
            createSessionButton
        }
        .onAppear() {
            stopTimer()
            resetElapsedTime()
        }
    }
}

private extension SessionActiveScreen {
    
    func didPressStart() {
        resetElapsedTime()
        timeAtStart = Date()
        isTimerRunning = startTimer()
    }
    
    func didPressStop() {
        if isTimerRunning {
            isTimerRunning = stopTimer()
        }
    }
    
    func resetElapsedTime() {
        timerString = defaultTimeString
    }
    
    func updateElapsedTime(_ date: Date) {
        if isTimerRunning {
            guard let elapsed = DateTimeUtil.shared.stopwatchStringFromInterval(date.timeIntervalSince(timeAtStart)) else {
                resetElapsedTime()
                return
            }
            timeAtPublish = date
            timerString = elapsed
        }
    }
    
    @discardableResult
    func stopTimer() -> Bool {
        timer.upstream.connect().cancel()
        return false
    }
    
    @discardableResult
    func startTimer() -> Bool {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        return true
    }
    
    func isSessionValid() -> Bool {
        !isTimerRunning && timeAtPublish > timeAtStart
    }
    
    func didPressCreateSession() {
        storeManager.createSession(startDate: timeAtStart, endDate: timeAtPublish) { error in
            if let error {
                coordinator.presentAlert(error)
            } else {
                modalMode.wrappedValue = false
            }
        }
    }
}

#Preview {
    SessionActiveScreen()
}
