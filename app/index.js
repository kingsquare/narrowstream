var gpio = require('rpi-gpio');
var spawn = require('child_process').spawn;
var _ = require('lodash');

var ffmpeg = null;

var ffmpegToggle = _.throttle(function(channel, value) {
	console.log('Got pin ' + channel + ' set to ' + value);
	if (!ffmpeg) {
		console.log('Spawning ffmpeg');
		ffmpeg = spawn(__dirname + '/stream.sh');
		return;
	}

	console.log('Killing ffmpeg');
	ffmpeg.kill('SIGHUP');
	ffmpeg = null;
}, 1000, { 'trailing': false });


gpio.on('change', ffmpegToggle);

gpio.setup(21, gpio.DIR_IN, gpio.EDGE_BOTH);