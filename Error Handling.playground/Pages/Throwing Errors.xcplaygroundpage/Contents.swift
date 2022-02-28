import Foundation
import Darwin

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
// ----------------------------------- //

struct Post: Decodable {
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badURL
    case decodingError
    case badRequest
    case noData
    case invalidData
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

// ----------------------------------- //
// MARK: - Multiple Errors inside of Result
// ----------------------------------- //

enum AccountError: Error {
case insufficientFunds
case amountToLow
}

struct Account: Codable {
    let balance: Double
}

struct Transaction: Codable {
    let from: Account
    let to: Account
    let amount: Double
}

func trasnfer(url: URL,
              from: Account,
              to: Account,
              amount: Double,
              completion: @escaping (Result<String,Error>) -> Void) {
    
    guard amount > 0 else {
        completion(.failure(AccountError.amountToLow))
        return
    }
    
    guard from.balance > amount else {
        completion(.failure(AccountError.insufficientFunds))
        return
    }
    
    var request = URLRequest(url: url)
    let transaction = Transaction(from: from, to: to, amount: amount)
    request.httpBody = try? JSONEncoder().encode(transaction)
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in
        
        guard let data = data, error == nil else {
            completion(.failure(NetworkError.invalidData))
            return
        }
        
        print(data)
        // decoding
        
    }.resume()
}

guard let url = URL(string: "www.mybankservice/api/transfer-funds") else {
    throw NetworkError.badURL
}

let fromAccount = Account(balance: 100)
let toAccount = Account(balance: 50)
let amount = 50.0

trasnfer(url: url, from: fromAccount, to: toAccount, amount: amount) { result in
    switch result {
    case .success(let statusCode):
        print(statusCode)
    case .failure(AccountError.amountToLow):
        print("Amount to low")
    case .failure(AccountError.insufficientFunds):
        print("Insufficient funds")
    case .failure(NetworkError.invalidData), .failure(NetworkError.decodingError):
        print("Generic Errror message")
    default:
        print("Generics Error Message")
    }
}

// ----------------------------------- //
// MARK: - "Never" error.
/// functions thats never fails - Result type without Error handler needed
/// Never is an enum without cases, which means that if we use it indide an Result type we don't have to implement the cases to handle it.
// ----------------------------------- //

struct Category {
    let name: String
}

protocol Service {
    associatedtype Value
    associatedtype Err: Error
    func load(completion: (Result<Value, Err>) -> Void)
}

class CategoryService: Service {
    // We implement the func from the Service protocol
    // In the result type we include an Never error
    func load(completion: (Result<[Category], Never>) -> Void) {
        completion(.success([Category(name: "One category"), Category(name: "Another")]))
    }
}

CategoryService().load() { result in
    // As we use Never error type
    // we dont need to handle the .failure() block
    switch result {
    case .success(let categories):
        print(categories)
    }
}
