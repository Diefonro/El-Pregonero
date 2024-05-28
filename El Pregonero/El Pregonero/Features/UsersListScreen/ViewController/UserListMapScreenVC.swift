//
//  UserListMapScreenVC.swift
//  El Pregonero
//
//  Created by Andrés Fonseca on 28/05/2024.
//

import UIKit
import MapKit

class UserListMapScreenVC: UIViewController, StoryboardInfo {
    
    static var storyboard = "UsersListMapScreen"
    static var identifier = "UserListMapScreenVC"
    
    @IBOutlet weak var mapView: MKMapView!
    
    var data: User?
    var showAllUsers = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "User's Map"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
        if showAllUsers {
            addAllUsersToMap()
        } else if let data = data {
            centerMapOnUserLocation(user: data)
            addUserToMap(user: data)
        }
    }
    
    func centerMapOnUserLocation(user: User) {
        guard let latitude = Double(user.address.geo.lat),
              let longitude = Double(user.address.geo.lng) else {
            return
        }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    func addUserToMap(user: User) {
        guard let latitude = Double(user.address.geo.lat),
              let longitude = Double(user.address.geo.lng) else {
            return
        }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.title = user.firstname
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    func addAllUsersToMap() {
        let allUsers = DataManager.usersData
        var annotations: [MKPointAnnotation] = []
        
        for user in allUsers {
            guard let latitude = Double(user.address.geo.lat),
                  let longitude = Double(user.address.geo.lng) else {
                continue
            }
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.title = user.firstname
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        
        mapView.addAnnotations(annotations)
        
        if let firstCoordinate = annotations.first?.coordinate {
            let region = MKCoordinateRegion(center: firstCoordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension UserListMapScreenVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "UserLocation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
