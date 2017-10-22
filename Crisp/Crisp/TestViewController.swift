//
//  TestViewController.swift
//  Crisp
//
//  Created by Jayesh Kaushik on 10/22/17.
//  Copyright © 2017 Crisp. All rights reserved.
//
import AVFoundation
import UIKit



class TestViewController: UIViewController {
    @IBOutlet weak var cameraView: UIView!
    var session: AVCaptureSession?
    var stillImage: AVCapturePhotoOutput?
    var videoPreview: AVCaptureVideoPreviewLayer?
    var image: UIImage?
    var outputSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        self.videoPreview?.frame = self.cameraView.bounds

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
        self.stillImage?.setPreparedPhotoSettingsArray([self.outputSettings], completionHandler: nil)
        
        if(self.session!.canAddOutput(self.stillImage!)) {
            self.session!.addOutput(self.stillImage!)
            //live preview
            videoPreview = AVCaptureVideoPreviewLayer(session: self.session!)
            videoPreview!.videoGravity = AVLayerVideoGravity.resizeAspect
            videoPreview!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
            self.cameraView.layer.addSublayer(self.videoPreview!)
            self.session!.startRunning()
            print("running stream:")
        }else {
            print("Nuh you stupid bruh")
        }
        
    }

    @IBAction func screenTap(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        stillImage?.capturePhoto(with: settings, delegate: self)
//        if let connection = self.stillImage?.connection(with: AVMediaType.video) {
//            self.stillImage!.capturePhoto(with: self.outputSettings, delegate: self)
//            print("Image Captured")
        
        //}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "captureToPhoto" {
            var previewVC = segue.destination as! CaptureViewController
            previewVC.image = self.image
        }
    }

}


extension TestViewController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageFile = photo.fileDataRepresentation() {
            print(imageFile)
            self.image = UIImage(data: imageFile)
            print(self.image == nil)
            self.performSegue(withIdentifier: "captureToPhoto", sender: self)
            
        }
    }
}

