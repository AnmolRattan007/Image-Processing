//
//  ViewController.swift
//  ImageProcessing
//
//  Created by anmol rattan on 19/06/21.
//

import UIKit
import Accelerate

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var editedImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    
    override func viewWillAppear(_ animated: Bool) {
        crop()
    }
    
    
    
    
    
    func crop(){

        guard let sourceImage = UIImage(named: "AnihnaxBlacktimes.jpg") else{return}
    guard let cgImage = sourceImage.cgImage,let format = vImage_CGImageFormat(cgImage: cgImage) else {
            return
    }
        
        //Source buffer contains the dimensions and pixel data of image
        guard var sourceBuffer = try? vImage_Buffer(cgImage: cgImage,
                                                 format: format)
        else{return}
       
        // destination buffer is used to store the modified image
       
        
        let destinationHeight = Int(CGFloat(sourceBuffer.height)*0.1)
        let destinationWidth = Int(CGFloat(sourceBuffer.width)*0.1)
        
        guard var destinationBuffer = try? vImage_Buffer(width: destinationWidth,
                                                         height: destinationHeight,
                                                         bitsPerPixel: format.bitsPerPixel)
        else {
            return
            
        }
        
        
        let error = vImageScale_ARGB8888(&sourceBuffer,
                                     &destinationBuffer,
                                     nil,
                                     vImage_Flags(kvImageHighQualityResampling))
                
        guard error == kvImageNoError else {
            fatalError("Error in vImageScale_ARGB8888: \(error)")
        }
        
        let result = try? destinationBuffer.createCGImage(format: format)
        if let result = result {
            
          let newImage = UIImage(cgImage: result)
            print(newImage.size.width)
            print(newImage.size.height)
            editedImageView.image = newImage
            
        }
        sourceBuffer.free()
        destinationBuffer.free()
        
        }

}

