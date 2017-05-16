//
//  DetailViewController.swift
//  GG1L3Parse
//
//  Created by Ivan Vasilevich on 5/11/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageBox: PFImageView!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var addCommentTextView: UITextView!
    
    var post: PFObject? {
        didSet {
            // Update the view.
            configureView()
        }
    }


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = post {
            if let label = detailDescriptionLabel {
                label.text = (detail["text"] as! String)
                if let imageFile = detail["photo"] as? PFFile {
                    imageBox.file = imageFile
                    imageBox.loadInBackground()
//                    imageFile.getDataInBackground(block: { (data, error) in
//                        self.imageBox.image = UIImage(data: data!)
//                    })
                }
                let commentsRelation = post?.relation(forKey: "comments")
                let query = commentsRelation?.query()
                query?.includeKey("user")
                query?.order(byAscending: "createdAt")
                    query?.findObjectsInBackground(block: { (comments, error) in
                    var commentsStr = ""
                    if let comments = comments {
//                        comments.reverse()
                        comments.forEach({ (obj) in
                            commentsStr += "------------------------\n"
                            let text = obj["text"] as? String ?? "no text"
                            let username = (obj["user"] as? PFUser)?.username ?? "none"
                            commentsStr += "\(username): \(text)"
                            commentsStr += "\n------------------------\n"
                        })
                        self.commentsTextView.text = commentsStr
                    }
                })
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }
    
    @IBAction func addCommentPressed(_ sender: UIBarButtonItem) {
        
        if addCommentTextView.text.characters.count < 1 {
            return
        }
        
        let comment = PFObject(className: "Comment")
        comment["text"] = addCommentTextView.text
        comment["user"] = PFUser.current()
        comment["post"] = self.post
        sender.isEnabled = false
        self.addCommentTextView.text = ""
        comment.saveInBackground(block: { (success, error) in
            let rel = self.post!.relation(forKey: "comments")
            rel.add(comment)
            self.post!.saveInBackground(block: { (success, error) in
                self.configureView()
            })
        })
        
//        let myComment = PFObject(className: "Comment")
//        myComment["text"] = addCommentTextView.text
//        try! myComment.save()
//        var user = PFUser.current()
//        var relation = user?.relation(forKey: "comments")
//        relation?.add(myComment)
//        user?.saveInBackground()
        
        
        
    }
}

