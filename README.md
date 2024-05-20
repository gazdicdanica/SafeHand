# Prerequisites
Before running this application, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Docker

# Setup
## Flutter Setup:
- Clone this repository.
- Navigate to the tech_says_no_flutter/ directory and run the following command to fetch the project dependencies:
```
flutter pub get
```

## Docker Configuration:
Docker configuration files are provided in the tech_says_no_flask/ directory.
Build the Docker image using 
```
docker-compose build
```
Run the Docker container using 
```
docker-compose up
```

## IP configuration
- Run this command in CMD to obtain your machine's IPv4 address:
```
ipconfig
```
- Search for '192.168.0' in project and change it for local IPv4 address.

# Usage
After setting up Firebase and configuring the Flutter app, you can run the app on your local development environment using 
```
flutter run
```
