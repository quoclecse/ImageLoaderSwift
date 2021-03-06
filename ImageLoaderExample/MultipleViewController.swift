//
//  MultipleViewController.swift
//  ImageLoaderSample
//
//  Created by Hirohisa Kawasaki on 10/24/14.
//  Copyright (c) 2014 Hirohisa Kawasaki. All rights reserved.
//

import UIKit
import ImageLoader

class MultipleViewController: UITableViewController {

    var timer: NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

    func reportMemory() {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        delegate.reportMemory()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MultipleViewController.reportMemory), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let URL = String.imageURL(indexPath.row)
        let placeholder = UIImage(named: "black.jpg")!
        cell.imageView?.load(URL, placeholder: placeholder) { URL, image, error, cacheType in
            print("URL \(URL)")
            print("error \(error)")
            print("view's size \(cell.imageView?.frame.size), image's size \(cell.imageView?.image?.size)")
        }

        return cell

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

}
