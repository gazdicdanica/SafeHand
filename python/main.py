import time, requests
import RPi.GPIO as GPIO

GPIO_PIN = 2

GPIO.setmode(GPIO.BCM)
GPIO.setup(GPIO_PIN, GPIO.IN, GPIO.PUD_OFF)


SHORT_PRESS_DURATION = 0.5
LONG_PRESS_DURATION = 1.0

lat=45.25242532998973
long=19.854536239005032
id=1

# Variables to track button press events
prev_input_state = GPIO.input(GPIO_PIN)
short_press_count = 0
last_press_time = 0


def send_http_request():
    try:
        response = requests.get('http://localhost:5000/api/')
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
