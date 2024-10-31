personal_info="Emirhan_Altunel_200104004035"

handle_gate() {
	filename=$1
	mkdir -p ./doc/report/mag
	mkdir -p ./doc/report/spice
	mkdir -p ./doc/report/assets

	cat ./output/${filename}/base >./doc/report/spice/${filename}.spice
	cat ./output/${filename}/${filename}.spice >>./doc/report/spice/${filename}.spice
	sed "s|output_file|./output/${filename}/${filename}|" ./output/${filename}/end >>./doc/report/spice/${filename}.spice

	cp ./output/${filename}/${filename}.mag ./doc/report/mag/${filename}.mag

	./start.sh spice ${filename} >/dev/null

	cp ./output/${filename}/${filename}.png ./doc/report/assets/${filename}.png
	cp ./output/${filename}/${filename}_mag.png ./doc/report/assets/${filename}_mag.png

	tar -rvf ./doc/report/${personal_info}.tar.gz \
		-C ./doc/report/spice/${filename}.spice \
		-C ./doc/report/mag/${filename}.mag \
		-C ./doc/report/assets/${filename}.png \
		-C ./doc/report/assets/${filename}_mag.png

	zip -j ./doc/report/${personal_info}.zip \
		./doc/report/spice/${filename}.spice \
		./doc/report/mag/${filename}.mag \
		./doc/report/assets/${filename}.png \
		./doc/report/assets/${filename}_mag.png
}

rm ./doc/report/${personal_info}.tar.gz
rm ./doc/report/${personal_info}.zip

handle_gate not
handle_gate nor
handle_gate nand

tar -rvf ./doc/report/${personal_info}.tar.gz \
	-C ./doc/report/report.pdf
zip -j ./doc/report/${personal_info}.zip \
	./doc/report/report.pdf
