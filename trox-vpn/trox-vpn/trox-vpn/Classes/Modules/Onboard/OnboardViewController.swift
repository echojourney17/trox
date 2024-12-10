import UIKit

protocol OnboardView: AnyObject {
    var presenter: OnboardPresenterInterface? { get set }
    
    func select(index: Int)
    func unselect(index: Int)
}


class OnboardViewController: UIViewController {

    var presenter: OnboardPresenterInterface?

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnboardCollectionViewCell.self, forCellWithReuseIdentifier: "OnboardCollectionViewCell")
        view.dataSource = presenter
        view.delegate = self
        view.backgroundColor = .clear
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.isUserInteractionEnabled = false
        return view
    }()
    private lazy var pageControlView: PageControlView = {
        let view = PageControlView(numberOfPages: 2)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        let backgroundView = UIImageView(image: Asset.onboardBackground.image)
        self.view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let navView = UIView()
        let hStack = ViewFactory.stack(.horizontal, spacing: 30)
        navView.addSubview(hStack)
        hStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }

        let pageContainer = UIView()
        pageContainer.addSubview(pageControlView)
        pageControlView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(6)
        }
        
        hStack.addArrangedSubview(pageContainer)
        self.view.addSubview(navView)
        
        navView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(54)
        }
        
        let continueButton: UIButton = {
            let button = ViewFactory.Buttons.main(title: L10n.Onboard.next)
            button.addAction(UIAction(handler: { [weak self] action in
                self?.presenter?.didEvent?(.next)
            }), for: .touchUpInside)
            return button
        }()
        self.view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(8)
            make.height.equalTo(56)
        }
        self.view.addSubview(collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(navView.snp.bottom)
            make.bottom.equalTo(continueButton.snp.top)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OnboardViewController: OnboardView {
    
    func select(index: Int) {
        self.collectionView.selectItem(
            at: IndexPath(row: index, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally
        )
        self.pageControlView.fill(page: index - 1)
    }
    
    func unselect(index: Int) {
        self.collectionView.selectItem(
            at: IndexPath(row: index, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally
        )
        self.pageControlView.unfill(page: index)
    }
    
}

extension OnboardViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
}
