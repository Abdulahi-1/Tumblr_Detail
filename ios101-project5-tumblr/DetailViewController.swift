//
//  DetailViewController.swift
//  ios101-project5-tumblr
//
//  Created by Abdulahi Abdi on 7/22/25.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {

    var post: Post?

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var captionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let post = post {
            captionTextView.text = post.caption
            captionTextView.isEditable = false

            if let photo = post.photos.first {
                Nuke.ImagePipeline.shared.loadImage(with: photo.originalSize.url) { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.imageView.image = response.image
                        }
                    case .failure(let error):
                        print("Image loading error: \(error)")
                    }
                }
            }
        }
    }
}


