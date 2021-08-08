//
//  UserSignVC.swift
//  Design-eKYC
//
//  Created by Mahdi Mahjoobi on 7/18/21.
//

import UIKit
import eKYC

class UserSignVC: UIViewController {
    
    var userSignView: UserSignView!
    var exportSignBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        userSignView = UserSignView()
        userSignView.delegate = self
        userSignView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userSignView)
        
        exportSignBtn = UIButton()
        exportSignBtn.translatesAutoresizingMaskIntoConstraints = false
        exportSignBtn.backgroundColor = .black
        exportSignBtn.setTitle("Export Sign", for: .normal)
        exportSignBtn.layer.cornerRadius = 10
        exportSignBtn.addTarget(self, action: #selector(start), for: .touchUpInside)
        view.addSubview(exportSignBtn)
        
        NSLayoutConstraint.activate([
            userSignView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            userSignView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userSignView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            userSignView.heightAnchor.constraint(equalToConstant: 700),
            
            exportSignBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            exportSignBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            exportSignBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            exportSignBtn.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    @objc private func start() {
        userSignView.capturePhoto()
    }

}

extension UserSignVC: UserSignDelegate {
    
    func sendBackUserSign(base64: String?, imageData: Data) {
        guard let signBase64 = base64 else {
            return
        }
        
        print("SignBase64: \(signBase64) imageData: \(imageData.count)")
    }
    
    func sendBackError(type: UserSignError) {
        
        switch type {
        case .CantExportSign, .CantConvertToData:
            break
        @unknown default:
            print("Unknown error for user sign")
        }
    }
    
}
