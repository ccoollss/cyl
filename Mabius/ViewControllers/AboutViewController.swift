//
//  AboutViewController.swift
//  Mabius
//
//  Created by Andrey Toropchin on 11.07.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import SafariServices

class AboutViewController: BaseViewController, UITableViewDataSource
{
    @IBOutlet weak var tableView: BorderedTableView!

    var categories = [InfoCategory]()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        stubData()
    }

    func stubData() {
        let aboutCategory = InfoCategory()
        aboutCategory.title = "about.app".localize()
        aboutCategory.text = aboutCategory.title
        aboutCategory.url = "http://cyl.me"
        categories.append(aboutCategory)

        let legalCategory = InfoCategory()
        legalCategory.title = "about.legal".localize()
        legalCategory.text = legalCategory.title
        legalCategory.url = "http://files.meallions.show/user_agreement_application_meallions.pdf"
        categories.append(legalCategory)

        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell") as! AboutCell
        cell.infoCategory = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            UIApplication.openUrl("cyl://AboutAppViewController")
        } else {
            let urlString = "http://files.meallions.show/user_agreement_application_meallions.pdf"
            
            if let url = URL(string: urlString) {
                let svc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                present(svc, animated: true)
            }
        }
    }
}
