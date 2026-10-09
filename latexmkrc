# Konfiguracja latexmk: pdflatex + biber
@default_files = ('praca.tex');
$pdf_mode   = 1;
$pdflatex   = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$bibtex_use = 2;
$clean_ext  = 'bbl run.xml synctex.gz';
