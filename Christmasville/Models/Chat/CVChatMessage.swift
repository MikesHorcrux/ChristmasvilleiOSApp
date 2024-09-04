//
//  ChatMessage.swift
//  Christmasville
//
//  Created by Mike  Van Amburg on 4/24/24.
//

import Foundation

enum Participant {
  case system
  case user
}

struct CVChatMessage: Identifiable, Equatable {
  let id = UUID().uuidString
  var message: String
  let participant: Participant
  var pending = false

  static func pending(participant: Participant) -> CVChatMessage {
    Self(message: "", participant: participant, pending: true)
  }
}

extension CVChatMessage {
  static var samples: [CVChatMessage] = [
    .init(message: "Hello. What can I do for you today?", participant: .system),
    .init(message: "Show me a simple loop in Swift.", participant: .user),
    .init(message: """
    Sure, here is a simple loop in Swift:

    # Example 1
    ```
    for i in 1...5 {
      print("Hello, world!")
    }
    ```

    This loop will print the string "Hello, world!" five times. The for loop iterates over a range of numbers,
    in this case the numbers from 1 to 5. The variable i is assigned each number in the range, and the code inside the loop is executed.

    **Here is another example of a simple loop in Swift:**
    ```swift
    var sum = 0
    for i in 1...100 {
      sum += i
    }
    print("The sum of the numbers from 1 to 100 is \\(sum).")
    ```

    This loop calculates the sum of the numbers from 1 to 100. The variable sum is initialized to 0, and then the for loop iterates over the range of numbers from 1 to 100. The variable i is assigned each number in the range, and the value of i is added to the sum variable. After the loop has finished executing, the value of sum is printed to the console.
    """, participant: .system),
  ]

  static var sample = samples[0]
}
