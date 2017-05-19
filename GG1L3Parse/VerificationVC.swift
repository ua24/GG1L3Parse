//
//  VerificationVC.swift
//  GG1L3Parse
//
//  Created by Ivan Vasilevich on 5/17/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit
import SinchVerification


class VerificationVC: UIViewController {

    let applicationKey = "FUUUUUUUUUUUUUUUUUUUUUU...";
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var pinCode: UITextField!
    
    var verification: Verification!;
    
    
    override func viewWillAppear(_ animated: Bool) {
        phoneNumber.becomeFirstResponder();
        
    }
    
    @IBAction func sendCode(_ sender: UIButton) {
        
         verification = SMSVerification(applicationKey, phoneNumber: "+380930736656", custom: "custom here", languages: ["uk", "ua", "ru", "en"])
        
        verification.initiate { (result, error) in
            print(result)
            print(error ?? "zeroErr")
        }
        
    }
    
    @IBAction func verifyPressed(_ sender: UIButton) {
        verification.verify(
            self.pinCode.text!, completion:
            { (success:Bool, error:Error?) -> Void in
                if (success) {
                    self.title = "Verified";
                } else {
                    self.title = error?.localizedDescription
                }
        });
    }

}
