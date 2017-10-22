//
//  ViewController.swift
//  Crisp
//
//  Created by Dahae Cheong on 10/21/17.
//  Copyright © 2017 Crisp. All rights reserved.
//
import AVFoundation
import UIKit

class ViewController: UIViewController {
    //@IBOutlet weak var cameraView: UIView!
    //@IBOutlet weak var captureButtonOutlet: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var session: AVCaptureSession?
    var stillImage: AVCapturePhotoOutput?
    var videoPreview: AVCaptureVideoPreviewLayer?
    var image: UIImage?
    var outputSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Running")
        var v1 = CameraViewController(nibName: "CameraViewController", bundle: nil)
        var v2 = ListViewViewController(nibName: "ListViewViewController", bundle: nil)
        self.addChildViewController(v1)
        self.scrollView.addSubview(v1.view)
        v1.didMove(toParentViewController: self)
        
        self.addChildViewController(v2)
        self.scrollView.addSubview(v2.view)
        v2.didMove(toParentViewController: self)


        
        var v2Frame : CGRect = v2.view.frame
        v2Frame.origin.x = self.view.frame.width
        v2.view.frame = v2Frame
        
    
        
        
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 2, height:self.view.frame.size.height)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //self.videoPreview?.frame = self.cameraView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.session = AVCaptureSession()
//        //Medium Quality
//        self.session!.sessionPreset = AVCaptureSession.Preset.high
//        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInDualCamera, .builtInTelephotoCamera, .builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.back)
//
//        let backCamera = AVCaptureDevice.default(for: .video)
//        print(backCamera?.isConnected)
//        var input: AVCaptureDeviceInput!
//        var exception: NSError?
//        do {
//            input = try AVCaptureDeviceInput(device: backCamera!)
//        } catch let error as NSError{
//            exception = error
//            print("Fatal Error: " + exception!.localizedDescription)
//        }
//        print("Added device")
//        if (self.session!.canAddInput(input) && exception == nil) {
//            session!.addInput(input)
//
//        }
//
//        self.stillImage = AVCapturePhotoOutput()
//
//        if(self.session!.canAddOutput(self.stillImage!)) {
//            self.session!.addOutput(self.stillImage!)
//            //live preview
//            videoPreview = AVCaptureVideoPreviewLayer(session: self.session!)
//            videoPreview!.videoGravity = AVLayerVideoGravity.resizeAspect
//            videoPreview!.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
//            //self.cameraView.layer.addSublayer(self.videoPreview!)
//            self.session!.startRunning()
//            print("running stream:")
//        }else {
//                print("Nuh you stupid bruh")
//        }
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //change to tap
//    @IBAction func captureButtonPressed(_ sender: Any) {
//        if let connection = self.stillImage?.connection(with: AVMediaType.video) {
//            self.stillImage!.capturePhoto(with: self.outputSettings, delegate: self)
//        }
//    }
//
//    @IBAction func toListOfFood(_ sender: Any) {
//    }
}

extension ViewController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageFile = photo.fileDataRepresentation() {
            print(imageFile)
            self.image = UIImage(data: imageFile)
        }
    }
}
