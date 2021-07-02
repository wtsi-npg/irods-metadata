
HTML_FILES=$(patsubst %.org,%.html,$(wildcard *.org))
MARKDOWN_FILES=$(patsubst %.org,%.md,$(wildcard *.org))

all: html

markdown: $(MARKDOWN_FILES)

html: $(HTML_FILES)

%.html: %.org
	emacs $< --batch -f org-html-export-to-html --kill

%.md: %.org
	emacs $< --batch -f org-md-export-to-markdown --kill

clean:
	rm -f *.html *.md
