//
//  CameraControllerExtension.swift
//  MockUpUI
//
//  Created by Phil Martin on 10/07/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import UIKit
import AVFoundation

extension CameraController: AVCapturePhotoCaptureDelegate {
    
    func prepare(completionHandler: @escaping (Error?) -> Void) {
       
        // prepare queue and async load the functions helps with checking camera
        DispatchQueue(label: "prepare").async { [weak self] in
            
            if let weakSelf = self{
                // load all our functions
                do {
                    weakSelf.createCaptureSession()
                    try weakSelf.configureCaptureDevices()
                    try weakSelf.configureDeviceInputs()
                    try weakSelf.configurePhotoOutput()
                }
                    
                catch {
                    DispatchQueue.main.async {
                        completionHandler(error)
                    }
                    
                    return
                }
                
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
            
          
        }
    }
    
    func createCaptureSession() {
        // create a session
        self.captureSession = AVCaptureSession()
    }
    
    func configureCaptureDevices() throws {
        // get our reccording session
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .unspecified)
        // get all our cameras
        let cameras = session.devices.compactMap { $0 }
        // check to see if the camera is empty e.g a user said no to sharing camera
        guard !cameras.isEmpty else { throw CameraControllerError.noCamerasAvailable }
        
        // loop through all out cameras
        for camera in cameras {
            if camera.position == .front {
                self.frontCamera = camera
            }
            
            // setup the camera with focus etc etc
            if camera.position == .back {
                self.rearCamera = camera
                
                try camera.lockForConfiguration()
                camera.focusMode = .continuousAutoFocus
                camera.unlockForConfiguration()
            }
        }
    }
    
    func configureDeviceInputs() throws {
        
        guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
        
        // check our rear camera and unwrap
        if let rearCamera = self.rearCamera {
            self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
            // add an input capture session
            if captureSession.canAddInput(self.rearCameraInput!) { captureSession.addInput(self.rearCameraInput!) }
            // set our camera position
            self.currentCameraPosition = .rear
        }else if let frontCamera = self.frontCamera { // handle the fron camera
            self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
            
            // add the input
            if captureSession.canAddInput(self.frontCameraInput!) { captureSession.addInput(self.frontCameraInput!) }
            else { throw CameraControllerError.inputsAreInvalid }
            // set the camera to the fron
            self.currentCameraPosition = .front
        }
            // if no cameras are available the throw us out :)
        else { throw CameraControllerError.noCamerasAvailable }
    }
    
    func configurePhotoOutput() throws {
        // get our capture session
        guard let captureSession = self.captureSession else { throw CameraControllerError.captureSessionIsMissing }
        
        // init out output
        self.photoOutput = AVCapturePhotoOutput()
        // set the prepared settings
        self.photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
        
        // add to the output
        if captureSession.canAddOutput(self.photoOutput!) { captureSession.addOutput(self.photoOutput!) }
        captureSession.startRunning()
    }
    
    
    
    func displayPreview(on view: UIView) throws {
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.previewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.previewLayer?.connection?.videoOrientation = .portrait
        
        view.layer.insertSublayer(self.previewLayer!, at: 0)
        self.previewLayer?.frame = view.frame
    }
    
    func switchCameras() throws {
        
        // get our current camera pos front or rear
        guard let currentCameraPosition = currentCameraPosition, let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        
        // begin the config
        captureSession.beginConfiguration()
        // check the current position in this switch
        switch currentCameraPosition {
        case .front:
            try switchToRearCamera()
            
        case .rear:
            try switchToFrontCamera()
        }
        
        captureSession.commitConfiguration()
    }
    
    func switchToFrontCamera() throws {
        // get our current camera pos front or rear
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        guard let rearCameraInput = self.rearCameraInput, captureSession.inputs.contains(rearCameraInput),
            let frontCamera = self.frontCamera else { throw CameraControllerError.invalidOperation }
        
        self.frontCameraInput = try AVCaptureDeviceInput(device: frontCamera)
        // when we switch the input remove the previous camera position and set out new one
        captureSession.removeInput(rearCameraInput)
        
        if captureSession.canAddInput(self.frontCameraInput!) {
            captureSession.addInput(self.frontCameraInput!)
            
            self.currentCameraPosition = .front
        }
            
        else {
            throw CameraControllerError.invalidOperation
        }
    }
    
    func switchToRearCamera() throws {
        // get capture session and check we are running
        
        guard let captureSession = self.captureSession, captureSession.isRunning else { throw CameraControllerError.captureSessionIsMissing }
        guard let frontCameraInput = self.frontCameraInput, captureSession.inputs.contains(frontCameraInput),
            let rearCamera = self.rearCamera else { throw CameraControllerError.invalidOperation }
        
        self.rearCameraInput = try AVCaptureDeviceInput(device: rearCamera)
        
        captureSession.removeInput(frontCameraInput)
        // add the input if we can
        if captureSession.canAddInput(self.rearCameraInput!) {
            captureSession.addInput(self.rearCameraInput!)
            
            self.currentCameraPosition = .rear
        }
            
        else { throw CameraControllerError.invalidOperation }
    }
    
    func captureImage(completion: @escaping (UIImage?, Error?) -> Void) {
        guard let captureSession = captureSession, captureSession.isRunning else { completion(nil, CameraControllerError.captureSessionIsMissing); return }
        // get our settings and set the flash mode
        let settings = AVCapturePhotoSettings()
        settings.flashMode = self.flashMode
        
        // capture the photo and complete via the completion block
        self.photoOutput?.capturePhoto(with: settings, delegate: self)
        self.photoCaptureCompletionBlock = completion
    }
    
    
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // if our error is nil we have been successful else completion block with unkown error
        guard error == nil else {
            self.photoCaptureCompletionBlock?(nil, CameraControllerError.unknown)
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            self.photoCaptureCompletionBlock?(nil, CameraControllerError.unknown)
            return
        }
        // if we get this far yay set the image
        let stillImage = UIImage(data: imageData)
        self.photoCaptureCompletionBlock?(stillImage, nil)
        
    }
}
