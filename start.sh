xhost +local:docker > /dev/null

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
	/script/run_magic.sh $1

chown -R $USER:$USER ./output
