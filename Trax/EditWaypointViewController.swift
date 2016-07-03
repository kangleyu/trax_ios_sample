//
//  EditWaypointViewController.swift
//  Trax
//
//  Created by Tom Yu on 7/3/16.
//  Copyright © 2016 kangleyu. All rights reserved.
//

import UIKit

class EditWaypointViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.delegate = self
        }
    }

    @IBOutlet weak var infoTextField: UITextField! {
        didSet {
            infoTextField.delegate = self
        }
    }
    
    @IBAction func done(sender: UIBarButtonItem) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    var waypointToEdit: EditableWaypoint? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        nameTextField?.text = waypointToEdit?.name
        infoTextField?.text = waypointToEdit?.info
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        nameTextField.becomeFirstResponder()
    }
    
    private var ntfobserver: NSObjectProtocol?
    private var itfobserver: NSObjectProtocol?
    
    private func listenToTextFields() {
        let center = NSNotificationCenter.defaultCenter()
        let queue = NSOperationQueue.mainQueue()
        
        ntfobserver = center.addObserverForName(
            UITextFieldTextDidChangeNotification,
            object: nameTextField,
            queue: queue) {
                notification in
                if let waypoint = self.waypointToEdit {
                    waypoint.name = self.nameTextField.text
                }
        }
        
        itfobserver = center.addObserverForName(
            UITextFieldTextDidChangeNotification,
            object: infoTextField,
            queue: queue) {
                notification in
                if let waypoint = self.waypointToEdit {
                    waypoint.name = self.infoTextField.text
                }
        }
    }
    
    private func stopListeningToTextFields() {
        if let observer = ntfobserver {
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }
        if let observer = itfobserver {
            NSNotificationCenter.defaultCenter().removeObserver(observer)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        listenToTextFields()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        stopListeningToTextFields()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        return true
    }
}
