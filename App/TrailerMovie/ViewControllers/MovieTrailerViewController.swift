//
// Created by OVO on 07/12/19.
// Copyright © 2019 OVO. All rights reserved.
// 

import Combine
import YoutubePlayerView
import Ui_Kit
import UIKit

public final class MovieTrailerViewController: BaseViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    var viewModel: MovieTrailerViewModelType!
    var wireframe: MovieTrailerWireframe!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.input.onViewDidLoad()
    }
}

// MARK: Private
private extension MovieTrailerViewController {
    func setupView() {}
    
    func bindViewModel() {
        viewModel.output.updatePlayerViews.sink { [weak self] ids in
            guard let self = self else { return }
            self.stackView.subviews.forEach { $0.removeFromSuperview() }
            ids.forEach {
                let view = self.createPlayerView(id: $0)
                self.stackView.addArrangedSubview(view)
            }
        }.store(in: &subscriptions)
    }
    
    func createPlayerView(id: String) -> YoutubePlayerView {
        let view = YoutubePlayerView()
        view.backgroundColor = UIColor.lightGray
        view.loadWithVideoId(id)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.6).isActive = true
        return view
    }
}
