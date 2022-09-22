all:	README.md
	pandoc README.md --output=docs/index.html --from=markdown_github --to=html5 --include-before-body=include-before-body.html --include-after-body=include-after-body.html

new:	README.md
	pandoc README.md --output=docs/index.html --from=markdown        --to=html5 --include-before-body=include-before-body.html --include-after-body=include-after-body.html

