import SwiftUI
import Observation

/// Form for adding a new address.
///
/// This form allows users to manually input an address or use their current location.
/// They can also rate the Christmas lights and add a nickname for the address.
struct AddAddressForm: View {
    @Environment(\.modelContext) var modelContext

    @Environment(\.dismiss) var dismiss
    @State var coordinates: Coordinates = Coordinates(latitude: 0, longitude: 0)
    @State var houseType: ChristmasLightsHouseType = .amazing
    @State var nickName: String = ""
    @State var address: Address = Address(street: "", city: "", state: "", country: "", postalCode: "")
    
    var locationManager: LocationManager

    var body: some View {
        List {
            nicknameSection
            homeTypeSection
            addressSection
            singingCandlesImage
#if os(macOS)
            saveButtonMacOS
            #endif
        }
        .background(Color.clear)
        .toolbar {
            #if !os(macOS)
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    // save for ios
                    let location = ChristmasLightsLocation(nickname: nickName,address: address, coordinates: coordinates, houseType: houseType)
                    modelContext.insert(location)
                    dismiss()
                }
            }
            #endif
        }
    }
    
    /// Section for inputting the nickname.
    private var nicknameSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Add a nickname:")
                TextField("Santa's House", text: $nickName)
            }
            .padding(.vertical)
        } header: {
            Text("nickname")
        }
    }
    
    /// Section for rating the Christmas lights.
    private var homeTypeSection: some View {
        Section {
            Picker("Rate the Christmas lights", selection: $houseType) {
                ForEach(ChristmasLightsHouseType.allCases, id: \.self) { houseType in
                    Text(houseType.rawValue).tag(houseType)
                }
            }
            .pickerStyle(.menu)
        }
        .tint(.lightgreen)
    }
    
    /// Section for inputting the address.
    private var addressSection: some View {
        Section {
            TextField("Street", text: $address.street)
            TextField("City", text: $address.city)
            TextField("State", text: $address.state)
            TextField("Zip code", text: $address.postalCode)
            VStack {
                HStack() {
                    Capsule().frame(width: nil, height: 1)
                    Text("or")
                    Capsule().frame(width: nil, height: 1)
                }
                .padding(.horizontal)
                Button("Use Current Location") {
                    useCurrentLocation()
                }
                .buttonStyle(SantaRedPillButtonStyle())
                
            }
        } header: {
            Text("Address")
        }
    }
    
    /// Image view for the "singing candles" image.
    private var singingCandlesImage: some View {
        HStack {
            Spacer()
            Image("singing candles")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 150)
            Spacer()
        }
        .listRowBackground(Color.clear)
    }
    
    /// Save Button for macOS.
    ///
    /// Only shown when running on macOS, provides same functionality as the Save button in the toolbar on non-macOS platforms.
    private var saveButtonMacOS: some View {
        HStack {
            Spacer()
            VStack {
                Button("Save") {
                    
                }
                .buttonStyle(SantaRedPillButtonStyle())
               
                Button("Cancel"){
                    dismiss()
                }
                .foregroundStyle(Color.secondary)
            }
            .listRowBackground(Color.clear)
            Spacer()
        }
        .padding(.vertical, 50)
    }
    
    /// Uses the current location to fill the address fields.
    ///
    /// This method fetches the current location and the corresponding address, then updates the form view model with the information.
    private func useCurrentLocation() {
        Task {
            do {
                address = try await locationManager.getCurrentLocationAddress()
                coordinates = try await locationManager.getCoordinatesFromAddress(address)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    AddAddressForm(locationManager: LocationManager())
}
