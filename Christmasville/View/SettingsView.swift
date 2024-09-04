//
//  SettingsView.swift
//  Christmasville
//
//  Created by Mike Van Amburg on 9/1/24.
//

import SwiftUI
import Observation
import RevenueCat

struct SettingsView: View {
    @Environment(\.modelContext) var modelContext
    @State var subscription = SubscriptionManager.self
    @State private var locationManager = LocationManager() // Initialize the LocationManager

    @AppStorage("showSnowFall") var showSnowFall: Bool = true
    
    var body: some View {
            List {
                // Section for Debug Mode with a button to set Christmas data
                #if DEBUG
                Section(header: Text("Debug Mode")) {
                    Button("Set Christmas Data") {
                        // This button triggers the generation and saving of Christmas-themed data
                        saveAustinChristmasLocations(locationManager: locationManager)
                        generateAndSaveChristmasGiftees()
                        generateAndSaveChristmasRecipes()
                    }
                }
                #endif
                
                
                Section(header: Text("Subscription")) {
                    HStack {
                                // Display the subscription status
                        Text(subscription.shared.isSubscriptionActive ? "You have an active subscription. Thank you for supporting us!" : "You currently do not have an active subscription.")
                                    .padding()
                        Spacer()
                                // Button to manage/cancel subscription
                                Button(action: {
                                    openSubscriptionManagement()
                                }) {
                                    Text("Manage Subscription")
                                }
                                .buttonStyle(BorderedProminentButtonStyle())
                                .disabled(!subscription.shared.isSubscriptionActive) // Disable button if no active subscription
                            }
                    .padding()
                }
                
                Section(header: Text("Assibility")) {
                        Toggle("Snow fall enabled: ", isOn: $showSnowFall)
                        .padding()
                        .tint(.accent)
                }
            }
            .navigationTitle("Settings")
        .onAppear {
            // Start location services when the view appears
            locationManager.startLocationServices()
        }
        .snowBackground()
    }
    
    //MARK: - Fuctions
    
    // Function to open the App Store subscription management URL
        func openSubscriptionManagement() {
            Purchases.shared.getCustomerInfo { (customerInfo, error) in
                if let url = customerInfo?.managementURL {
                    UIApplication.shared.open(url)
                }
            }
        }
    
    // MARK: - Debug Functions
    
    /// Function to generate and save fifteen Austin Christmas locations using the LocationManager to fetch real coordinates.
    private func saveAustinChristmasLocations(locationManager: LocationManager) {
        let locationsData = [
            ("123 Festive St", "Austin", "TX", "78701"),
            ("456 Holiday Ln", "Austin", "TX", "78702"),
            ("789 Merry Ave", "Austin", "TX", "78703"),
            ("101 Santa Blvd", "Austin", "TX", "78704"),
            ("102 North Pole Rd", "Austin", "TX", "78705"),
            ("103 Jingle Way", "Austin", "TX", "78706"),
            ("104 Reindeer Dr", "Austin", "TX", "78707"),
            ("105 Sleigh Ct", "Austin", "TX", "78708"),
            ("106 Noel Pl", "Austin", "TX", "78709"),
            ("107 Yuletide Dr", "Austin", "TX", "78710"),
            ("108 Frosty St", "Austin", "TX", "78711"),
            ("109 Snowman Ln", "Austin", "TX", "78712"),
            ("110 Mistletoe Ave", "Austin", "TX", "78713"),
            ("111 Garland Blvd", "Austin", "TX", "78714"),
            ("112 Candy Cane Ct", "Austin", "TX", "78715")
        ]
        
        let nicknames = [
            "Santa's House", "Reindeer Ranch", "Winter Wonderland", "Elf Lodge", "Candy Cane Palace",
            "Frosty's Home", "North Pole Retreat", "Jingle Bells House", "Mistletoe Manor", "Yuletide Villa",
            "Garland Gardens", "Sleigh Stop", "Noel's Nook", "Holiday Haven", "Christmas Cottage"
        ]
        
        Task {
            for (index, data) in locationsData.enumerated() {
                let (street, city, state, postalCode) = data
                let address = Address(street: street, city: city, state: state, country: "USA", postalCode: postalCode)
                
                do {
                    // Fetch coordinates using LocationManager
                    let coordinates = try await locationManager.getCoordinatesFromAddress(address)
                    let location = ChristmasLightsLocation(
                        nickname: nicknames[index],
                        address: address,
                        coordinates: coordinates,
                        houseType: .amazing // Replace with desired house type
                    )
                    modelContext.insert(location)
                } catch {
                    print("Failed to get coordinates for \(address.street): \(error)")
                }
            }
            print("Fifteen Austin addresses with nicknames and real coordinates saved!")
        }
    }
    
    /// Function to generate and save ten Christmas-themed Giftee instances.
    private func generateAndSaveChristmasGiftees() {
        let giftees = [
            Giftee(name: "Nicholas Frost", sex: "Male", age: "55", activities: "Sleigh Riding, Snowball Fights", interests: "Christmas Trees, Snow Sculpting", hobbies: "Wood Carving", relation: .family, giftStatus: .purchased),
            Giftee(name: "Holly Winters", sex: "Female", age: "30", activities: "Ice Skating, Hot Cocoa Tasting", interests: "Holiday Movies, Christmas Lights", hobbies: "Baking Gingerbread Cookies", relation: .friend, giftStatus: .wrapped),
            Giftee(name: "Chris Pine", sex: "Male", age: "40", activities: "Tree Decorating, Caroling", interests: "Christmas Music, Holiday Cooking", hobbies: "Making Ornaments", relation: .colleague, giftStatus: .shipped),
            Giftee(name: "Eve Noel", sex: "Female", age: "25", activities: "Gift Wrapping, Christmas Crafts", interests: "Holiday Fashion, Snowflakes", hobbies: "Knitting Scarves", relation: .friend, giftStatus: .given),
            Giftee(name: "Rudolph Reindeer", sex: "Male", age: "8", activities: "Flying, Reindeer Games", interests: "Red Noses, Carrots", hobbies: "Running", relation: .other, giftStatus: .wishlist),
            Giftee(name: "Mary Claus", sex: "Female", age: "60", activities: "Cookie Baking, Present Wrapping", interests: "Christmas Magic, North Pole", hobbies: "Sewing Stockings", relation: .family, giftStatus: .purchased),
            Giftee(name: "Jack Snow", sex: "Male", age: "35", activities: "Snowboarding, Ice Sculpting", interests: "Winter Sports, Snowstorms", hobbies: "Collecting Snow Globes", relation: .colleague, giftStatus: .shopping),
            Giftee(name: "Ivy Garland", sex: "Female", age: "28", activities: "Wreath Making, Holiday Party Planning", interests: "Christmas Decorations, Poinsettias", hobbies: "Floral Arranging", relation: .friend, giftStatus: .given),
            Giftee(name: "Candy Cane", sex: "Female", age: "18", activities: "Candy Making, Cookie Decorating", interests: "Sweets, Peppermints", hobbies: "Sugar Sculpting", relation: .family, giftStatus: .purchased),
            Giftee(name: "Joseph Star", sex: "Male", age: "45", activities: "Star Gazing, Candle Lighting", interests: "Nativity Scenes, Angels", hobbies: "Woodworking", relation: .family, giftStatus: .wrapped)
        ]
        
        for giftee in giftees {
            modelContext.insert(giftee)
        }
        
        print("Ten Christmas-themed Giftee instances have been saved.")
    }
    
    /// Function to generate and save ten Christmas-themed Recipe instances.
    private func generateAndSaveChristmasRecipes() {
        let recipes = [
            Recipe(
                title: "Gingerbread Cookies",
                ingredients: "Flour, Ginger, Cinnamon, Cloves, Nutmeg, Butter, Brown Sugar, Molasses, Eggs, Baking Soda",
                instructions: "1. Preheat oven to 350°F.\n2. Mix dry ingredients together.\n3. Cream butter and sugar, then add molasses and eggs.\n4. Gradually add dry ingredients.\n5. Roll dough and cut into shapes.\n6. Bake for 8-10 minutes.",
                tip: "Decorate with royal icing for a festive touch."
            ),
            Recipe(
                title: "Eggnog",
                ingredients: "Eggs, Sugar, Milk, Cream, Nutmeg, Vanilla, Rum or Bourbon (optional)",
                instructions: "1. Whisk eggs and sugar until fluffy.\n2. Heat milk and cream in a saucepan.\n3. Gradually add milk mixture to egg mixture.\n4. Stir in nutmeg and vanilla.\n5. Chill and add alcohol if desired.",
                tip: "Serve with a sprinkle of cinnamon or nutmeg on top."
            ),
            Recipe(
                title: "Christmas Ham",
                ingredients: "Ham, Brown Sugar, Honey, Dijon Mustard, Cloves, Pineapple Rings, Maraschino Cherries",
                instructions: "1. Preheat oven to 325°F.\n2. Score ham and stud with cloves.\n3. Mix brown sugar, honey, and mustard to make glaze.\n4. Brush ham with glaze and top with pineapple and cherries.\n5. Bake for 2-3 hours, basting occasionally.",
                tip: "Use the pan drippings to make a delicious gravy."
            ),
            Recipe(
                title: "Peppermint Bark",
                ingredients: "White Chocolate, Dark Chocolate, Peppermint Extract, Crushed Candy Canes",
                instructions: "1. Melt dark chocolate and spread on a baking sheet.\n2. Let cool until firm.\n3. Melt white chocolate and mix with peppermint extract.\n4. Spread white chocolate over dark chocolate.\n5. Sprinkle with crushed candy canes.\n6. Let cool and break into pieces.",
                tip: "Store in an airtight container for up to two weeks."
            ),
            Recipe(
                title: "Roasted Chestnuts",
                ingredients: "Chestnuts, Butter, Salt",
                instructions: "1. Preheat oven to 425°F.\n2. Cut an X on the flat side of each chestnut.\n3. Place chestnuts on a baking sheet.\n4. Roast for 20-25 minutes, shaking the pan occasionally.\n5. Peel and enjoy with melted butter and a sprinkle of salt.",
                tip: "Serve warm for the best flavor."
            ),
            Recipe(
                title: "Yule Log Cake",
                ingredients: "Flour, Cocoa Powder, Sugar, Eggs, Butter, Heavy Cream, Chocolate, Vanilla, Powdered Sugar",
                instructions: "1. Preheat oven to 350°F.\n2. Whisk together flour, cocoa powder, and sugar.\n3. Beat eggs until fluffy and add dry ingredients.\n4. Bake in a jelly roll pan for 12-15 minutes.\n5. Roll cake in a towel to cool.\n6. Unroll and spread with chocolate filling.\n7. Roll up and frost with chocolate ganache.",
                tip: "Dust with powdered sugar to resemble snow."
            ),
            Recipe(
                title: "Cranberry Sauce",
                ingredients: "Cranberries, Sugar, Orange Juice, Orange Zest, Cinnamon Stick",
                instructions: "1. Combine cranberries, sugar, and orange juice in a saucepan.\n2. Add orange zest and cinnamon stick.\n3. Simmer until cranberries burst and sauce thickens.\n4. Remove cinnamon stick before serving.",
                tip: "Make this sauce a day ahead to let the flavors meld."
            ),
            Recipe(
                title: "Mulled Wine",
                ingredients: "Red Wine, Orange, Cinnamon Sticks, Cloves, Star Anise, Honey, Brandy (optional)",
                instructions: "1. Combine wine, sliced orange, and spices in a saucepan.\n2. Heat gently without boiling.\n3. Stir in honey and brandy if using.\n4. Simmer for 10-15 minutes.\n5. Strain and serve warm.",
                tip: "Garnish with an orange slice and a cinnamon stick."
            ),
            Recipe(
                title: "Christmas Pudding",
                ingredients: "Dried Fruit, Flour, Bread Crumbs, Brown Sugar, Spices, Eggs, Suet, Brandy, Orange Zest",
                instructions: "1. Combine all ingredients in a large bowl.\n2. Pour into a greased pudding basin.\n3. Cover with parchment paper and foil.\n4. Steam for 6-8 hours.\n5. Let cool and store for at least a week.\n6. Steam again before serving.",
                tip: "Flambé with brandy for a dramatic presentation."
            ),
            Recipe(
                title: "Candy Cane Cheesecake",
                ingredients: "Cream Cheese, Sugar, Eggs, Vanilla, Peppermint Extract, Crushed Candy Canes, Graham Cracker Crust",
                instructions: "1. Preheat oven to 325°F.\n2. Beat cream cheese and sugar until smooth.\n3. Add eggs one at a time.\n4. Stir in vanilla and peppermint extract.\n5. Pour into graham cracker crust.\n6. Bake for 55-60 minutes.\n7. Cool and top with crushed candy canes.",
                tip: "Chill overnight for best flavor."
            )
        ]
        
        for recipe in recipes {
            modelContext.insert(recipe)
        }
        
        print("Ten Christmas-themed Recipe instances have been saved.")
    }
}

struct AccountView: View {
    var body: some View {
        Text("Manage your account settings here.")
            .navigationTitle("Account")
    }
}

struct AboutView: View {
    var body: some View {
        Text("Information about the app.")
            .navigationTitle("About")
    }
}

#Preview {
    SettingsView()
}
