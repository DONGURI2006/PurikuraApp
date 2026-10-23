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
    var Odai = ["ハートのポーズを作ってね","ライオンのがおーポーズ","うさぎさんのお耳ポーズ","ピースで猫耳！","かわいくあごに手を当てて","腕をのばしてダブルピース"]
    var PhotoCount = 0
    var PictureCount = 0
    var CountTimer: Timer?
    var TimeCount = 8
    var TimeOut:Bool = true
    var SerectNumber = 0
    var SerectImg = ""
    
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        super.viewDidLoad()
        self.Odai.shuffle()
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
                Img.SerectNumber = self.SerectNumber
                Img.SerectImg = self.SerectImg
                
            }
        }
    }
    
    func StartCountDown(){
        
        
        self.CountTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in

            
            
            if(self.TimeCount < 6){
                self.CountNumber.text = String(self.TimeCount)
                self.CountNumber.font = UIFont(name: "ZenMaruGothic-Black", size: 300)
                let attributes: [NSAttributedString.Key: Any] = [.strokeColor: UIColor.white,.strokeWidth: -6.0,.foregroundColor: UIColor(_colorLiteralRed: 191/255, green: 45/255, blue: 142/255, alpha: 1.0)]

                self.CountNumber.attributedText = NSAttributedString(string: self.CountNumber.text ?? "",attributes: attributes)
                
                
            }else{
                self.CountNumber.text = self.Odai[self.PhotoCount]
                self.CountNumber.font = UIFont(name: "ZenMaruGothic-Black", size: 64)
                
                let attributes: [NSAttributedString.Key: Any] = [.strokeColor: UIColor.white,.strokeWidth: -2.0,.foregroundColor: UIColor(_colorLiteralRed: 191/255, green: 45/255, blue: 142/255, alpha: 1.0)]
                self.CountNumber.attributedText = NSAttributedString(string: self.CountNumber.text ?? "",attributes: attributes)
                
                
            }
            
            self.TimeCount -= 1
            
            if(self.TimeCount < 0){
                self.CountTimer?.invalidate()
                self.CountTimer = nil
                
                self.CountNumber.text = ""
                
                self.TimeCount = 8
                self.PhotoCount += 1
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
            
            if self.PictureCount >= self.SerectNumber {

                performSegue(withIdentifier: "ImageGO",sender: nil)
            } else {

                StartCountDown()
            }
            
    }

}
