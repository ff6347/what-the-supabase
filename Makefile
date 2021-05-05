build:
	@pandoc -t revealjs --highlight-style=zenburn --template=src/default.revealjs -s -o docs/index.html src/slides.md --variable theme=night --variable revealjs-url=https://unpkg.com/reveal.js
server:
	@npx reload -p 3000 --dir ./docs
watch: build
	@npx chokidar "./src/*.md" -c "make build"