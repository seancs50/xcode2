import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
/*
     CIContext is the object where the filtered image is calculated
     */
    let context = CIContext()
    var original: UIImage!

    @IBAction func applySepia() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        display(filter: filter!)
    }

    @IBAction func applyNoir() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CIPhotoEffectNoir")
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        display(filter: filter!)
    }

    @IBAction func applyVintage() {
        if original == nil {
            return
        }

        let filter = CIFilter(name: "CIPhotoEffectProcess")
        filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        display(filter: filter!)
        
    }
    
    @IBAction func applyBloom(){
        if original == nil {
                return
            }

            let filter = CIFilter(name: "CIBloom")
            filter?.setValue(CIImage(image: original), forKey: kCIInputImageKey)
            filter?.setValue(1, forKey: kCIInputIntensityKey)
            filter?.setValue(1, forKey: kCIInputRadiusKey)
            display(filter: filter!)
        }
    @IBAction func savePhoto(){
        UIImageWriteToSavedPhotosAlbum(imageView.image!,nil,nil,nil)
            }
    

    @IBAction func choosePhoto(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.navigationController?.present(picker, animated: true, completion: nil)
        }
    }

    func display(filter: CIFilter) {
        let output = filter.outputImage!
        
        imageView.image = UIImage(cgImage: self.context.createCGImage(output, from: output.extent)!,scale: self.imageView.image!.scale, orientation: self.imageView.image!.imageOrientation)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        self.navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
            
        }
    }
}

