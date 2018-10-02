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
	
	// MARK: Button actions
	@IBAction func showHelp(_ sender: UIBarButtonItem) {
		nounours?.display(nounours?.curTheme.helpImage)
	}
	@IBAction func showAnimations(_ sender: UIBarButtonItem) {
		if let animationAlertController = AnimationMenu.createAnimationList(nounours) {
			showAlertController(alertController: animationAlertController, sender: sender)
		}
	}
	@IBAction func showThemes(_ sender: UIBarButtonItem) {
		if let themeAlertController = ThemeMenu.createThemeList(nounours) {
			showAlertController(alertController: themeAlertController, sender: sender)
		}
	}
	private func showAlertController(alertController: UIAlertController, sender: UIBarButtonItem) {
		if let popoverController = alertController.popoverPresentationController {
			popoverController.barButtonItem = sender
		}
		present(alertController, animated:true)
	}
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let navController = segue.destination as? UINavigationController {
			if let settingsTableViewController = navController.viewControllers.first as? SettingsTableViewController {
				settingsTableViewController.delegate = nounoursSettingsDelegate
			}
		}
	}

	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		DispatchQueue.main.async  { [weak self] in
			self?.doLoad()
		}
	}
	
	private func doLoad() {
		nounoursSettingsDelegate = NounoursSettingsDelegate()
		if (isViewLoaded) {
			nounours?.onShown()
		}
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		becomeFirstResponder()
		nounours?.loadPreferences()
		nounours?.onShown()
		NotificationCenter.default.addObserver(self, selector: #selector(onResignActive), name: UIApplication.didEnterBackgroundNotification, object: nil)
	}
	@objc
	private func onResignActive() {
		nounours?.savePreferences()
	}
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		resignFirstResponder()
		nounours?.savePreferences()
		nounours?.onHidden()
		NotificationCenter.default.removeObserver(#selector(onResignActive))
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
	
	// MARK: Touch events
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

}
