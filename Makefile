build:
	@pandoc -t revealjs --highlight-style=zenburn -s -o dist/index.html src/slides.md -V theme=night -V revealjs-url=https://unpkg.com/reveal.js
server:
	@npx reload -p 3000 --dir ./docs
watch: build
	@npx chokidar "./src/*.md" -c "make build"