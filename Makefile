all:	TimesGuide.md includes/include-before-body.html includes/include-after-body.html includes/timesguide-qr-code-high-2x2.png
	pandoc TimesGuide.md --self-contained --output=docs/index.html --from=markdown_github --to=html5 --include-before-body=includes/include-before-body.html --include-after-body=includes/include-after-body.html
