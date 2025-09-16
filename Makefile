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
