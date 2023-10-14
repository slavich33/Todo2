import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()

    var color = UIColor(hexString: "")?.hexValue()
    
    
    var categoryArray: Results<Category>?
    
    let dataFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFile)
        tableView.separatorStyle = .none
        
        
       
       loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation Bar does not exist")}
        
        navBar.backgroundColor = UIColor(hexString: "61C4F8")
    }
    
    //MARK: - TableView Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
                
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No new categories added"
        
//        let col = UIColor(randomFlatColorOf: .light).hexValue()
//        
//        color = col
//        
//        categoryArray?[indexPath.row].colour
        if let color = UIColor(hexString: categoryArray?[indexPath.row].colour ?? "61C4F8") {
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
        
        
        
//        self.save(category: colourCategory)
        
        
        return cell
       }

    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "goToItems", sender: select)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {
            let destinationVC = segue.destination as! ToDoListViewController
           
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categoryArray?[indexPath.row]
            }
            
        }
    }
//MARK: - Data Manipulation Methods
    
//    func delete(category: Category) {
//        
//        do {
//            
//            try realm.write{
//                realm.delete(category)
//            }
//        } catch {
//            print("Error deleting category \(error) ")
//        }
////        self.tableView.reloadData()
//    }
    
    
    func save(category: Category) {
        
        do {
            
            try realm.write{
                realm.add(category)
            }
        } catch {
            print("Error saving message \(error) ")
        }
        
        
        self.tableView.reloadData()
    }
   
    func loadItems() {

        categoryArray = realm.objects(Category.self)
        
    }
    override func updateModel(at indexPath: IndexPath) {
       
        if let categoryForDeletion = self.categoryArray?[indexPath.row] {
            do {
                try self.realm.write{
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error deleting category \(error) ")
            }
            
        }
    }
   
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new task or e.t.c.", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
        
            
            let newCategory = Category()
            
            newCategory.name = textField.text!
            newCategory.dateCreated = NSDate()
            newCategory.colour = UIColor(randomFlatColorOf: .light).hexValue()
           
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
            print(alertTextField.text!)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}


