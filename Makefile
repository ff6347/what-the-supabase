build:
	@pandoc --to=revealjs --highlight-style=zenburn --template=src/default.revealjs --standalone --output=docs/index.html src/slides.md --variable theme=night --variable revealjs-url=https://unpkg.com/reveal.js
server:
	@npx reload -p 3000 --dir ./docs
watch: build
	@npx chokidar "./src/*.md" -c "make build"