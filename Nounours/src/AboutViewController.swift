//
//  AboutViewController.swift
//  Nounours
//
//  Created by Carmen Alvarez on 02/10/2018.
//  Copyright © 2018 Carmen Alvarez. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	@IBOutlet weak var appVersion: UILabel!
	@IBOutlet weak var authorName: UILabel!
	@IBOutlet weak var email: UILabel!
	@IBOutlet weak var credits: UILabel!
	@IBOutlet weak var macarenours: UILabel!
	
	@IBOutlet weak var inAppSettings: UILabel!
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		appVersion.setLocalizedTextId(id: "abouttextversion")
		authorName.setLocalizedTextId(id: "abouttextauthor")
		email.setLocalizedTextId(id: "abouttextemail")
		credits.setLocalizedTextId(id: "abouttextcredits")
		macarenours.setLocalizedTextId(id: "abouttextmacarenours")
		inAppSettings.setLocalizedTextId(id: "abouttextinappsettings")
	}
	@IBAction func done(_ sender: UIBarButtonItem) {
		dismiss(animated: true)
	}
}

extension UILabel {
	func setLocalizedTextId(id: String){
		self.text = NSLocalizedString(id, comment:"")
	}
}
