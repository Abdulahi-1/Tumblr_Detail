//
//  ViewController.swift
//  ios101-project5-tumbler
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    


    @IBOutlet weak var tableView: UITableView!
    
    
    var posts: [Post] = []

       override func viewDidLoad() {
           super.viewDidLoad()
           
           print("✅ ViewController loaded")
           
           tableView.dataSource = self
           tableView.delegate = self
           tableView.rowHeight = 300
           fetchPosts()
       }

       // MARK: - UITableViewDataSource

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return posts.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell

           let post = posts[indexPath.row]
           cell.summaryLabel.text = post.summary

           if let photo = post.photos.first {
               Nuke.ImagePipeline.shared.loadImage(with: photo.originalSize.url) { result in
                   switch result {
                   case .success(let response):
                       DispatchQueue.main.async {
                           cell.postImageView.image = response.image
                       }
                   case .failure(let error):
                       print("Image loading error: \(error)")
                       DispatchQueue.main.async {
                           cell.postImageView.image = nil
                       }
                   }
               }
           } else {
               cell.postImageView.image = nil
           }

           return cell
       }

       // MARK: - UITableViewDelegate

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           performSegue(withIdentifier: "showDetail", sender: indexPath)
       }

       // MARK: - Navigation

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showDetail",
              let indexPath = sender as? IndexPath,
              let detailVC = segue.destination as? DetailViewController {
               detailVC.post = posts[indexPath.row]
           }
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
