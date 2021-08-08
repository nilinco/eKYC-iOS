//
//  CardDetectionVC.swift
//  Design-eKYC
//
//  Created by Mahdi Mahjoobi on 7/11/21.
//

import UIKit
import eKYC

class CardDetectionVC: UIViewController {

    var cameraView: CardDetectionView!
    var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        cameraView = CardDetectionView()
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        cameraView.delegate = self
        view.addSubview(cameraView)
        
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Test", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(start), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            cameraView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cameraView.heightAnchor.constraint(equalToConstant: 350),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 45),
        ])
    }


    @objc private func start() {
        cameraView.capturePhoto()
    }
}

extension CardDetectionVC: CameraDetectionDelegate {
    
    func detectCardInfo(frontSide: CroppedCard, backSide: CroppedCard) {
        guard let front = frontSide.imageData, let back = backSide.imageData else {
            return
        }
        
        print("First: \(front.count) Second: \(back.count)")
    }
    
    
    func sendBackError(type: CardDetectionError) {
        switch type {
        case .CantCalculateChecksum, .CantConvertImageToData, .CantPrepareCamera:
            break
        @unknown default:
            print("Unknown error for card detection")
        }
    }
    
    
}

