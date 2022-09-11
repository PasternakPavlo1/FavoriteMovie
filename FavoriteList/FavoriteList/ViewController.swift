//
//  ViewController.swift
//  FavoriteList
//
//  Created by Павло Пастернак on 31.08.2022.
//

import UIKit

// MARK: - ViewController class
class ViewController: UIViewController {
    
    // MARK: - Private propertie
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    // MARK: - Public propertie
    var items: [Movie] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addFavorite))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    //MARK: - Private method
    @objc private func addFavorite() {
        let alert = UIAlertController(title: "New Movie",
                                      message: "Add your favorite movie",
                                      preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Title"
            field.keyboardType = .numberPad
        }
        
        alert.addTextField { field in
            field.placeholder = "Year"
            field.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: "Done",
                                      style: .default,
                                      handler: { [weak self] (_) in
            guard let textFields = alert.textFields,
                  let movieTitle = textFields[0].text,
                  let yearMovie = textFields[1].text else {
                      return
                  }
            let movie = Movie(title: movieTitle, year: yearMovie)
            guard let filter = self?.items.filter({ $0 == movie }), filter.count == 0 else { return }
            guard let strongSelf = self else { return }
            strongSelf.items.append(movie)
            let indexPath = IndexPath(row: strongSelf.items.count-1, section: 0)
            strongSelf.table.beginUpdates()
            strongSelf.table.insertRows(at: [indexPath], with: .automatic)
            strongSelf.table.endUpdates()
        }))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row].title) - \(items[indexPath.row].year)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
