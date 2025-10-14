#!/usr/bin/env swift
import Foundation
import AppKit

// Your Terminal theme names
let darkTheme = "catppuccin-frappe"
let lightTheme = "catppuccin-latte"

// Function to switch Terminal theme
func switchTerminalTheme(isDark: Bool) {
    let theme = isDark ? "Dark" : "Light" // assuming you set theme somewhere

    let terminalScript = """
    tell application "System Events"
        set terminalRunning to (exists process "Terminal")
    end tell

    if terminalRunning then
        tell application "Terminal"
            repeat with w in windows
                repeat with t in tabs of w
                    do script "exec zsh" in t
                end repeat
            end repeat
        end tell
    end if
    """

    let task = Process()
    task.launchPath = "/usr/bin/osascript"

    // Pipe the script into osascript's stdin
    let inputPipe = Pipe()
    task.standardInput = inputPipe
    task.launch()

    if let data = terminalScript.data(using: .utf8) {
        inputPipe.fileHandleForWriting.write(data)
        inputPipe.fileHandleForWriting.closeFile()
    }
}

// Initial sync
let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
switchTerminalTheme(isDark: isDark)

// Listen for changes
DistributedNotificationCenter.default.addObserver(
    forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: nil
) { _ in
    let nowDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
    switchTerminalTheme(isDark: nowDark)
}

// Keep the process alive forever
RunLoop.main.run()
