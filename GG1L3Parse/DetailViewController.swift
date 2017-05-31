//
//  DetailViewController.swift
//  GG1L3Parse
//
//  Created by Ivan Vasilevich on 5/11/17.
//  Copyright © 2017 Smoosh Labs. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var imageBox: UIImageView!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var addCommentTextView: UITextView!
    
    var post: Post? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = post {
            if let label = detailDescriptionLabel {
                label.text = detail.text
                if let data = detail.photo {
                    imageBox.image = UIImage(data: data as Data)
                }
                let commentsRelation = post?.comments
                let comments = commentsRelation?.sorted(by: { (c1, c2) -> Bool in
                    return c1.createdAt?.timeIntervalSince1970 ?? 0 < c2.createdAt?.timeIntervalSince1970 ?? 0
                })
                var commentsStr = ""
                comments!.forEach({ (comment) in
                    commentsStr += "------------------------\n"
                    let text = comment.text ?? "no text"
                    let username = comment.user?.username ?? "none"
                    commentsStr += "\(username): \(text)"
                    commentsStr += "\n------------------------\n"
                })
                self.commentsTextView.text = commentsStr
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
        
        let comment = Comment(context: dbContext)
        comment.text = addCommentTextView.text
        comment.createdAt = Date() as NSDate
        comment.user = appDel.currentUser
        //                comment.pos = self.post
        //                sender.isEnabled = false
        self.addCommentTextView.text = ""
        post?.addToComments(comment)
        try! dbContext.save()
        self.configureView()
        
        
    }
}

