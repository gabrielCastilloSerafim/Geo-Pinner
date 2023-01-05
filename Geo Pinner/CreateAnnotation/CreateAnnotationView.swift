//
//  CreateAnnotationView.swift
//  Geo Pinner
//
//  Created by Gabriel Castillo Serafim on 4/1/23.
//  
//

import Foundation
import UIKit
import MapKit

class CreateAnnotationView: UIViewController {

    // MARK: Properties
    var presenter: CreateAnnotationPresenterProtocol?
    private let latitudeLabel = UILabel()
    private let longitudeLabel = UILabel()
    private let latitudeLabelValue = UILabel()
    private let longitudeLabelValue = UILabel()
    private let titleTextField = UITextField()
    private let descriptionTextFieldView = UIView()
    private let descriptionTextField = UITextView()
    private let addAnnotationButton = UIButton()
    private let compassTextField = UITextField()
    private let noTitleAlert = UIAlertController(title: "Oops!", message: "To add a new annotation you must give it a title.", preferredStyle: .alert)

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        presenter?.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.addSubview(latitudeLabel)
        view.addSubview(longitudeLabel)
        view.addSubview(latitudeLabelValue)
        view.addSubview(longitudeLabelValue)
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextFieldView)
        descriptionTextFieldView.addSubview(descriptionTextField)
        view.addSubview(addAnnotationButton)
        view.addSubview(compassTextField)
        
        latitudeLabel.text = "Lat:"
        latitudeLabel.textColor = .systemGray
        latitudeLabel.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        latitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            latitudeLabel.widthAnchor.constraint(equalToConstant: 40),
            latitudeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            latitudeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        longitudeLabel.text = "Long:"
        longitudeLabel.textColor = .systemGray
        longitudeLabel.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        longitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            longitudeLabel.widthAnchor.constraint(equalToConstant: 55),
            longitudeLabel.topAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: 7),
            longitudeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
        
        latitudeLabelValue.textColor = .systemGray
        latitudeLabelValue.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        latitudeLabelValue.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            latitudeLabelValue.centerYAnchor.constraint(equalTo: latitudeLabel.centerYAnchor),
            latitudeLabelValue.leadingAnchor.constraint(equalTo: latitudeLabel.trailingAnchor, constant: 5),
            latitudeLabelValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
        
        longitudeLabelValue.textColor = .systemGray
        longitudeLabelValue.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        longitudeLabelValue.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            longitudeLabelValue.centerYAnchor.constraint(equalTo: longitudeLabel.centerYAnchor),
            longitudeLabelValue.leadingAnchor.constraint(equalTo: longitudeLabel.trailingAnchor, constant: 5),
            longitudeLabelValue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
        
        titleTextField.placeholder = "Title:"
        titleTextField.setLeftPaddingPoints(15)
        titleTextField.backgroundColor = .systemGray5
        titleTextField.layer.cornerRadius = 26
        titleTextField.layer.masksToBounds = true
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 52),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            titleTextField.topAnchor.constraint(equalTo: longitudeLabel.bottomAnchor, constant: 20)
        ])
        
        descriptionTextFieldView.backgroundColor = .systemGray5
        descriptionTextFieldView.layer.cornerRadius = 26
        descriptionTextFieldView.layer.masksToBounds = true
        descriptionTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextFieldView.heightAnchor.constraint(equalToConstant: 150),
            descriptionTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            descriptionTextFieldView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20)
        ])
        
        descriptionTextField.textColor = .placeholderText
        descriptionTextField.text = "Description:"
        descriptionTextField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        descriptionTextField.backgroundColor = .systemGray5
        descriptionTextField.delegate = self
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextField.leadingAnchor.constraint(equalTo: descriptionTextFieldView.leadingAnchor, constant: 10),
            descriptionTextField.trailingAnchor.constraint(equalTo: descriptionTextFieldView.trailingAnchor, constant: -10),
            descriptionTextField.topAnchor.constraint(equalTo: descriptionTextFieldView.topAnchor, constant: 10),
            descriptionTextField.bottomAnchor.constraint(equalTo: descriptionTextFieldView.bottomAnchor, constant: -10)
        ])

        addAnnotationButton.backgroundColor = .systemGreen
        addAnnotationButton.setTitle("Add annotation", for: .normal)
        addAnnotationButton.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        addAnnotationButton.titleLabel?.textColor = .white
        addAnnotationButton.layer.cornerRadius = 25
        addAnnotationButton.layer.masksToBounds = true
        addAnnotationButton.translatesAutoresizingMaskIntoConstraints = false
        addAnnotationButton.addTarget(self, action: #selector(addAnnotationButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            addAnnotationButton.heightAnchor.constraint(equalToConstant: 52),
            addAnnotationButton.topAnchor.constraint(equalTo: descriptionTextFieldView.bottomAnchor, constant: 20),
            addAnnotationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            addAnnotationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        compassTextField.text = "🧭"
        compassTextField.font = UIFont.systemFont(ofSize: 35)
        compassTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            compassTextField.centerYAnchor.constraint(equalTo: latitudeLabel.bottomAnchor, constant: 6),
            compassTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        noTitleAlert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
    }
    
    @objc func addAnnotationButtonTapped() {
        presenter?.addAnnotationButtonTapped(title: titleTextField.text, description: descriptionTextField.text)
    }
    
    
}

extension CreateAnnotationView: UITextViewDelegate {
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        presenter?.textViewDidBeginEditing(currentTextColor: textView.textColor!)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter?.textViewEndBeginEditing(textFieldText: textView.text)
    }
}

extension CreateAnnotationView: CreateAnnotationViewProtocol {
    // TODO: implement view output methods
    
    func setLatitudeAndLongitudeValues(annotation: MKAnnotation?) {
        DispatchQueue.main.async {
            guard let safeAnnotation = annotation else { print("Failled to get annotation"); return }
            self.latitudeLabelValue.text = String(safeAnnotation.coordinate.latitude)
            self.longitudeLabelValue.text = String(safeAnnotation.coordinate.longitude)
        }
    }
    
    func changeDescriptionText(newText: String?) {
        DispatchQueue.main.async {
            self.descriptionTextField.text = newText
        }
    }
    
    func changeDescriptionTextColor(color: UIColor) {
        DispatchQueue.main.async {
            self.descriptionTextField.textColor = color
        }
    }
    
    func showNoTitleAlert() {
        self.present(noTitleAlert, animated: true)
    }
    
}
