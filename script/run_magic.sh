if [ $# -ne 1 ]; then
	magic -T SCNM5M_DEEP.12.TSMC.tech27 -noconsole
else
	magic -T SCNM5M_DEEP.12.TSMC.tech27 -noconsole /output/$1.mag
fi
