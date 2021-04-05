//
//  CartViewController.swift
//  HutechSolutionsTask
//
//  Created by LokeshReddy on 01/04/21.
//

import UIKit
struct Storyboared {
    static let displayTableCell = "DisplayTableViewCell"
    static let dailyDetailsTableViewCell = "DailyDetailsTableViewCell"
    static let dailyDetailsCollectionViewCell = "DailyDetailsCollectionViewCell"
    static let newArravialTableViewCell = "NewArravialTableViewCell"
    static let newArravalCollectionViewCell = "NewArravalCollectionViewCell"
    static let freshFruitTableViewCell = "FreshFruitTableViewCell"
    static let freshFruitCollectionViewCell = "FreshFruitCollectionViewCell"
    static let categoriesTableViewCell = "CategoriesTableViewCell"
    static let categoriesCollectionViewCell = "CategoriesCollectionViewCell"
    static let exploreTableViewCell = "ExploreTableViewCell"
    static let exploreCollectionViewCell = "ExploreCollectionViewCell"
}
class CartViewController: UIViewController
{
    @IBOutlet weak var exploreTableView: UITableView!
    var exploreData = [Component]()
    var banner = [Banner]()
    var catagary = [Categorydatum]()
    var adsBanner = [Banner]()
    var queue = OperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
toCharacterFromExplore()
        // Do any additional setup after loading the view.
    }
    
    func toCharacterFromExplore()
    {
        let postDic = ["category_id":2]
        Service.shared.POSTService(serviceType: "home_test_section", postString: postDic as NSDictionary, targetView: self, myStruct: ExploreData.self, onTaskCompleted: {[unowned self] (FetchCardInformationData) -> (Void) in
                   //DispatchQueue.main.async {
            let card = FetchCardInformationData as! ExploreData
            print(card.success)
            self.banner = card.components[0].staticBanner ?? []
            print(self.banner)
            print(card.components[0].name)
            print(card.components[1].name)
            print(card.components[1].categorydata ?? [])
            self.catagary = card.components[1].categorydata ?? []
            self.adsBanner = card.components[2].adsBanner ?? []
            print(self.catagary)
            print(self.adsBanner)
            self.queue = OperationQueue()

            self.queue.addOperation { () -> Void in
                OperationQueue.main.addOperation({
                    self.exploreTableView.reloadData()
                    })
                }
            
                //   }
       
               }) { (error) in
                   print(error)
                   
               }
    }
}
extension CartViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.banner.count
        }else if section == 1{
            return 1}else{
                return 1
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboared.displayTableCell, for: indexPath) as!DisplayTableViewCell
            cell.selectionStyle = .none
            cell.result = banner[indexPath.section]
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboared.dailyDetailsTableViewCell, for: indexPath) as! DailyDetailsTableViewCell
            cell.selectionStyle = .none
            cell.displayLab.text = "Daily deals"
            return cell
        }
        else if indexPath.section == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboared.newArravialTableViewCell, for: indexPath)as!NewArravialTableViewCell
            cell.selectionStyle = .none
            cell.newArravalLab.text = "New arrivals"
            return cell
        }
        else if indexPath.section == 3 ||  indexPath.section == 5 || indexPath.section == 7
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboared.freshFruitTableViewCell, for: indexPath)as!FreshFruitTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 4
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboared.categoriesTableViewCell, for: indexPath)as!CategoriesTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 6
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboared.exploreTableViewCell, for: indexPath)as!ExploreTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if let cell = cell as? DailyDetailsTableViewCell
        {
            cell.dailyDetailsCollectionView.delegate = self
            cell.dailyDetailsCollectionView.dataSource = self
            cell.dailyDetailsCollectionView.tag = 1
            let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
                    layout.minimumLineSpacing = 1
                    layout.minimumInteritemSpacing = 1
            cell.dailyDetailsCollectionView.reloadData()
            DispatchQueue.main.async {
                cell.dailyDetailsCollectionView.setCollectionViewLayout(layout, animated: true)
            }
          
        }else if let cell = cell as? NewArravialTableViewCell{
            cell.newArravalCollectionView.delegate = self
            cell.newArravalCollectionView.dataSource = self
            cell.newArravalCollectionView.reloadData()
            cell.newArravalCollectionView.tag = 2
            let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
                    layout.minimumLineSpacing = 1
                    layout.minimumInteritemSpacing = 1
            DispatchQueue.main.async {
                
                cell.newArravalCollectionView.setCollectionViewLayout(layout, animated: true)}
        }else if let cell = cell as? FreshFruitTableViewCell{
            cell.freshFruitCollectionView.delegate = self
            cell.freshFruitCollectionView.dataSource = self
            cell.freshFruitCollectionView.reloadData()
            cell.freshFruitCollectionView.tag = 3
            let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
                    layout.minimumLineSpacing = 1
                    layout.minimumInteritemSpacing = 1
            DispatchQueue.main.async {
           cell.freshFruitCollectionView.setCollectionViewLayout(layout, animated: true)
            }
        }else if let cell = cell as? CategoriesTableViewCell{
            cell.categoryCollectionView.delegate = self
            cell.categoryCollectionView.dataSource = self
            cell.categoryCollectionView.reloadData()
            cell.categoryCollectionView.tag = 4
            let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .vertical
                    layout.minimumLineSpacing = 1
                    layout.minimumInteritemSpacing = 1
            DispatchQueue.main.async {
                cell.categoryCollectionView.setCollectionViewLayout(layout, animated: true)}
        }else if let cell = cell as?ExploreTableViewCell{
            cell.exploreCollectionView.delegate = self
            cell.exploreCollectionView.dataSource = self
            cell.exploreCollectionView.reloadData()
            cell.exploreCollectionView.tag = 5
            let layout = UICollectionViewFlowLayout()
                    layout.scrollDirection = .horizontal
                    layout.minimumLineSpacing = 1
                    layout.minimumInteritemSpacing = 1
            DispatchQueue.main.async {
             cell.exploreCollectionView.setCollectionViewLayout(layout, animated: true)
                
            }
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 120
        }
        else if indexPath.section == 1
        {
            return 250
        }else if indexPath.section == 2{
            return 250
        }
        else if indexPath.section == 3
        {
            return 100
        }else if indexPath.section == 4
        {
            return 600
        }else if indexPath.section == 5{
            return 140
        }else if indexPath.section == 6{
            return 300
        }else if indexPath.section == 7{
            return 100
        }else{
            return 300
        }
    }
    
}
extension CartViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView.tag == 1{
            return catagary.count
        }else if collectionView.tag == 2{
            return catagary.count
        }else if collectionView.tag == 3{
            return banner.count
        }else if collectionView.tag == 4{
            return catagary.count
        }else if collectionView.tag == 5{
            return catagary.count
        } else{
            return 9
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        if collectionView.tag == 1{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboared.dailyDetailsCollectionViewCell, for: indexPath)as! DailyDetailsCollectionViewCell
            cell.result = self.catagary[indexPath.row]
            return cell
            
        }else if collectionView.tag == 2{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboared.newArravalCollectionViewCell, for: indexPath)as! NewArravalCollectionViewCell
            cell.result = self.catagary[indexPath.row]
                    return cell
        }else if collectionView.tag == 3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboared.freshFruitCollectionViewCell, for: indexPath)as! CollectionViewCellFreshFruits
            cell.result = self.banner[indexPath.row]
                return cell
        }else if collectionView.tag == 4{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboared.categoriesCollectionViewCell, for: indexPath)as! CategoriesCollectionViewCell
            cell.result = self.catagary[indexPath.row]
            return cell
            
        }else if collectionView.tag == 5{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboared.exploreCollectionViewCell, for: indexPath)as! ExploreCollectionViewCell
            cell.result = self.catagary[indexPath.row]
            return cell
            
        }else{
                return UICollectionViewCell()
            }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 3
        {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width  - lay.minimumInteritemSpacing

return CGSize(width:widthPerItem, height:80)
        } else if collectionView.tag == 4
        {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width / 4 - lay.minimumInteritemSpacing

return CGSize(width:widthPerItem, height:120)
        }else if collectionView.tag == 5
        {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.width  - lay.minimumInteritemSpacing

return CGSize(width:widthPerItem, height:250)
        }
        else{
                let lay = collectionViewLayout as! UICollectionViewFlowLayout
                let widthPerItem = collectionView.frame.width / 3 - lay.minimumInteritemSpacing + 50

    return CGSize(width:widthPerItem, height:180)
        }
        
    }
    
}
