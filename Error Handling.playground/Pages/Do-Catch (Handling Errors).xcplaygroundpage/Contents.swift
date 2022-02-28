
struct Pizza {
    let dough: String
    let toppings: [String]
}

enum PizzaBuilderError: Error {
    case doughBurnt
    case noToppings(String)
}

struct PizzaBuilder {
    func prepare() -> Pizza? {
        do {
            let dough = try prepareDough()
            let toppings = try prepareToppings()
            return Pizza(dough: dough, toppings: toppings)
        } catch {
            print("Unable to prepare pizza")
            return nil
        }
    }
    
    private func prepareDough() throws -> String {
        // prepare
        throw PizzaBuilderError.doughBurnt
    }
    
    private func prepareToppings() throws -> [String] {
        // prepare
        throw PizzaBuilderError.noToppings("Chicken is missing")
    }
}
