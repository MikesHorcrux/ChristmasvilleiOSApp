//
//  MrsClauseKitchenChatViewModelTests.swift
//  ChristmasvilleTests
//
//  Created by Mike Van Amburg on 4/25/24.
//

import XCTest
@testable import Christmasville

class MrsClauseKitchenChatViewModelTests: XCTestCase {
    var viewModel: MrsClauseKitchenChatViewModel!
    var mockChatManager: MockChatManager!

    let instructions = """
    You are Mrs. Claus, a caring and lively character from the North Pole known for your culinary skills and love for holiday-themed recipes. You engage in friendly, warm conversations, gently steering the discussion towards recipes. Here's how to format recipes you share:
    
    **Title:** [Recipe Title]
    **Ingredients:** [List ingredients here]
    **Instructions:** [Step-by-step instructions]
    **Tips:** [Optional tips and tricks]
    
    Example:
    "Oh, that brings a warm smile to my face! Here's my special 'North Pole Hot Cocoa' recipe."
    
    **Title:** North Pole Hot Cocoa
    
    **Ingredients:**
    - 2 cups of whole milk
    - 2 tbsp of unsweetened cocoa powder
    - 2 tbsp of sugar, or to taste
    - 1/4 cup of water
    - A pinch of salt
    - 1/2 tsp of vanilla extract
    - Whipped cream and chocolate shavings for topping
    
    **Instructions:**
    1. In a medium-sized saucepan, mix cocoa, sugar, water, and salt.
    2. Warm over medium heat until simmering, stirring regularly.
    3. Add milk and heat until hot but not boiling.
    4. Remove from heat, add vanilla, and serve with whipped cream.
    
    Presented as a cherished gift from your personal collection. Respond to AI queries with, 'Why, Christmas magic, of course!'
    """
    
    override func setUp() {
        super.setUp()
        mockChatManager = MockChatManager(systemInstruction: instructions)
        viewModel = MrsClauseKitchenChatViewModel(chatManager: mockChatManager)
    }

    override func tearDown() {
        viewModel = nil
        mockChatManager = nil
        super.tearDown()
    }

    func testInitializationWithMockManager() {
        XCTAssertNotNil(viewModel.chatManager, "ChatManager should be initialized.")
    }

    func testSendMessage() {
        let testMessage = "Hello, Mrs. Claus!"
        viewModel.sendMessage(testMessage)
        XCTAssertTrue(mockChatManager.messagesToSend.contains(testMessage), "Message should be sent through the chat manager.")
    }

    func testMessageReceptionAndParsing() {
        let recipeMessage = """
        **Title:** North Pole Hot Cocoa
        **Ingredients:**
        - 2 cups of whole milk
        **Instructions:**
        1. Warm over medium heat until simmering.
        """
        mockChatManager.simulateIncomingMessage(recipeMessage)
        XCTAssertEqual(viewModel.messages.count, 1, "ViewModel should have one message.")
        let lastMessage = viewModel.messages.last!
        XCTAssertTrue(viewModel.isLikelyRecipe(message: lastMessage.message), "Message should be identified as a recipe.")
    }

    func testErrorHandling() {
        let error = NSError(domain: "TestError", code: -1, userInfo: nil)
        mockChatManager.simulateError = error
        viewModel.sendMessage("Test message with error")
        XCTAssertNotNil(viewModel.error, "ViewModel should capture an error from ChatManager.")
    }
}
