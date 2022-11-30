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
    @IBOutlet weak var charactersTableView: UITableView!

    var movieDetail = Movie()
    let tabsList = ["Personajes", "Planetas", "Especies", "Naves", "Vehiculos"]
    var viewModel: MovieDetailViewModel

    init(movie: Movie) {
        self.movieDetail = movie
        self.viewModel = MovieDetailViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    let sharedFunctions = SharedFunctions()
    var offSet: CGFloat = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initViewModel()
        viewModel.getCharacters()
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

    private func initViewModel() {
        viewModel.reloadData = { [weak self] in
//            print(self?.viewModel.charactersList)
            print(self?.viewModel.charactersList.count)
            DispatchQueue.main.async {
                self?.charactersTableView.reloadData()
            }
        }

        viewModel.onError = { error in
            print(error)
        }
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

        // Characters Table view
        let nibChar = UINib(nibName: CharacterTableViewCell.nibName, bundle: nil)
        charactersTableView.register(nibChar, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.estimatedRowHeight = 80
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

extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.charactersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier)
        as? CharacterTableViewCell ?? CharacterTableViewCell()
        cell.selectionStyle = .none

        let character = viewModel.charactersList[indexPath.row]
        cell.setData(character: character)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
