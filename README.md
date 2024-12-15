# SwiftUI-MVVM-Clean-Architecture

This project is a cryptocurrency listing application built with **SwiftUI** and following **MVVM** architecture combined with **Clean Architecture** principles. The project includes fetching data from an API, local persistence, and unit testing.

---

## **Features**
- **List of Cryptocurrencies**: Displays a list of cryptocurrencies fetched from a remote API (CoinMarketCap).
- **Favorite Management**: Users can mark cryptocurrencies as favorites, stored locally using **SwiftData**.
- **Detail View**: Detailed information for each cryptocurrency, including description, price, and website links.
- **Error Handling**: Proper error handling for network and decoding issues.
- **Unit Tests**: Simple unit tests for Use Cases, Repositories, and ViewModels.

---

## **Project Structure**
The project is organized into **layers** following **Clean Architecture**:
```
Cryptocurrencies/
│
├── Features/                      # Feature Modules
│   ├── Data/                      # Data Layer (API and Decodables)
│   │   ├── CryptoList/
│   │   │   ├── Decodables/        # API Response Models
│   │   │   │   ├── CryptoDecodable
│   │   │   │   ├── QuoteDecodable
│   │   │   │   └── CryptoDetailsDecodable
│   │   │   ├── CryptoListRepository
│   │   │   └── CryptoListRepositoryError
│   │
│   ├── Domain/                    # Domain Layer (Business Logic)
│   │   ├── CryptoList/
│   │   │   ├── CryptoListUseCase
│   │   │   └── CryptoEntity
│   │
│   ├── Presentation/              # Presentation Layer (Views, ViewModels and Models)
│   │   ├── Detail/                
│   │   │   └── DetailView
│   │   ├── Home/                  
│   │   │   ├── Components/        
│   │   │   ├── HomeView
│   │   │   ├── HomeViewModel
│   │   │   └── CryptoModel
│
├── Base/                          # Base Layer (Reusable Core Logic)
│   ├── Network/                   # Network Services
│   │   ├── NetworkSession
│   │   ├── APIRequest
│   │   ├── APIConfig
│   │   └── NetworkClient
│   │
│   ├── SwiftData/                 # Persistence
│   │   ├── PersistenceManager
│   │   ├── GlobalModelContainer
│   │   └── CryptoDataStore
│
├── App/                           
│   └── CryptocurrenciesApp        # Entry Point
```

---

## **Architecture Overview**
This project follows **Clean Architecture**, dividing responsibilities into layers:

1. **Data Layer**:
   - Handles API requests and data persistence.
   - Example: `CryptoListRepository` fetches cryptocurrency data from the API.

2. **Domain Layer**:
   - Contains business logic encapsulated into **Use Cases**.
   - Example: `CryptoListUseCase` manages fetching and transforming data.

3. **Presentation Layer**:
   - Contains SwiftUI Views and ViewModels.
   - Views are dumb components; ViewModels manage state and interact with Use Cases.

### Example Flow:
1. `HomeViewModel` calls `CryptoListUseCase` to fetch cryptocurrency data.
2. `CryptoListUseCase` requests data from `CryptoListRepository`.
3. The data is passed back to the `HomeViewModel` and displayed in `HomeView`.

---

## **Testing**
This project includes **unit tests** for Use Cases, Repositories, and ViewModels using **Swift Testing**.

- **Success and Failure Mocks**: Simulates successful and failed API responses.
- **Error Handling Tests**: Ensures proper handling of network and decoding errors.
- **Favorite Management Tests**: Verifies that adding and removing favorites works correctly.

---

## **Screenshots**

| <img src="https://github.com/user-attachments/assets/2e675676-5353-4593-96a2-f66c610da2b8" alt="Simulator Screenshot" width="220"/> | <img src="https://github.com/user-attachments/assets/d9e07847-8891-452a-8a8b-aed641b43ea7" alt="Simulator Screenshot" width="220"/> | <img src="https://github.com/user-attachments/assets/0570678c-1ae7-4102-bd3d-b0a163cd2858" alt="Simulator Screenshot" width="220"/> | <img src="https://github.com/user-attachments/assets/0a87670f-bd0d-4979-b7e1-f509908f6965" alt="Simulator Screenshot" width="220"/> |
|:------------------------------------------------------------:|:------------------------------------------------------------:|:------------------------------------------------------------:|:------------------------------------------------------------:|
| **HOME VIEW**                                                | **FAV ACTION**                                                | **DETAIL VIEW**                                               | **HOME VIEW (with FAVs)**                                           |
