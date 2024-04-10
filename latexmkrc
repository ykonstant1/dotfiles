$pdf_mode = 1;
$silent   = 1;
$aux_dir  = "./.aux";
$out_dir  = "./out";
$lualatex = "lualatex -file-line-error %O %S";
$pdflatex = "lualatex -file-line-error %O %S"; #for compatibility with borked versions

# $pdf_mode explanation:
#   If zero, do NOT generate a pdf version of the document. If equal to 1, generate a pdf version of
#   the document using pdflatex, using the command specified by the $pdflatex variable. If equal to 2,
#   generate a pdf version of the document from the ps file, by using the command specified by the
#   $ps2pdf variable. If equal to 3, generate a pdf version of the document from the dvi file, by using
#   the command specified by the $dvipdf variable. If equal to 4, generate a pdf version of the docu-
#   ment using lualatex, using the command specified by the $lualatex variable. If equal to 5, gener-
#   ate a pdf version (and an xdv version) of the document using xelatex, using the commands speci-
#   fied by the $xelatex and xdvipdfmx variables.
#   In $pdf_mode=2, it is ensured that .dvi and .ps files are also made. In $pdf_mode=3, it is ensured
#   that a .dvi file is also made.  But this may be overridden by the document.
