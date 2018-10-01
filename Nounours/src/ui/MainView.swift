//
//  ImageView.swift
//  Nounours
//
//  Created by Carmen Alvarez on 01/10/2018.
//  Copyright © 2018 Carmen Alvarez. All rights reserved.
//

import UIKit

@objc
class MainView: UIImageView {

	@objc
	var imageCache : Dictionary<String,UIImage> = [:]
	
	override func didMoveToSuperview() {
		super.didMoveToSuperview()
	}

	@objc
	func useTheme(theme: Theme) {
		imageCache.removeAll()
		theme.images.allValues.forEach { value in
			if let image = value as? Image {
				setImageFromFilename(filename: image.filename)
			}
		}
	}
	
	@objc
	func setImageFromFilename(filename: String) {
		var uiImage = imageCache[filename]
		if (uiImage == nil) {
			uiImage = UIImage(contentsOfFile: filename)
			imageCache[filename] = uiImage
		}
		image = uiImage
	}
}
