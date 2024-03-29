
# Snakefile: syllabus
#
# contributor: @lachlandeer
#
#

# --- Libraries --- #
import os, re

# --- Variable Declarations --- #
OUTPUT = "syllabus.pdf"

runR = "Rscript --no-save --no-restore --verbose"
logAll = "2>&1"

## --- Build Rules --- ##

rule build_pdf:
    input:
        styleFile = "svm-latex-syllabus.tex",
        syllabus  = "syllabus.Rmd",
        runner = "knit_rmd.R"
    output:
        pdf = OUTPUT
    log:
        "logs/syllabus.Rout"
    shell:
        "{runR} {input.runner} {input.syllabus} \
                    {output.pdf} > {log} {logAll}"

rule clean_:
    shell:
        "rm {OUTPUT}"

## install_packages   : installs missing R packages
rule install_r_packages:
    input:
        script = "install_r_packages.R",
        requirements = "REQUIREMENTS.txt"
    shell:
        "Rscript {input.script}"
