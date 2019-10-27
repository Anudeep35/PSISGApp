//
//  ViewController.swift
//  PSISGApp
//
//  Created by Anudeep Gone on 27/10/19.
//  Copyright © 2019 Anudeep. All rights reserved.
//

import UIKit
import MapKit

class PSIMapViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var viewModel: MapViewModel = {
        return MapViewModel(apiService: APIService())
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        initViewModel()
        viewModel.initFetchPSI()
    }
    
    func initView() {
        self.title = "PSI"
    }
    
    func initViewModel() {
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.startAnimating()
                }else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.showAlert = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        viewModel.loadMapPins = { [weak self] () in
            DispatchQueue.main.async {
                self?.loadMapPins()
            }
        }
    }
    
    func loadMapPins() {
        for i in 0..<viewModel.numberOfAnnotations {
            let annotation = PSIAnnotation(psi: viewModel.getPSIData(at: i))
            self.mapView.addAnnotation(annotation)
        }
    }

}

extension PSIMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView: PSIAnnotationView!
        
        guard let annotation = annotation as? PSIAnnotation else {
            return nil
        }
        
        annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "marker") as? PSIAnnotationView
        if annotationView == nil {
            annotationView = PSIAnnotationView.init(annotation: annotation, reuseIdentifier: "marker")
            annotationView.canShowCallout = true
        }
        annotationView.subtitleLabel.text = annotation.subtitle
        annotationView.detailCalloutAccessoryView = annotationView.subtitleLabel
        return annotationView
    }
    
}

