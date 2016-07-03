//
//  ImageViewController.swift
//  Cassini
//
//  Created by Tom Yu on 6/19/16.
//  Copyright © 2016 kangleyu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    var imageUrl: NSURL? {
        didSet {
            image = nil;
            if view.window != nil {
                fetchImage();
            }
            
        }
    }
    
    private func fetchImage() {
        if let url = imageUrl {
            spinner?.startAnimating();
            // put retrieving intot the background threading
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                let contentsOfURL = NSData.init(contentsOfURL: url);
                dispatch_async(dispatch_get_main_queue()) {
                    if url == self.imageUrl {
                        if let imageData = contentsOfURL {
                            self.image = UIImage(data: imageData);
                        } else {
                            self.spinner?.stopAnimating();
                        }
                    } else {
                        print("ignored data returned from url \(url)");
                    }
                    
                }
            }
        }
    }
    
    @IBOutlet weak var scollView: UIScrollView! {
        didSet {
            scollView.contentSize = imageView.frame.size;
            scollView.delegate = self;
            scollView.minimumZoomScale = 0.03;
            scollView.maximumZoomScale = 1.0;
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    private var imageView = UIImageView();
    
    private var image: UIImage? {
        get {
            return imageView.image;
        }
        set {
            imageView.image = newValue;
            imageView.sizeToFit();
            scollView?.contentSize = imageView.frame.size;
            spinner?.stopAnimating();
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scollView?.addSubview(imageView);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        if image == nil {
            fetchImage();
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView;
    }

}
