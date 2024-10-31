if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <filename>"
	exit 1
fi

if [ ! -f /output/$1/$1.spice ]; then
	echo "File /output/$1/$1.spice not found"
	exit 1
fi

filename=$1

sed "s/output_file/\/output\/${filename}\/${filename}/" /output/${filename}/base >/tmp/circuit_base.cir
sed "s/output_file/\/output\/${filename}\/${filename}/" /output/${filename}/end >/tmp/circuit_end.cir
echo ".include /tmp/circuit_base.cir" >/tmp/circuit.cir
cat /output/${filename}/${filename}.spice >>/tmp/circuit.cir
echo ".include /tmp/circuit_end.cir" >>/tmp/circuit.cir

ngspice -b /tmp/circuit.cir

python3 /script/plotter.py /output/${filename}/${filename}.dat /output/${filename}/${filename}.png

rm /tmp/circuit_base.cir /tmp/circuit_end.cir /tmp/circuit.cir
rm /output/${filename}/${filename}.dat
