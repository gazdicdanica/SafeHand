# Prerequisites
Before running this application, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Docker
- RaspberryPI

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

## RaspberryPI Configuration
- Follow the wiring diagram from the picture
![wiring](https://github.com/Obradowski1389/tech_says_no/blob/master/documentation/2-pin-button.png)
- Power on your PI
- Enter the following command to copy the script and dependency requirements to the PI:
```
scp -r python {username}@{raspberry_ip}:~/path/to/target/directory
```
- SSH yourself to the PI
- Position yourself to target directory and run the following commands
```
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
sudo python main.py
```

# Usage
After setting up Firebase and configuring the Flutter app, you can run the app on your local development environment using 
```
flutter run
```
