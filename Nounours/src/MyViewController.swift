//
//  MyViewController.swift
//  
//
//  Created by Carmen Alvarez on 01/10/2018.
//

import UIKit

class MyViewController: UIViewController {

	private var nounours : Nounours?
	private var nounoursSettingsDelegate: NounoursSettingsDelegate?
	
	@IBOutlet weak var mainView: MainView! {
		didSet {
			nounours = Nounours(nounours: mainView)
		}
	}
	@IBAction func showHelp(_ sender: UIBarButtonItem) {
		nounours?.display(nounours?.curTheme.helpImage)
	}
	@IBAction func showAnimations(_ sender: UIBarButtonItem) {
		if let animationAlertController = AnimationMenu.createAnimationList(nounours) {
			present(animationAlertController, animated:true)
		}
	}
	@IBAction func showThemes(_ sender: UIBarButtonItem) {
		if let themeAlertController = ThemeMenu.createThemeList(nounours) {
			present(themeAlertController, animated:true)
		}
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let navController = segue.destination as? UINavigationController {
			if let settingsTableViewController = navController.viewControllers.first as? SettingsTableViewController {
				settingsTableViewController.delegate = nounoursSettingsDelegate
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		DispatchQueue.main.async  { [weak self] in
			self?.doLoad()
		}
	}
	override var canBecomeFirstResponder: Bool {
		return true
	}

	private func doLoad() {
		nounoursSettingsDelegate = NounoursSettingsDelegate()
		if (isViewLoaded) {
			nounours?.onShown()
		}
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		if let touch = touches.first {
			let point = touch.location(in: mainView)
			if (touch.view == mainView) {
				nounours?.onPress(point.x, withY: point.y)
			}
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		nounours?.onRelease()
	}
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let point = touch.location(in: mainView)
			nounours?.onMove(point.x, withY:point.y)
		}
	}
	override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		if (motion == .motionShake) {
			nounours?.onShake()
		}
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if (nounours != nil) {
			//mainView?.resize()
		}
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		becomeFirstResponder()
		nounours?.loadPreferences()
		nounours?.onShown()
	}
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		resignFirstResponder()
		nounours?.savePreferences()
		nounours?.onHidden()
	}

}
