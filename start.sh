xhost +local:docker > /dev/null

# $1 == magic

if [ "$1" == "magic" ]; then
	docker run \
		-it --rm \
		--env DISPLAY=$DISPLAY \
		-v/tmp/.X11-unix:/tmp/.X11-unix \
		-v./tech:/usr/lib/x86_64-linux-gnu/magic/sys/current \
		-v./script:/script \
		-v./output:/output \
		--user $(id -u):$(id -g) \
		--name magic-ngspice \
		magic-ngspice:latest \
		/script/run_magic.sh $2
elif [ "$1" == "spice" ]; then
	docker run \
		-it --rm \
		--env DISPLAY=$DISPLAY \
		-v/tmp/.X11-unix:/tmp/.X11-unix \
		-v./tech:/usr/lib/x86_64-linux-gnu/magic/sys/current \
		-v./script:/script \
		-v./output:/output \
		--user $(id -u):$(id -g) \
		--name magic-ngspice \
		magic-ngspice:latest \
		/script/run_spice.sh $2
elif [ "$1" == "bash" ]; then
	docker run \
		-it --rm \
		--env DISPLAY=$DISPLAY \
		-v/tmp/.X11-unix:/tmp/.X11-unix \
		-v./tech:/usr/lib/x86_64-linux-gnu/magic/sys/current \
		-v./script:/script \
		-v./output:/output \
		--name magic-ngspice \
		magic-ngspice:latest
else
	echo "Invalid argument"
	echo "Usage: ./start.sh [magic|spice|bash] [input_file]"
fi
