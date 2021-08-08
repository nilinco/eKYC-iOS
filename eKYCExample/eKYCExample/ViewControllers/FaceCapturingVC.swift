//
//  FaceCapturingVC.swift
//  Design-eKYC
//
//  Created by Mahdi Mahjoobi on 7/19/21.
//

import UIKit
import eKYC

class FaceCapturingVC: UIViewController {
    
    var faceCapturingView: FaceCapturingView!
    var recordBtn: UIButton!
    var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        faceCapturingView = FaceCapturingView()
        faceCapturingView.translatesAutoresizingMaskIntoConstraints = false
        faceCapturingView.delegate = self
        faceCapturingView.waitingStatus = { [weak self] status in
            if status {
                self?.spinner.startAnimating()
            } else {
                self?.spinner.stopAnimating()
            }
        }
        view.addSubview(faceCapturingView)
        
        recordBtn = UIButton()
        recordBtn.translatesAutoresizingMaskIntoConstraints = false
        recordBtn.backgroundColor = .black
        recordBtn.setTitle("Test", for: .normal)
        recordBtn.layer.cornerRadius = 10
        recordBtn.addTarget(self, action: #selector(start), for: .touchUpInside)
        view.addSubview(recordBtn)
        
        // Activity Spinner
        spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            faceCapturingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            faceCapturingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            faceCapturingView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            faceCapturingView.heightAnchor.constraint(equalToConstant: 700),
            
            recordBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            recordBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            recordBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            recordBtn.heightAnchor.constraint(equalToConstant: 45),
            
            spinner.bottomAnchor.constraint(equalTo: recordBtn.topAnchor, constant: -15),
            spinner.centerXAnchor.constraint(equalTo: recordBtn.centerXAnchor)
        ])
    }
    
    @objc private func start() {
        faceCapturingView.recordVideo()
    }

}

extension FaceCapturingVC: FaceCapturingDelegate {
    
    func sendVideoURL(url: URL?, words: String?) {
        guard let url = url?.absoluteString, let words = words else {
            return
        }
        
        print("Video: \(url) words: \(words)")
    }
    
    func sendBackError(type: FaceCapturingError) {
        
        switch type {
        case .CantCompressVideo, .AudioOutputDosentWork, .FailedToRecordVideo, .VideoOutputDosentWork:
            break
        @unknown default:
            print("Unknown error for face capturing")
        }
    }

}
