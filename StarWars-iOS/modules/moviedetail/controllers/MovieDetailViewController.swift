//
//  MovieDetailViewController.swift
//  StarWars-iOS
//
//  Created by Rodrigo Schar on 28/11/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieOpeningLabel: UILabel!
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieDirectorLabel: UILabel!
    @IBOutlet weak var movieProducerLabel: UILabel!
    @IBOutlet weak var tabsCollectionView: UICollectionView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var viewScrollContainer: UIView!
    @IBOutlet weak var tabsContainerView: UIView!
    @IBOutlet weak var charactersTableView: UITableView!

    var movieDetail = Movie()
    var viewModel = MovieDetailViewModel.shared // : MovieDetailViewModel

    init(movie: Movie) {
        self.movieDetail = movie
        self.viewModel.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    let sharedFunctions = SharedFunctions()
    var offSet: CGFloat = 300

    private lazy var charactersListVC: CharacterViewController = {
        let vc = CharacterViewController() // movie: movieDetail
        return vc
    }()

    private lazy var planetsListVC: PlanetViewController = {
        let vc = PlanetViewController()
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
         let blurEffect = UIBlurEffect(style: .regular)
         let blurEffectView = UIVisualEffectView(effect: blurEffect)
         blurEffectView.frame = imageBackground.bounds
         blurEffectView.alpha = 0.5
         imageBackground.addSubview(blurEffectView)
    }

    @objc func autoScroll() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 10, delay: 1, options: UIView.AnimationOptions.curveLinear, animations: {
                self.containerScrollView.contentOffset.y = CGFloat(self.offSet)
            }, completion: nil)
        }
    }

    private func setupView() {
        imageBackground.image = sharedFunctions.getImageForMovie(movieDetail.title)
        movieNameLabel.text = movieDetail.title
        movieOpeningLabel.text = movieDetail.openingCrawl
        movieReleaseDateLabel.attributedText = setBoldText(boldText: StringConstants.releaseDateENG,
                                                           normalText: sharedFunctions.getDateFormatter(date: movieDetail.releaseDate))
        movieDirectorLabel.attributedText = setBoldText(boldText: StringConstants.movieDirectorENG, normalText: movieDetail.director)
        movieProducerLabel.attributedText = setBoldText(boldText: StringConstants.movieProducerENG, normalText: movieDetail.producer)

        let nib = UINib(nibName: TabCollectionViewCell.nibName, bundle: nil)
        tabsCollectionView.register(nib, forCellWithReuseIdentifier: TabCollectionViewCell.identifier)
        tabsCollectionView.dataSource = self
        tabsCollectionView.delegate = self
        tabsCollectionView.allowsMultipleSelection = false
    }

    func setBoldText(boldText: String, normalText: String) -> NSMutableAttributedString {
        let textBold = "\(boldText)"
        let fullText = "\(textBold) \(normalText)"
        let range = (fullText as NSString).range(of: textBold)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: movieReleaseDateLabel.font.pointSize),
                                       range: range)
        return attributedString
    }

    // Settup Container tab control
    private func addViewController(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)

        // Add Child View as Subview
        tabsContainerView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = tabsContainerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }

    func tabOptionChanged(index: Int) {
        switch index {

        case 0:
            remove(asChildViewController: planetsListVC)
            addViewController(asChildViewController: charactersListVC)
        case 1:
            remove(asChildViewController: charactersListVC)
            addViewController(asChildViewController: planetsListVC)
        default:
            remove(asChildViewController: planetsListVC)
            addViewController(asChildViewController: charactersListVC)

        }
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        StringConstants.tabsListENG.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tab = StringConstants.tabsListENG[indexPath.row]
        let identifier = TabCollectionViewCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? TabCollectionViewCell
        guard let tabCell = cell else { return UICollectionViewCell() }
        tabCell.setValues(tab: tab)
        return tabCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tabOptionChanged(index: indexPath.row)
        if let cell = collectionView.cellForItem(at: indexPath) as? TabCollectionViewCell {
            cell.descriptionLabel.textColor = UIColor(named: StringConstants.openingCrawlColor)
            cell.lineTabView.isHidden = false
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TabCollectionViewCell {
            cell.descriptionLabel.textColor = UIColor.white
            cell.lineTabView.isHidden = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.5
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
