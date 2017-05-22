//
//  AddPostViewController.swift
//  GG1L3Parse
//
//  Created by Ivan Vasilevich on 5/11/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit
import CoreData

class AddPostViewController: UIViewController {

    var file: Data?
    
    @IBOutlet weak var textView: UITextView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func addPhotoPressed(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        let post = Post(context: appDel.persistentContainer.viewContext)
        post.text = textView.text!
        post.user = appDel.currentUser
        if let file = self.file {
            post.photo = file as NSData
        }
        appDel.saveContext()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancellPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data = UIImageJPEGRepresentation(img, 0.3)
//        let parseFile = PFFile(data: data!, contentType: "jpg")
        file = data
//        parseFile.saveInBackground { (success, error) in
//            print("upload " + (success ? "success" : "error"))
//        }
        picker.dismiss(animated: true, completion: nil)
    }
}
