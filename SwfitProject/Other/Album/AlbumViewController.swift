//
//  AlbumViewController.swift
//  SwfitProject
//
//  Created by mograine on 2021/12/12.
//

import UIKit
import Alamofire
import Photos

enum AlbumType {
    case Image;
    case MP4;
    case MP3;
}


class AlbumViewController: BaseViewController {

    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var img_Back: UIImageView!
    @IBOutlet weak var btn_Album: UIButton!
    
    @IBOutlet weak var btn_Mp3: UIButton!
    
    @IBOutlet weak var btn_Isexit: UIButton!
    
    @IBOutlet weak var btn_ImageGet: UIButton!
    
    fileprivate(set) var viewModel = AlbumViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        screenSetupConfig()
    }
    
    //MARK: - 화면 구성 메서드 모음
    private func screenSetupConfig() {
        bindButton()
    }
    
    private func bindButton(){
          
        
        btn_Album.rx.tap.bind { [weak self] _ in
            self?.img.image?.saveToDocuments(filename: self?.viewModel.input.file_Name ?? "")
        }.disposed(by: viewModel.bag)
        
        
        btn_Mp3.rx.tap.bind { [weak self] _ in
            self?.shareOnInstagram(self?.viewModel.input.video_Url ?? "")
        }.disposed(by: viewModel.bag)
        
        
        btn_Isexit.rx.tap.bind { [weak self] _ in
            self?.fileIsExit()
        }.disposed(by: viewModel.bag)
        
        btn_ImageGet.rx.tap.bind { [weak self] _ in
            self?.img_Back.image = self?.getSavedImage(named: self?.viewModel.input.file_Name ?? "")
        }.disposed(by: viewModel.bag)
        
    }
    
    func getSavedImage(named: String) -> UIImage? {
      if let dir: URL = try? FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false) {
        let path: String
          = URL(fileURLWithPath: dir.absoluteString)
              .appendingPathComponent(named).path
        let image: UIImage? = UIImage(contentsOfFile: path)
        
        return image
      }
      return nil
    }
    
    func fileIsExit(){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
          let url = NSURL(fileURLWithPath: path)
          if let pathComponent = url.appendingPathComponent(viewModel.input.file_Name) {
              let filePath = pathComponent.path
              let fileManager = FileManager.default
              if fileManager.fileExists(atPath: filePath) {
                  print("파일존재")
              } else {
                  print("파일 없음")
              }
          } else {
              print("파일없음")
          }
    }
    
  
    
    func shareOnInstagram(_ url: String) {
        viewModel.input.videoPath = url
     let fileManager = FileManager.default
     // 앱 경로
     let appURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
     // 파일이름 url 의 맨 뒤 컴포넌트로 지정 (50MB.zip)
        let fileName : String = URL(string: viewModel.input.videoPath)!.lastPathComponent
     // 파일 경로 생성
     let fileURL = appURL.appendingPathComponent(fileName)
     // 파일 경로 지정 및 다운로드 옵션 설정 ( 이전 파일 삭제 , 디렉토리 생성 )
     let destination: DownloadRequest.Destination = { _, _ in
         return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
     }
     
        AF.download(self.viewModel.input.videoPath, method: .get, parameters: nil, encoding: JSONEncoding.default, to: destination).downloadProgress { (progress) in
         // 이 부분에서 프로그레스 적용
       let percent = Int(progress.fractionCompleted * 100)
       if (percent == 100){
           print("파일다운로드 완료 \(progress)")
       }else{
           print("파일다운로드 \(progress)")
       }
     }.response{ response in
             if response.error != nil {
                 print("파일다운로드 실패")
             }else{
                 print("파일다운로드 완료")
                 if let str = response.fileURL?.absoluteString {
                   self.saveVideo(videoPath: str, toAlbum: "mograine") { check, error in
                       print(check)
                     if (error != nil) {
                       if (check){
                         self.clearAllFile()
                         self.shareInstagramUrlSchemes()
                       }else{
                           print("파일다운로드 실패")
                       }
                      }else{
                          print("파일다운로드 실패")
                      }
                    }
                 }
             }
     }
   }
   
   //doucment 파일 제거
   func clearAllFile() {
       let fileManager = FileManager.default
       if fileManager.fileExists(atPath: viewModel.input.filePath) {
           // Delete file
           try? fileManager.removeItem(atPath: viewModel.input.filePath)
       } else {
           print("File does not exist")
       }
   }
   
   //인스타그램 영상 공유
   func shareInstagramUrlSchemes(){
       let fetchOptions = PHFetchOptions()
       fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
       let fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions)
       if let lastAsset = fetchResult.firstObject {
           let localIdentifier = lastAsset.localIdentifier
           let urlFeed = "instagram://library?LocalIdentifier=" + localIdentifier
           guard let url = URL(string: urlFeed) else {
               print("Could not open url")
               return
           }
           DispatchQueue.main.async {
               if UIApplication.shared.canOpenURL(url) {
                       UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
                           print("Sucess")
                       })
               }else {
                   print("Instagram not found")
               }
           }
       }
   }
   
   
    func getAlbum(title: String, completionHandler: @escaping (PHAssetCollection?) -> ()) {
       DispatchQueue.global(qos: .background).async { [weak self] in
           let fetchOptions = PHFetchOptions()
           fetchOptions.predicate = NSPredicate(format: "title = %@", title)
           let collections = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
           
           if let album = collections.firstObject {
               //앨범이 있음
               completionHandler(album)
           } else {
               //앨범이 없음 새로 생성후 만듬
               self?.createAlbum(withTitle: title, completionHandler: { (album) in
                   completionHandler(album)
               })
           }
       }
   }
   
   //앨범 만들기
   func createAlbum(withTitle title: String, completionHandler: @escaping (PHAssetCollection?) -> ()) {
       DispatchQueue.global(qos: .background).async {
           var placeholder: PHObjectPlaceholder?
           
           PHPhotoLibrary.shared().performChanges({
               let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)
               placeholder = createAlbumRequest.placeholderForCreatedAssetCollection
           }, completionHandler: { (created, error) in
               var album: PHAssetCollection?
               if created {
                   let collectionFetchResult = placeholder.map { PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [$0.localIdentifier], options: nil) }
                   album = collectionFetchResult?.firstObject
               }
               
               completionHandler(album)
           })
       }
   }
   
   //세이브 비디오
   func saveVideo(videoPath: String, toAlbum titled: String, completionHandler: @escaping (Bool, Error?) -> ()) {
       getAlbum(title: titled) { (album) in
           DispatchQueue.global(qos: .background).async {
               PHPhotoLibrary.shared().performChanges({
                   let startIdx: String.Index = videoPath.index(videoPath.startIndex, offsetBy: 8)
                   let result = String(videoPath[startIdx...])
                   let videoURL = Foundation.URL(fileURLWithPath:result)
                   let assetRequest =   PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: videoURL)
                   let assets = assetRequest?.placeholderForCreatedAsset.map { [$0] as NSArray } ?? NSArray()
                   let albumChangeRequest = album.flatMap {
                       PHAssetCollectionChangeRequest(for: $0)
                   }
                   albumChangeRequest?.addAssets(assets)
               }, completionHandler: { (success, error) in
                   completionHandler(success, error)
               })
           }
       }
   }
    
    //세이브 이미지
    func saveImage(imagePath: String, toAlbum titled: String, completionHandler: @escaping (Bool, Error?) -> ()) {
        getAlbum(title: titled) { (album) in
            DispatchQueue.global(qos: .background).async {
                PHPhotoLibrary.shared().performChanges({
                    let startIdx: String.Index = imagePath.index(imagePath.startIndex, offsetBy: 8)
                    let result = String(imagePath[startIdx...])
                    let videoURL = Foundation.URL(fileURLWithPath:result)
                    let assetRequest =  PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: videoURL)
                    let assets = assetRequest?.placeholderForCreatedAsset.map { [$0] as NSArray } ?? NSArray()
                    let albumChangeRequest = album.flatMap {
                        PHAssetCollectionChangeRequest(for: $0)
                    }
                    albumChangeRequest?.addAssets(assets)
                }, completionHandler: { (success, error) in
                    completionHandler(success, error)
                })
            }
        }
    }
    

}
extension UIImage{
    func saveToDocuments(filename:String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        if let data = self.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
                print("정상 등록")
            } catch {
                print("error saving file to documents: 안됨", error)
            }
        }
    }
}
