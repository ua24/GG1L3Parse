//
//  AddPostViewController.swift
//  GG1L3Parse
//
//  Created by Ivan Vasilevich on 5/11/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit
import Parse

class AddPostViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        let post = PFObject(className: "Post")
        post["text"] = textView.text!
        post["user"] = PFUser.current()
        post.saveEventually()
    }

}
