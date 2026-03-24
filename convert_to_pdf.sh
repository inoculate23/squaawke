#!/bin/bash
# Convert AI_CO-CREATION_ETHICS.md to PDF

echo "Converting AI Co-Creation Ethics document to PDF..."

# Method 1: Using pandoc (if installed)
if command -v pandoc &> /dev/null; then
    echo "Using pandoc..."
    pandoc AI_CO-CREATION_ETHICS.md \
        -o AI_CO-CREATION_ETHICS.pdf \
        --pdf-engine=xelatex \
        -V geometry:margin=1in \
        -V fontsize=11pt \
        -V documentclass=article \
        --toc \
        --toc-depth=2
    echo "✓ PDF created: AI_CO-CREATION_ETHICS.pdf"
    exit 0
fi

# Method 2: Using grip + wkhtmltopdf (if installed)
if command -v grip &> /dev/null && command -v wkhtmltopdf &> /dev/null; then
    echo "Using grip + wkhtmltopdf..."
    grip AI_CO-CREATION_ETHICS.md --export AI_CO-CREATION_ETHICS.html
    wkhtmltopdf AI_CO-CREATION_ETHICS.html AI_CO-CREATION_ETHICS.pdf
    rm AI_CO-CREATION_ETHICS.html
    echo "✓ PDF created: AI_CO-CREATION_ETHICS.pdf"
    exit 0
fi

# Method 3: Instructions for manual conversion
echo ""
echo "No PDF converter found. Install one of:"
echo ""
echo "Option 1 (Recommended): pandoc + LaTeX"
echo "  brew install pandoc"
echo "  brew install --cask basictex"
echo "  Then run: pandoc AI_CO-CREATION_ETHICS.md -o AI_CO-CREATION_ETHICS.pdf"
echo ""
echo "Option 2: grip + wkhtmltopdf"
echo "  pip install grip"
echo "  brew install wkhtmltopdf"
echo ""
echo "Option 3: Online converters"
echo "  https://www.markdowntopdf.com/"
echo "  https://md2pdf.netlify.app/"
echo ""
echo "Option 4: VS Code extension"
echo "  Install 'Markdown PDF' extension"
echo "  Open AI_CO-CREATION_ETHICS.md"
echo "  Right-click -> Markdown PDF: Export (pdf)"
echo ""
echo "Option 5: Print from browser"
echo "  Open AI_CO-CREATION_ETHICS.md in VS Code or GitHub"
echo "  Preview markdown"
echo "  Print to PDF"
