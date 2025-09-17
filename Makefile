MD_INDX   := index.md
MD_VEND   := vendors.md 
PNG_QR    := includes/timesguide-qr-code-high-2x2.png
CSS       := includes/include.css
YML       := pandoc.metadata.yaml
HTML_INDX := docs/index.html
HTML_VEND := docs/vendors.html

all:	$(HTML_INDX) $(HTML_VEND)

$(HTML_INDX):	$(MD_INDX) $(PNG_QR) $(CSS) $(YML)
	pandoc $(MD_INDX) --self-contained --output=$(HTML_INDX) --metadata-file=$(YML) --variable=title="" --from=gfm --to=html5 --css $(CSS)

$(HTML_VEND):	$(MD_VEND) $(CSS) $(YML)
	pandoc $(MD_VEND) --self-contained --output=$(HTML_VEND) --metadata-file=$(YML) --variable=title="" --from=gfm --to=html5 --css $(CSS)

vendors.csv:	vendors.xlsx
	perl xlsx2csv.pl vendors.xlsx vendors.csv

vendors.md:	vendors.csv
	echo -ne "# Vendors\n\n| Vendor | Location |\n| :--- | :---: |\n" > vendors.md
	/usr/bin/mlr --headerless-csv-output --csv  sort -f 'Business' then cut -f Business,SPACE vendors.csv | perl -E 'while(<>){chomp; s/"//g; if (m/\A(.*),([^,]+)\Z/){my $$name = $$1, my $$space = $$2; say "| $$name | $$space |"} else {die $$_}}' >> vendors.md
	sed -i -e 's/&amp;/\&/g' vendors.md

clean:
	rm -f vendors.csv
