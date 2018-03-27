//
//  FeedDetailCell.swift
//  Mabius
//
//  Created by spens on 17/07/16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

import UIKit
import MapKit
import TagListView

protocol FeedDetailCellDelegate: class {
    func tagsExpanded()
}

class FeedDetailCell: UITableViewCell, ReuseId {
    
    @IBOutlet weak var tagListView: PointTagListView?
    @IBOutlet weak var projectTitle: FeedTitleLabel?
    @IBOutlet weak var projectImage: UIImageView?
    @IBOutlet weak var projectLabel: UILabel?
    @IBOutlet weak var showAllButton: UIButton?
    @IBOutlet weak var categoryTagListView: PointTagListView!
    
    weak var delegate: FeedDetailCellDelegate?
    
    var point: Point? {
        didSet {
            if let title = projectTitle { title.text = point?.title }
            if let proj = point?.project {
                projectImage?.image = getLogoFor(project: proj.lowercased())
                
                if proj == "enactus" {
                    projectImage?.contentMode = .scaleAspectFill
                } else {
                    projectImage?.contentMode = .scaleAspectFit
                }
            }
            
            if let type = point?.type { projectLabel?.text = getProjectTitle(for: type.lowercased()) }
            
            tagListView?.removeAllTags()
            categoryTagListView.removeAllTags()
            
            if let categoriesIds = point?.categories, let subcategoriesIds = point?.subCategories {
                
                let categories = CategoriesProvider.instance.getCategories(by: categoriesIds)
                let subcategories = CategoriesProvider.instance.getSubcategories(by: subcategoriesIds)
                
                for category in categories {
                    if let title = category.title {
                        categoryTagListView.addTag(title)
                        categoryTagListView.tagViews.last?.isSelected = true
                    }
                }
                
                for subcategory in subcategories.prefix(1) { if let title = subcategory.title { tagListView?.addTag(title) } }
                
                if subcategories.count <= 1 {
                    showAllButton!.isEnabled = false
                    showAllButton?.alpha = 0.5
                }
                showAllButton!.isHidden = false
            }
        }
    }
    
    @IBAction func showAllTagsButtonHandler(_ sender: AnyObject) {
        
        tagListView?.removeAllTags()
        categoryTagListView.removeAllTags()
        
        if let categoriesIds = point?.categories, let subcategoriesIds = point?.subCategories {
            
            let categories = CategoriesProvider.instance.getCategories(by: categoriesIds)
            let subcategories = CategoriesProvider.instance.getSubcategories(by: subcategoriesIds)
            
            for category in categories {
                if let title = category.title {
                    categoryTagListView.addTag(title)
                    categoryTagListView.tagViews.last?.isSelected = true
                }
            }
            
            for subcategory in subcategories { if let title = subcategory.title { tagListView?.addTag(title) } }
        }
        
        showAllButton!.isHidden = true
        self.layoutIfNeeded()
        delegate?.tagsExpanded()
    }
}

class FeedDetailCellImages: UITableViewCell, ReuseId, UIScrollViewDelegate {
    
    @IBOutlet weak var pager: UIPageControl?
    @IBOutlet weak var photoContainer: UIView?
    @IBOutlet weak var photoContainerWidth: NSLayoutConstraint?
    
    var point: Point! {
        didSet {
            
            if let container = photoContainer, let images = point.images {
                
                pager?.numberOfPages = images.count
                
                for i in 0..<images.count {
                    let imageView = UIImageView(frame: CGRect(x: CGFloat(i) * UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: container.frame.height))
                    imageView.clipsToBounds = true
                    imageView.contentMode = .scaleAspectFill
                    ImageFetcher.fetch(images[i], to: imageView)

                    container.addSubview(imageView)
                }
                if let width = photoContainerWidth { width.constant = CGFloat(images.count) * UIScreen.main.bounds.width }
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        pager?.currentPage = Int(page)
    }
}

protocol FeedDetailCellDescriptionDelegate: class {
    func openPointOwner(with id: Int)
}

class FeedDetailCellDescription: UITableViewCell, ReuseId, MKMapViewDelegate {
    
    @IBOutlet weak var author: TitleLabel?
    @IBOutlet weak var authorAvatar: UIImageView?
    @IBOutlet weak var date: UILabel?
    @IBOutlet weak var mapView: MKMapView?
    @IBOutlet weak var descriptionLabel: UILabel?
    
    weak var delegate: FeedDetailCellDescriptionDelegate?
    
    override func awakeFromNib() {
        mapView?.delegate = self

        if let img = authorAvatar {
            img.clipsToBounds = true
            img.layer.cornerRadius = img.bounds.height / 2
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin") ?? MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.annotation = annotation
        annotationView.image = UIImage(named: "icPinRed")
        
        return annotationView
    }
    
    var user: User? {
        didSet {
            if let name = user?.name, let lastName = user?.secondName { author?.text = "\(name) \(lastName)" } else { author?.text = nil }
            if let avatar = authorAvatar { ImageFetcher.fetch(user?.avatarUrl, to: avatar, placeholder: #imageLiteral(resourceName: "imgProfile")) }
        }
    }
    
    var point: Point? {
        didSet {
            let annotation = MKPointAnnotation()
            if let p = point, let lat = p.location?.lat, let lon = p.location?.lon { annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon) }
            if let p = point, let descr = p.description { descriptionLabel?.text = descr } else { descriptionLabel?.text = "" }
            if let p = point, let dateTime = p.createdAt { date?.text = TimeInterval(dateTime * 1000).timeAgo() } else { date?.text = "" }
            
            if let mapView = mapView {
                mapView.addAnnotation(annotation)
                mapView.setRegion(MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)), animated: false)
            }
        }
    }
    
    @IBAction func authorButtonHandler(_ sender: AnyObject) {
        if let id = user?.id { delegate?.openPointOwner(with: id) }
    }
}

protocol FeedDetailCellFavoritesDelegate: class {
    func toggleLike(for point: Point)
    func openLikes(for pointId: Int)
}

class FeedDetailCellFavorites: UITableViewCell, ReuseId {
    
    @IBOutlet weak var favoriteButton: UIButton?
    @IBOutlet weak var favoritesCount: UILabel?
    @IBOutlet weak var commentsCount: UILabel?
    
    weak var delegate: FeedDetailCellFavoritesDelegate?
    
    var point: Point? {
        didSet {
            if let comments = point?.comments {
				commentsCount?.text = "feedDetails.comments".localize(dictionary: ["count" : "\(comments)"])
			} else {
				commentsCount?.text = "feedDetails.comments".localize(dictionary: ["count" : "0"])
			}
            if let likes = point?.likes { favoritesCount?.text = String(likes) } else { favoritesCount?.text = String(0) }
            favoriteButton?.isSelected = point?.isLiked ?? false
        }
    }
    
    @IBAction func favoriteButtonHandler(_ sender: AnyObject) {
        if let p = point { delegate?.toggleLike(for: p) }
    }
    
    @IBAction func likesCountButtonHandler(_ sender: AnyObject) {
        if let id = point?.id, let likes = point?.likes, likes > 0 { delegate?.openLikes(for: id) }
    }
}
