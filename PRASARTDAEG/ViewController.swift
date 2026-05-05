//
//  ViewController.swift
//  PRASARTDAEG
//
//  Created by Nathanon K on 28/4/2569 BE.
//

import Cocoa
import GameplayKit
import SpriteKit

class ViewController: NSViewController {

	@IBOutlet var skView: SKView!

	override func viewDidLoad() {
		super.viewDidLoad()

		if let view = self.view as? SKView {
			if let scene = SKScene(fileNamed: "GameScene") {
				view.presentScene(scene)
			}

			view.ignoresSiblingOrder = true
			view.showsFPS = true
			view.showsNodeCount = true
		}
	}
}
