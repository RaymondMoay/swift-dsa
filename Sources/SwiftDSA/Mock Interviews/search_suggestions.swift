// MARK: - Mock Interview: Search Suggestions
//
// You are working on the search bar for an e-commerce app. As the user types
// each character into the search box, the UI should display up to 3 product
// name suggestions from the catalog. A product is a "suggestion" for the
// current typed prefix if the product name starts with that prefix.
//
// If there are more than 3 matching products for a given prefix, return the
// three that come first lexicographically.
//
// Implement a function:
//
//     func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]]
//
// - `products` is the catalog of product names (lowercase ASCII, may be large).
// - `searchWord` is what the user types, one character at a time.
// - Return an array of arrays. The i-th inner array is the list of up to 3
//   suggestions to display after the user has typed the first (i+1)
//   characters of `searchWord`. If no products match a given prefix, the
//   inner array for that step is empty.
//
// Example:
//   products  = ["mobile", "mouse", "moneypot", "monitor", "mousepad"]
//   searchWord = "mouse"
//
//   After typing "m":     ["mobile", "moneypot", "monitor"]
//   After typing "mo":    ["mobile", "moneypot", "monitor"]
//   After typing "mou":   ["mouse", "mousepad"]
//   After typing "mous":  ["mouse", "mousepad"]
//   After typing "mouse": ["mouse", "mousepad"]
//
// Output:
//   [
//     ["mobile","moneypot","monitor"],
//     ["mobile","moneypot","monitor"],
//     ["mouse","mousepad"],
//     ["mouse","mousepad"],
//     ["mouse","mousepad"]
//   ]
//
// Constraints to keep in mind:
//   - 1 <= products.count <= 1000
//   - 1 <= sum of all product name lengths <= 2 * 10^4
//   - 1 <= searchWord.count <= 1000
//   - All characters are lowercase English letters.
//
// Talk through your approach (data structure choice, time/space complexity)
// before you start coding. Good luck!

func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]] {

    // trie, but for suggestion, instead of DFS which would be O(L) where L is the max length, we can consider storing a top 3 smallest lex-length words at every node.

    let trie = Trie()

    for product in products {
        trie.insert(product)
    }

    var results: [[String]] = []
    var prefix: String = ""
    for c in searchWord {
        prefix += String(c)
        results.append(trie.suggest(prefix))
    }
    return results
}

class Trie {

    class Node {
        let value: Character
        var children: [Node?] = []
        var suggestions: [String] = []

        init(value: Character) {
            self.value = value
            children = Array(repeating: nil, count: 26)
        }

        func storeSuggestions(_ word: String) {
            if suggestions.count < 3 {
                // simply add
                suggestions.append(word)
                suggestions = suggestions.sorted()
            } else if word < suggestions[2] {
                // compare against the lex largest, and replace, then resort
                suggestions[2] = word
                suggestions = suggestions.sorted()
            }
        } 
    }

    let root = Node(value: "-")

    func insert(_ word: String) {
        var curr = root
        for c in word {
            let cIndex = indexOf(char: c)
            if let nextNode = curr.children[cIndex] {
                curr = nextNode
            } else {
                let newNode = Node(value: c)
                curr.children[cIndex] = newNode
                curr = newNode
            }
            curr.storeSuggestions(word) // walking through every node, and storing suggesitons
        }
    }

    func suggest(_ prefix: String) -> [String] {
        var curr = root 
        for c in prefix {
            let cIndex = indexOf(char: c)
            guard let nextNode = curr.children[cIndex] else { return [] }
            curr = nextNode
        }

        // final node
        return curr.suggestions
    }

    // MARK: private helpers

    private func indexOf(char: Character) -> Int {
        char.asciiValue - Character("a").asciiValue
    }
}