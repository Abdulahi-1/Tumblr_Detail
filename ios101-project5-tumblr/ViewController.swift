//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    
    // Store the posts we fetch
        var posts: [Post] = []

        override func viewDidLoad() {
            super.viewDidLoad()

            print("✅ ViewController loaded")

            tableView.dataSource = self
            tableView.rowHeight = 300 // Ensures rows are visible
            fetchPosts()
        }

        // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.summaryLabel.text = "Test Post"
        cell.postImageView.image = UIImage(systemName: "photo")
        return cell
    }

        // MARK: - Networking

        func fetchPosts() {
            let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork/posts/photo?api_key=1zT8CiXGXFcQDyMFG7RtcfGLwTdDjFUJnZzKJaWTmgyK4lKGYk")!

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("❌ Network error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("❌ No data received")
                    return
                }

                do {
                    let blog = try JSONDecoder().decode(Blog.self, from: data)
                    DispatchQueue.main.async {
                        self.posts = blog.response.posts
                        self.tableView.reloadData()
                        print("✅ Loaded \(self.posts.count) posts")
                    }
                } catch {
                    print("❌ JSON decoding error: \(error.localizedDescription)")
                }
            }

            task.resume()
        }



}
