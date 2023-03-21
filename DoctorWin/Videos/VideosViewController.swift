//
//  VideosViewController.swift
//  DoctorWin
//
//  Created by AHP on 18/03/2566 BE.
//

import UIKit

class VideosViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    let shotTableViewCellIdentifier = "ShotTableViewCell"
    let loadingCellTableViewCellCellIdentifier = "LoadingCellTableViewCell"
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    var videosArray:[VideosModel] = []
    var videosVM = VideosViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        videosVM.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        var cellNib = UINib(nibName:shotTableViewCellIdentifier, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: shotTableViewCellIdentifier)
        cellNib = UINib(nibName:loadingCellTableViewCellCellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: loadingCellTableViewCellCellIdentifier)
        tableView.separatorStyle = .none
   
        NotificationCenter.default.addObserver(self, selector: #selector(self.appEnteredFromBackground), name: UIApplication.willEnterForegroundNotification
                    , object: nil)
        self.loadVideos()
    }
    func loadVideos() {
        self.showLoader()
        videosVM.getVideosDataFromAPI(pageNum: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pausePlayeVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pausePlayeVideos()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shotTableViewCellIdentifier, for: indexPath) as! ShotTableViewCell

        cell.configureCell(imageUrl: nil, description: (videosArray[indexPath.row].title ?? "") , videoUrl: (videosArray[indexPath.row].video ?? ""))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? ASAutoPlayVideoLayerContainer, let _ = videoCell.videoURL {
            ASVideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pausePlayeVideos()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pausePlayeVideos()
        }
    }
    
    func pausePlayeVideos(){
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView)
    }
    
    @objc func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView, appEnteredFromBackground: true)
    }

}

extension VideosViewController: VideosViewModelDelegate {
    func didReciveVideosData(response: VideosResponseModel?, error: String?) {
        self.dismiss()
        videosArray = response?.clipsResponse ?? []
        tableView.reloadData()
    }
}
