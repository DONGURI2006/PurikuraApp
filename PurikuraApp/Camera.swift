//
//  Camera.swift
//  PurikuraApp
//
//  Created by 平井　登惟 on 2026/07/05.
//

import UIKit
import AVFoundation


class CameraController: UIViewController, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var CameraView: UIView!
    
    @IBOutlet weak var CountNumber: UILabel!
    
    let captureSession = AVCaptureSession()
    let photoOutput = AVCapturePhotoOutput()
    
    var Images: [UIImage] = []
    var PictureCount = 0
    var CountTimer: Timer?
    var TimeCount = 5
    var TimeOut:Bool = true

    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        super.viewDidLoad()
        self.CountNumber.text = ""
        setupCamera()
        
        if self.CountTimer != nil {
            return
        }
    
        self.StartCountDown()
    }
    
    
        //カメラのセットアップ
        func setupCamera() {

            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.startCamera()
                    }
                } else {
                    print("カメラの使用が許可されていません")
                }
            }
        }
        
    //カメラの撮影
        func startCamera() {
            self.captureSession.beginConfiguration()
            
            guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera,for: .video,position: .front)
                    
            else {
                return
            }

            do {
                let input = try AVCaptureDeviceInput(device: camera)

                if self.captureSession.canAddInput(input) {
                    self.captureSession.addInput(input)
                }

                if self.captureSession.canAddOutput(photoOutput) {
                    self.captureSession.addOutput(photoOutput)
                }

            } catch {
                return
            }
            
            self.captureSession.commitConfiguration()
            
            self.previewLayer = AVCaptureVideoPreviewLayer(
                session: self.captureSession
            )
            
            self.previewLayer.videoGravity = .resizeAspectFill
            self.previewLayer.frame = self.CameraView.bounds
            self.CameraView.layer.addSublayer(self.previewLayer)

            DispatchQueue.global(qos: .userInitiated).async {
                self.captureSession.startRunning()
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ImageGO" {
            
            if let Img = segue.destination as? ImageController {
                
                Img.Images = self.Images
                Img.PictureCount = self.PictureCount
                
            }
        }
    }
    
    func StartCountDown(){
        self.CountTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in

            
            self.CountNumber.text = String(self.TimeCount)
            
            self.TimeCount -= 1
            
            if(self.TimeCount < 0){
                self.CountTimer?.invalidate()
                self.CountTimer = nil
                
                self.CountNumber.text = ""
                
                self.TimeCount = 5
                
                let settings = AVCapturePhotoSettings()
                
                self.photoOutput.capturePhoto(with: settings,delegate: self)
                
            }
        }
    }
        

        func photoOutput(_ output: AVCapturePhotoOutput,didFinishProcessingPhoto photo: AVCapturePhoto,error: Error?)
        {

            if let error = error {

                return
            }

            guard let imageData = photo.fileDataRepresentation(),
                let image = UIImage(data: imageData)
            else {
                print("画像を取得できませんでした")
                return
            }
            self.Images.append(image)
            
            self.PictureCount += 1
            
            if self.PictureCount >= 3 {

                performSegue(withIdentifier: "ImageGO",sender: nil)
            } else {

                StartCountDown()
            }
            
    }

}
