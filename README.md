# Narrow streaming

This is to be the docker container for the actual app that connects:

- the host (raspberry PI 2)
- the camera (Logitech C920 webcam)
- the streaming channel (YouTube)

The app will launch
1. fetch latest json config from $URL passing identity
{
	ver: 0.1,
	sound: "on",
	videoQualityPreset: "1080p"
	channelId: "youtube",
	channelSettings: {
		type: "youtube",
		uri: "rtmp://a.rtmp.youtube.com/live2",
		key: "some_key",
		title: "some title"
	}
}

2. listen to the GPIO "on" of a PIN (i.e. 7)
```
var gpio = require('rpi-gpio');

gpio.setup(7, gpio.DIR_IN, readInput);

function readInput() {
    gpio.read(7, function(err, value) {
        console.log('The value is ' + value);
    });
}
```
OR
```
var gpio = require('pi-gpio');
gpio.read(7, function(err, value) {
	if(err) throw err;
	console.log(value);	// The current state of the pin 
});
```
3. start the stream

4. on off, stop the stream
