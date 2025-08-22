;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "report"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("report" "12pt" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("amsmath" "") ("amssymb" "") ("graphicx" "") ("hyperref" "") ("geometry" "") ("titlesec" "")))
   (TeX-run-style-hooks
    "latex2e"
    "report1"
    "report2"
    "report3"
    "report4"
    "rep12"
    "inputenc"
    "amsmath"
    "amssymb"
    "graphicx"
    "hyperref"
    "geometry"
    "titlesec"))
 :latex)

