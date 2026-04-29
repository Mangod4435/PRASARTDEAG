//
//  GameScene.swift
//  PRASARTDAEG
//
//  Created by Nathanon K on 28/4/2569 BE.
//

import GameplayKit
import SpriteKit

class GameScene: SKScene {

	var entities = [GKEntity]()
	var graphs = [String: GKGraph]()

	private var lastUpdateTime: TimeInterval = 0
	private var label: SKLabelNode?
	private var spinnyNode: SKShapeNode?

	override func didMove(to view: SKView) {  // like Start() in unity cuz i used to work in unity so i commented this
		let background = SKSpriteNode(imageNamed: "PLACEHOLDERBG")
		background.position = CGPoint(x: frame.midX, y: frame.midY) // sets position to middle since anchor of this bg is in middle(i think cuz that's works)
		background.size = self.size // set size to fit the window size but not keep ratio (i think(again))
		background.zPosition = -1 // Ensure it stays behind other nodes
		addChild(background)
		
	}
	override func sceneDidLoad() {

		self.lastUpdateTime = 0

		// Get label node from scene and store it for use later
		self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
		if let label = self.label {
			label.alpha = 0.0  // sets the starter alpha(transparency) before it fade
			label.run(SKAction.fadeIn(withDuration: 2.0))  // FADE IT BROOO YEAHHHHHHHH
		}

		// Create shape node to use during mouse interaction
		let w = (self.size.width + self.size.height) * 0.05  // set width to 5% of screen size
		self.spinnyNode = SKShapeNode.init(
			rectOf: CGSize.init(width: w, height: w),
			cornerRadius: w * 0.3
		)  // make a retangle/square to the 5% of the screen size with corner radius

		if let spinnyNode = self.spinnyNode {
			spinnyNode.lineWidth = 2.5  // set stroke width

			spinnyNode.run(
				SKAction.repeatForever(
					SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)  // this line use radian as angle
				)
			)  // let's it spins
			spinnyNode.run(
				SKAction.sequence([
					SKAction.wait(forDuration: 0.5),
					SKAction.fadeOut(withDuration: 0.5),
					SKAction.removeFromParent(),
				])  // wait 0.5 second then fade out after that destroy it
			)
		}
	}

	func touchDown(atPoint pos: CGPoint) {
		if let n = self.spinnyNode?.copy() as! SKShapeNode? {
			n.position = pos
			n.strokeColor = SKColor.green
			self.addChild(n)
		}  // Instance new spinny node with color green
	}

	func touchMoved(toPoint pos: CGPoint) {
		if let n = self.spinnyNode?.copy() as! SKShapeNode? {
			n.position = pos
			n.strokeColor = SKColor.blue
			self.addChild(n)
		}  // Instance new spinny node with color blue
	}

	func touchUp(atPoint pos: CGPoint) {
		if let n = self.spinnyNode?.copy() as! SKShapeNode? {
			n.position = pos
			n.strokeColor = SKColor.red
			self.addChild(n)
		}  // Instance new spinny node with color red
	}

	override func mouseDown(with event: NSEvent) {
		self.touchDown(atPoint: event.location(in: self))
	}

	override func mouseDragged(with event: NSEvent) {
		self.touchMoved(toPoint: event.location(in: self))
	}

	override func mouseUp(with event: NSEvent) {
		self.touchUp(atPoint: event.location(in: self))
	}

	override func keyDown(with event: NSEvent) {
		switch event.keyCode {
		case 0x31:  // spacebar key code
			if let label = self.label {
				if let pulse = SKAction(named: "Pulse") {
					label.run(pulse, withKey: "fadeInOut")
				}
			}  // run Pluse which is action/animation in Actions.sks
		default:
			print("keyDown: \(event.characters!) \nkeyCode: \(event.keyCode)")
		}
	}

	override func update(_ currentTime: TimeInterval) { // TimeInterval is a double
		// Called before each frame is rendered

		// Initialize _lastUpdateTime if it has not already been
		if self.lastUpdateTime == 0 {
			self.lastUpdateTime = currentTime
		}

		// Calculate time since last update
		let dt = currentTime - self.lastUpdateTime

		// Update entities
		for entity in self.entities {
			entity.update(deltaTime: dt)// tell every entity to update after dt passed
		}

		self.lastUpdateTime = currentTime
	}
}
