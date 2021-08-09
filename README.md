<div align="center" style="border-radius:25px" >
  <img width="600px" src="https://nilin.co/sdk/images/Shenas_Icon_Sharp_Blue_1024.png" alt="NiliN eKYC SDK" title="eKYC">
</div>

# eKYC SDK for iOS

Reimagine the way your users authenticate their information with eKYC iOS SDK.

eKYC is:

* **Secure.** Privacy first, always. Scanning works even if the user’s iPhone is in airplane mode, meaning personal information never touches a third-party server.
* **Intelligent.** Machine learning models, optimized to detect and authenticate user cards and face pose.  
* **Lightweight.** Designed to increase your app’s usability, not weight.  
* **What you make of it.** Customize and rebrand the default UI or leave it as it is. It’s up to you.
* **Fast.** Used bulit in apple ML engine.

# Table of contents

- [Requirements](#requirements)
- [Quick Start](#quick-start)
- [Additional info](#info)


# <a name="requirements"></a> Requirements

SDK package contains eKYC framework and one or more sample apps which demonstrate framework integration. The framework can be deployed in **iOS 12.0 or later**.

# <a name="quick-start"></a> Quick Start

## Getting started with eKYC SDK

This Quick Start guide will get you up and performing user authentication as quickly as possible. All steps described in this guide are required for the integration.

This guide closely follows the eKYC-Sample app in the Samples folder of this repository. We highly recommend you try to run the sample app. The sample app should compile and run on your device, and in the iOS Simulator.

The source code of the sample app can be used as the reference during the integration.

### 1. Initial integration steps

#### Using CocoaPods

- Project dependencies to be managed by CocoaPods are specified in a file called `Podfile`. Create this file in the same directory as your Xcode project (`.xcodeproj`) file.

- If you don't have podfile initialized run the following in your project directory.
```
pod init
```

- Copy and paste the following lines into the TextEdit window:

```ruby
platform :ios, '12.0'
target 'Your-App-Name' do
    pod 'NiliN-eKYC'
end
```

- Install the dependencies in your project:

```shell
$ pod install
```

- From now on, be sure to always open the generated Xcode workspace (`.xcworkspace`) instead of the project file when building your project:

```shell
open <YourProjectName>.xcworkspace
```

#### Using Swift Package Manager

eKYC SDK is available as [Swift Package](https://swift.org/package-manager/). Please check out [Swift Package Manager documentation](https://github.com/apple/swift-package-manager) if you are new to Swift Package Manager.

We provide a URL to the public package repository that you can add in Xcode:

```shell
https://github.com/nilinco/eKYC-Swift-Package
```

1. Select your project’s Swift Packages tab:
![Swift Package Project](https://nilin.co/sdk/images/SwiftPackage1.png)

2. Add the eKYC Swift package repository URL:
![Swift Package Repo](https://nilin.co/sdk/images/SwiftPackage2.png)

3. Choose Swift package version

**NOTE: There is a [known issue](https://bugs.swift.org/browse/SR-13343) in Xcode 12 that could cause crash running on real iOS device. Please follow instructions below for the workaround:**

1. Add a new copy files phase in your application’s Build Phase
2. Change the copy files phase’s destination to Frameworks
3. Add a new run script phase script to your app’s target
4. Add the following script to force deep sign the frameworks with your own signing identity:

```shell
find "${CODESIGNING_FOLDER_PATH}" -name '*.framework' -print0 | while read -d $'\0' framework 
do 
    codesign --force --deep --sign "${EXPANDED_CODE_SIGN_IDENTITY}" --preserve-metadata=identifier,entitlements --timestamp=none "${framework}" 
done
```

#### Manual integration

-[Download](https://github.com/nilinco/eKYC-iOS/releases) latest release Download .zip or .tar.gz file starting with eKYC.

OR

Clone this git repository:

- To clone, run the following shell command:

```shell
git clone git@github.com:nilinco/eKYC-iOS.git
```

- Copy eKYC.xcframework to your project folder.

- In your Xcode project, open the Project navigator. Drag the eKYC.xcframework file to your project, ideally in the Frameworks group, together with other frameworks you're using. When asked, choose "Create groups", instead of the "Create folder references" option.

![Adding eKYC.xcframework to your project](https://nilin.co/sdk/images/Manual.png)

- Since eKYC.xcframework is a dynamic framework, you also need to add it to embedded binaries section in General settings of your target and choose option `Embed & Sign`.

![Adding eKYC.xcframework to embedded binaries](https://nilin.co/sdk/images/AddedFrameworks.png)



### 2. Referencing header file

In files in which you want to use scanning functionality place import directive.

Swift

```swift
import eKYC
```

Objective-C

```objective-c
#import <eKYC/eKYC.h>
```

### 3. Initiating the scanning process

To initiate the scanning process, first decide where in your app you want to add scanning functionality. Usually, users of the scanning library have a button which, when tapped, starts the scanning process. Initialization code is then placed in touch handler for that button. Here we're listing the initialization code as it looks in a touch handler method.

Swift

```swift
import eKYC

class  CardDetectionVC: UIViewController {

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
        }
    }

}
```


### 4. License key

A valid license key is required to initalize scanning. You can generate a free trial license key, after you register, at [Contact us](https://nilin.co).

You can include the license key in your app by passing a string or a file with license key.
**Note** that you need to set the license key before intializing scanning. Ideally in `AppDelegate` or `viewDidLoad` before initializing any recognizers.

#### License key as string
You can pass the license key as a string, the following way:

Swift

```swift
eKYCManager.shared.setupKey(base64Key: "LICENSE-KEY")
```

If the licence is invalid or expired then the methods above will throw an **exception**.

# <a name="info"></a> Additional info

Complete API reference can be found [here](https://nilin.co). 

For any other questions, feel free to contact us at [info@nilin.co](info@nilin.co).
