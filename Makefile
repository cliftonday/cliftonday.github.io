INC = includes/include-before-body.html includes/include-after-body.html pandoc.metadata.yaml

all:	docs/index.html docs/vendors.html

docs/index.html:	$(INC) index.md includes/timesguide-qr-code-high-2x2.png
	pandoc index.md --self-contained --output=docs/index.html --metadata-file=pandoc.metadata.yaml --variable=title="" --from=gfm --to=html5 --include-before-body=includes/include-before-body.html --include-after-body=includes/include-after-body.html

docs/vendors.html:	$(INC) vendors.md 
	pandoc vendors.md --self-contained --output=docs/vendors.html --metadata-file=pandoc.metadata.yaml --variable=title="" --from=gfm --to=html5 --include-before-body=includes/include-before-body.html --include-after-body=includes/include-after-body.html
