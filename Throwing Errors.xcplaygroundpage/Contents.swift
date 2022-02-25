import Foundation

// ----------------------------------- //
// MARK: - Throwing Errors 

// Custom Errors, must be Enum and implement Error Protocol
enum BankAccountError: Error {
    case insufficientFunds
    case accountClosed
}

class BankAccount {
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withdraw(amount: Double) throws {
        if balance < amount {
            throw BankAccountError.insufficientFunds
        }
        balance -= amount
    }
}

let account = BankAccount(balance: 100)

do {
    try account.withdraw(amount: 300)
} catch {
    print(error)
}

// ----------------------------------- //
// MARK: - Passing Errors as a callback in completion handler

struct Post: Decodable {
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badURL
    case decodingError
    case badRequest
    case noData
    case custom(Error)
}

func getPosts(completion: @escaping (Result<[Post], NetworkError>) -> Void) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        completion(.failure(.badURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            completion(.failure(.custom(error)))
        } else if (response as? HTTPURLResponse)?.statusCode != 200 {
            completion(.failure(.badRequest))
        } else {
            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            let posts = try? JSONDecoder().decode([Post].self, from: data)
            if let posts = posts {
                completion(.success(posts))
            } else {
                completion(.failure(.decodingError))
            }
        }
    }.resume()
}

getPosts { result in
    switch result {
    case .success(let posts):
        print(posts.count, " posts founded")
    case .failure(let error):
        print(error)
    }
}

// MARK: - try? try! & Returning Optionals
// try? if fails, just returns nil
// try! the value must be valid and not should throw and error
