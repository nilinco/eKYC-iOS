//
//  FaceDetectionVC.swift
//  Design-eKYC
//
//  Created by Mahdi Mahjoobi on 7/14/21.
//

import UIKit
import eKYC

class FaceDetectionVC: UIViewController {

    var cameraView: FaceDetectionView!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        cameraView = FaceDetectionView()
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
            cameraView.heightAnchor.constraint(equalToConstant: 700),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            button.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    @objc private func start() {
        cameraView.startProcess()
    }

}

extension FaceDetectionVC: FaceDetectionDelegate {
    
    func sendBackUserStatus(result: FaceDetectionResults) {
        switch result {
        case .Completed:
            print("Completed")
        case .Failed:
            print("Failed")
        case .action(let step, let didCorrect):
            print("Step: \(step) status: \(didCorrect)")
        @unknown default:
            print("Unknown error for user actions on step")
        }
    }
    
    func sendBackError(type: FaceDetectionError) {
        switch type {
        case .CantCalculateChecksum, .CantConvertToData:
            break
        @unknown default:
            print("Unknown error for face angle detection")
        }
    }
    
    
}
