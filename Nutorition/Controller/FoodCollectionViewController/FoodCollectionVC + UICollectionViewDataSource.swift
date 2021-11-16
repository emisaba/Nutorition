import UIKit

extension FoodCollectonViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var arrayCount = 0
        
        switch selectedFoodCategory {
        case "carbon":
            arrayCount = carbons.count
        case "vege":
            arrayCount = veges.count
        case "fruit":
            arrayCount = fruits.count
        case "dairy":
            arrayCount = dairies.count
        case "meat":
            arrayCount = meats.count
        case "fish":
            arrayCount = fishes.count
        case "soy":
            arrayCount = soys.count
        default:
            break
        }
        
        return arrayCount == 0 ? foods.count : arrayCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FoodCollectionViewCell
        cell.viewModel = FoodListViewModel(food: foods[indexPath.row])
        
        switch selectedFoodCategory {
        case "carbon":
            cell.viewModel = FoodListViewModel(food: carbons[indexPath.row])
        case "vege":
            cell.viewModel = FoodListViewModel(food: veges[indexPath.row])
        case "fruit":
            cell.viewModel = FoodListViewModel(food: fruits[indexPath.row])
        case "dairy":
            cell.viewModel = FoodListViewModel(food: dairies[indexPath.row])
        case "meat":
            cell.viewModel = FoodListViewModel(food: meats[indexPath.row])
        case "fish":
            cell.viewModel = FoodListViewModel(food: fishes[indexPath.row])
        case "soy":
            cell.viewModel = FoodListViewModel(food: soys[indexPath.row])
        default:
            break
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: headerIdentifier,
                                                                   for: indexPath) as! FoodCollectionHeaderView
        view.delegate = self
        return view
    }
}
