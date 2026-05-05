//
//  AppDelegate.swift
//  PRASARTDAEG
//
//  Created by Nathanon K on 28/4/2569 BE.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		NSApplication.shared.windows.first?.toggleFullScreen(nil)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

}
