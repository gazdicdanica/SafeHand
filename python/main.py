import time, requests
import RPi.GPIO as GPIO

GPIO_PIN = 17

GPIO.setmode(GPIO.BCM)
GPIO.setup(GPIO_PIN, GPIO.IN, GPIO.PUD_OFF)


SHORT_PRESS_DURATION = 0.5
LONG_PRESS_DURATION = 1.0

lat=45.25242532998973
long=19.854536239005032

# Variables to track button press events
prev_input_state = GPIO.input(GPIO_PIN)
short_press_count = 0
last_press_time = 0


def send_http_request():
    try:
        response = requests.post('http://192.168.1.101:5000/alert', json={'email': 'isomidobradovic@gmail.com', 'latitude': lat, 'longitude': long})
        str_text = "I%20need%20your%20help%21%20I%20am%20in%20danger%21%20Hurry%20please%2C%20here%20is%20my%20location%3Ahttps%3A%2F%2Fmaps.google.com%2F%3Fq%3D" + str(lat) + "%2C" + str(long)
        requests.get("https://api.callmebot.com/whatsapp.php?phone=+381649144773&text=" + str_text + "&apikey=6164643")
        if response.status_code == 200:
            pass
        else:
            print("Error: ", response.status_code)
    except Exception as e:
        print("Exception: ", e)


def button_pressed():
    global short_press_count, last_press_time
    
    # Get the current time
    current_time = time.time()
    
    # Calculate the duration since the last press
    duration = current_time - last_press_time
    
    # Update the last press time
    last_press_time = current_time
    
    # Check if the duration indicates a short press
    if duration < SHORT_PRESS_DURATION:
        short_press_count += 1
        print("Short press detected")
        
        # Check if two short presses have occurred
        if short_press_count == 2:
            print("Two short presses detected")
            send_http_request()
    else:
        # If the duration indicates a long press, reset the short press count
        short_press_count = 0

try:
    while True:
        # Read the current input state of the GPIO pin
        input_state = GPIO.input(GPIO_PIN)
        
        # Check for changes in input state
        if input_state != prev_input_state:
            # Input state has changed
            if input_state == GPIO.HIGH:
                # Button pressed
                button_pressed()
        
        # Update the previous input state
        prev_input_state = input_state
        
        # Add a small delay to avoid excessive CPU usage
        time.sleep(0.01)
        
except KeyboardInterrupt:
    print("Exiting program")
finally:
    GPIO.cleanup()  # Reset GPIO pins
