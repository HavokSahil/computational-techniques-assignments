;; -*- lexical-binding: t; -*-

(TeX-add-style-hook
 "report"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "12pt" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("graphicx" "") ("amsmath" "") ("geometry" "") ("float" "") ("caption" "") ("listings" "") ("xcolor" "")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art12"
    "graphicx"
    "amsmath"
    "geometry"
    "float"
    "caption"
    "listings"
    "xcolor"))
 :latex)

