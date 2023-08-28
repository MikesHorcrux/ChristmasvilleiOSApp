import SwiftUI
import Observation

/// Form for adding a new address.
///
/// This form allows users to manually input an address or use their current location.
/// They can also rate the Christmas lights and add a nickname for the address.
struct AddAddressForm: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var formVM = CLMFormViewModel()
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
                    Task{
                        await formVM.save()
                        dismiss()
                    }
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
                TextField("Santa's House", text: $formVM.nickName)
            }
            .padding(.vertical)
        } header: {
            Text("nickname")
        }
    }
    
    /// Section for rating the Christmas lights.
    private var homeTypeSection: some View {
        Section {
            Picker("Rate the Christmas lights", selection: $formVM.houseType) {
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
            TextField("Street", text: $formVM.address.street)
            TextField("City", text: $formVM.address.city)
            TextField("State", text: $formVM.address.state)
            TextField("Zip code", text: $formVM.address.postalCode)
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
                    Task {
                        await formVM.save()
                        // Dismiss the view
                        dismiss()
                    }
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
                formVM.address = try await locationManager.getCurrentLocationAddress()
                formVM.coordinates = try await locationManager.getCoordinatesFromAddress(formVM.address)
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    AddAddressForm(locationManager: LocationManager())
}
