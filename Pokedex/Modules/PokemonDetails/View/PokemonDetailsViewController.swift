//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Gerardo Ojeda on 18-09-22.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    var presenter:PokemonDetailsPresenterProtocol?
    var pokemonName: String?
    var pokemonDetails: Pokemon?
    
    var imageUrl: String? {
        didSet {
            guard imageUrl != nil else {
                return
            }
            
            self.photoImageView.image = nil
            
            let url = URL(string: imageUrl!)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(data: data!)
                }
            }
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.headerReferenceSize = CGSize(width: view.frame.size.width, height: 50)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()

    var heightLayout: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard self.collectionView.contentSize.height > 0 else {return }
        heightLayout?.constant = self.collectionView.contentSize.height
    }
    
    func setupUI(){
        
        title = pokemonName?.capitalized
        edgesForExtendedLayout = []

        collectionView.dataSource = self
        collectionView.register(PropertyCollectionViewCell.self, forCellWithReuseIdentifier: "reusableCell")
        collectionView.register(SectionHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        setupViews()

        self.view.layoutIfNeeded()

    }
    
    func setupViews(){
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(photoImageView)
        contentView.addSubview(collectionView)
        
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        photoImageView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.topAnchor, constant: 20).isActive = true
        photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        photoImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        heightLayout = NSLayoutConstraint(item: collectionView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
        heightLayout?.isActive = true
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

extension PokemonDetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let abilities = pokemonDetails?.types, section == 0 {
            return abilities.count
        }
        
        if let abilities = pokemonDetails?.abilities, section == 1 {
            return abilities.count
        }
        
        if let moves = pokemonDetails?.moves, section == 2 {
            return moves.count
        }
        
        return 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reusableCell", for: indexPath) as! PropertyCollectionViewCell
        
        switch indexPath.section {
        case 0:
            let type = pokemonDetails?.types![indexPath.row]
            cell.configure(name: (type?.type?.name?.capitalized)!)
        case 1:
            let ability = pokemonDetails?.abilities![indexPath.row]
            cell.configure(name: (ability?.ability?.name?.capitalized)!)
        case 2:
            let move = pokemonDetails?.moves![indexPath.row]
            cell.configure(name: (move?.move?.name?.capitalized)!)
        default:
            break
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard pokemonDetails != nil else { return 0 }
        return 3
    }
        
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
       
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! SectionHeaderCollectionViewCell
                
        switch indexPath.section {
        case 0:
            headerView.label.text = "Types"
        case 1:
            headerView.label.text = "Abilities"
        case 2:
            headerView.label.text = "Moves"
        default:
            break
        }

        return headerView
    }
    
}

extension PokemonDetailsViewController: PokemonDetailsViewProtocol{
    func showError(error: String){
        DispatchQueue.main.async {
            AlertMessage.show(with: error, in: self)
        }
    }
    
    func showPokemonDetails(with pokemon: Pokemon) {
        DispatchQueue.main.async {
            self.pokemonDetails = pokemon
            self.imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemon.id!).png"
            self.collectionView.reloadData()
        }
    }
        
}
