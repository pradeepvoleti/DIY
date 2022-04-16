//
//  BLEConfirmationViewController.swift
//  DIY
//
//  Created by Ram Voleti on 15/04/22.
//

import UIKit

class BLEConfirmationViewController: BaseViewController {

    @IBOutlet weak var imageView: UIImageView!
    var userModel: UserModel?
    let bleHelper: BLEHelpProvidable = BLEHelper.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bleHelper.initiate()
        if userModel?.deviceType == .pen {
            imageView.image = UIImage(named: "BLE Pen")
        } else {
            imageView.image = UIImage(named: "BGM Meter")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let status = isBluetoothOn()
        return status
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DateSelectionViewController ?? DateSelectionViewController()
        destination.userModel = userModel
    }
}

private extension BLEConfirmationViewController {
    
    func isBluetoothOn() -> Bool {

        let state = bleHelper.getState()
        if state == .poweredOff {
            showAlert(title: "Alert", message: "Please enable Bluetooth to proceed")
            return false
        } else if state == .unauthorised {
            showAlert(title: "Alert", message: "Please enable Bluetooth in App Settings to proceed")
            return false
        }
        return true
    }
}
