//
//  CameraViewController.swift
//  Crisp
//
//  Created by Jayesh Kaushik on 10/22/17.
//  Copyright © 2017 Crisp. All rights reserved.
//
import AVFoundation
import UIKit

class CameraViewController: UIViewController {
    
    var session: AVCaptureSession?
    var stillImage: AVCapturePhotoOutput?
    var videoPreview: AVCaptureVideoPreviewLayer?
    var image: UIImage?
    var outputSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
    //var cameraView = NibView.initNib()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.subviews[0].backgroundColor = UIColor.brown
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        //self.videoPreview?.frame = self.cameraView.layer.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.session = AVCaptureSession()
        //Medium Quality
        self.session!.sessionPreset = AVCaptureSession.Preset.high
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInDualCamera, .builtInTelephotoCamera, .builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.back)
        
        let backCamera = AVCaptureDevice.default(for: .video)
        print(backCamera?.isConnected)
        var input: AVCaptureDeviceInput!
        var exception: NSError?
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error as NSError{
            exception = error
            print("Fatal Error: " + exception!.localizedDescription)
        }
        print("Added device")
        if (self.session!.canAddInput(input) && exception == nil) {
            session!.addInput(input)
            
        }
        
        self.stillImage = AVCapturePhotoOutput()
        
        if(self.session!.canAddOutput(self.stillImage!)) {
            self.session!.addOutput(self.stillImage!)
            //live preview
            videoPreview = AVCaptureVideoPreviewLayer(session: self.session!)
            videoPreview!.videoGravity = AVLayerVideoGravity.resizeAspect
            videoPreview!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            //self.cameraView.layer.addSublayer(self.videoPreview!)
            self.session!.startRunning()
            print("running stream:")
        }else {
            print("Nuh you stupid bruh")
        }
        

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


    

