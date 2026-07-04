# Field Tracker 🚀

A modern Flutter application designed for field tracking, todo management with offline synchronization, location capture, geofencing, and local notification alerts.

---

## 🏗️ Architecture & Package Choices

### 1. Architectural Pattern
The application uses a **Feature-based Layered Architecture** (often referred to as feature-first organization). Inside the `lib/screens/` directory, each module (e.g., `tasks`, `sync`, `location`, `add location`, `login`) is isolated into its own folder structure containing:
*   `bloc/`: Handles states, events, and business logic.
*   `screens/`: Contains the screen layout and widget implementations.
*   `model/`: Defines data structures, JSON serialization, and adapters.
*   `features/`: Reusable widgets specific to that screen/module.

This approach guarantees high modularity, scalability, and makes debugging individual features extremely straightforward.

### 2. Core Package Choices
*   **State Management (`flutter_bloc` & `bloc`)**: Used to maintain a clean separation between UI components and business logic, providing predictable state transitions and easy testing.
*   **Dependency Injection (`get_it`)**: A lightweight service locator to manage singletons such as API helpers, synchronization services, and network connectivity status.
*   **Local Caching (`hive` & `hive_flutter`)**: An ultra-fast, lightweight key-value database written in pure Dart. Perfect for storing offline tasks, pending synchronization states, and local metadata.
*   **HTTP Client (`dio`)**: A powerful client with rich features including interceptors (used in `AuthInterceptor` to automatically inject JWT authentication headers), customized timeouts, and global configurations.
*   **Connectivity Tracking (`connectivity_plus`)**: Detects changes in cellular and Wi-Fi network connectivity.
*   **Location Services (`geolocator`)**: Acquires high-accuracy GPS coordinates for current position tracking.
*   **Permissions Management (`permission_handler`)**: Provides a unified API to query and request mobile permissions (such as Location and Notifications).
*   **Local Alerts (`flutter_local_notifications`)**: Used to display cross-platform notifications to alert users upon geofence entry/updates.

---

## 🔄 Offline Sync Approach (Tasks & Sync Screen)

The offline sync mechanism ensures the application remains fully functional even in remote areas without an active internet connection.

```
Offline Action (Toggle Task) 
       │
       ▼
 Save to Local Hive Box ("pendingTodoChanges") ──► UI Updates Instantly (Optimistic UI)
       │
       ▼
 [Network Connectivity Stream (connectivity_plus)]
       │
       ├─► (Offline) ──► Keep queueing changes (Latest state upserts by todoId)
       │
       └─► (Online)  ──► Auto-trigger Sync ──► Sync changes to API (Single/Batch) ──► Clear local queue
```

1.  **Optimistic Updates & Local Queue**:
    *   When the user toggles the completion status of a task offline, the mutation is immediately recorded locally to a Hive Box (`pendingTodoChanges`) via [TodoSyncService](file:///f:/Dart/Personal/interview/field_tracker/lib/screens/sync/service/todo_sync_service.dart).
    *   The model [PendingTodoChange](file:///f:/Dart/Personal/interview/field_tracker/lib/screens/sync/model/pending_todo_change.dart) captures the `todoId`, `isCompleted`, `title`, and a `changedAt` timestamp.
2.  **Upsert Strategy**:
    *   To prevent redundant network requests, offline updates are saved as an **upsert** keyed by the unique `todoId`. If a user toggles the same item multiple times offline, only the latest state is stored and synced.
3.  **Reactive Re-sync**:
    *   [ConnectivityService](file:///f:/Dart/Personal/interview/field_tracker/lib/screens/sync/service/connectivity_service.dart) listens to internet states via `connectivity_plus`.
    *   Once connection is restored, the `onlineStream` automatically fires and calls `syncPendingChanges()`, which replays queued actions to the backend (via `PATCH /api/v1/todos/:id` or batch sync via `POST /api/v1/todos/sync`).
    *   On successful network update, the successfully synced items are removed from the local Hive box.

---

## 📍 Geofence & Notification Approach (Location Section)

The location module allows field tracking with geofenced boundaries and interactive user alerts.

1.  **Permission & Location Fetching**:
    *   Before coordinates can be fetched, [AddLocationBloc](file:///f:/Dart/Personal/interview/field_tracker/lib/screens/add%20location/bloc/add_location_bloc.dart) requests Location permissions via `permission_handler` and checks if GPS services are active.
    *   Upon approval, the system fetches high-accuracy current location coordinates (latitude and longitude) using the `geolocator` plugin.
2.  **Geofence Definition**:
    *   Users can input a `location_name` and configure a circular geofence by defining a latitude, longitude, and a customized radius (in meters).
3.  **Local Notifications**:
    *   To demonstrate and test geofence alerts, the application integrates `flutter_local_notifications`.
    *   Upon successfully saving or editing a location, the bloc requests notification permissions (especially for Android 13+) and instantly triggers a local notification alert (*"Geofence Alert: You have entered the selected location"*), verifying that the notification channel and display mechanism are fully functional.

---

## 📁 Folder Structure Overview

Here is a summary of the core structure of the `lib/` directory:

```
lib/
├── app initializer/
│   └── my_app.dart              # Main application configuration & root routing
├── core/
│   ├── api base/                # Dio client, API Endpoints, and Auth interceptors
│   ├── app theme/               # Dark & light theme configuration (ThemeBloc)
│   ├── extensions/              # Extension methods
│   └── widgets/                 # Global UI reusable components
├── language/                    # Localization and translation resources
├── routes/                      # GoRouter implementation
├── screens/                     # Feature-specific modules
│   ├── add location/            # GPS geofence creation & map logic
│   ├── edit location/           # Geofence edit screen & validation
│   ├── home/                    # Home view structure
│   ├── location/                # Fetching and listing geofenced locations
│   ├── login/                   # User authentication & token storage
│   ├── navigation/              # Bottom navigation bar navigation shell
│   ├── profile/                 # User profiles and preferences
│   ├── registration/            # User signup flows
│   ├── splash/                  # Boot screen & initial session check
│   ├── sync/                    # Synchronization details & connection alerts
│   └── tasks/                   # Tasks/Todo lists rendering & offline actions
├── utils/                       # Common utilities (e.g., TokenManager)
└── main.dart                    # App Entry Point (Service registrations & Hive init)
```

---

## 🚀 Project Setup & Execution

### 1. Prerequisites
Ensure you have the following installed on your system:
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) (version `^3.12.0` or higher)
*   Dart SDK (compatible with Flutter)
*   Android Studio / Xcode (for running on emulators/simulators or physical devices)

### 2. Clone & Setup
1. Clone this repository to your local workspace. [https://github.com/rubayet27/field_tracker]
2. Navigate to the project root directory.
3. Install package dependencies:
   ```bash
   flutter pub get
   ```

### 3. Environment & Configuration
*   **Base URL Configuration**: The application requests are directed to a hosted backend environment. You can locate and modify the base URL path inside [api_endpoints.dart](file:///f:/Dart/Personal/interview/field_tracker/lib/core/api%20base/api_endpoint/api_endpoints.dart):
    ```dart
    static String baseUrl = "https://todo.progressivebyte.com";
    ```
*   **Hive Type Adapters**: If changes are made to Hive database models (e.g. `PendingTodoChange`), regenerate the adapter classes using `build_runner` (if configured, or update manually as written in the adapter files).

### 4. Running the App
Start your simulator/emulator or connect a physical device, then run:
```bash
flutter run
```
To run in release mode for production verification:
```bash
flutter run --release
```
