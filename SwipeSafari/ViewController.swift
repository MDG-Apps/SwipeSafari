//
//  ViewController.swift
//  SwipeSafari
//
//  Created by Stefan Gugarel on 21/10/15.
//  Copyright © 2015 Stefan Gugarel. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
	let safaridelegate = OCSafariDelegate()
	@IBOutlet weak var showButton: UIBarButtonItem!
	
	// MARK: - View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
        safaridelegate.delegate = self
		view.backgroundColor = UIColor.whiteColor()
		self.navigationController?.delegate = safaridelegate
	}
	
	override func viewWillAppear(animated: Bool) {
		
		super.viewWillAppear(animated)
		
		self.navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
				
		showButton.enabled = true
	}
	
	// MARK: - Actions
	
	@IBAction func showButtonPressed(sender: AnyObject) {
		
		showButton.enabled = false

		let safariViewController = OCSafariViewController(URL: NSURL(string: "http://www.cocoanetics.com")!)
		
		safariViewController.delegate = safaridelegate
		safariViewController.gestureDelegate = safaridelegate
		
		self.navigationController?.pushViewController(safariViewController, animated: true)
		
		NSLog("Present Safari!")
	}
}

