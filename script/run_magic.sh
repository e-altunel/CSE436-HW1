if [ $# -ne 1 ]; then
	magic -T SCNM5M_DEEP.12.TSMC.tech27 -noconsole
else
	if [ ! -f /output/$1/$1.mag ]; then
		mkdir -p /output/$1
		touch /output/$1/$1.mag
	fi
	echo "Running magic with /output/$1/$1.mag"
	magic -T SCNM5M_DEEP.12.TSMC.tech27 -noconsole /output/$1/$1.mag
fi
