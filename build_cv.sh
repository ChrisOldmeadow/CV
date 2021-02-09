#!/bin/bash

#=====================================================================
#          FILE:  build_cv.sh
#         USAGE:  Run manually to generate my CV
#   DESCRIPTION:  Uses Pandoc to pull together Markdown documents
#                 & process them with Pandoc to generate my CV
#        AUTHOR:  Scott Granneman (RSG), scott@ChainsawOnATireSwing.com
#       VERSION:  0.3
#       CREATED:  2013-05-11 11:50:30 CDT
#      REVISION:  2018-07-01 12:45:01 CDT
#=====================================================================

###
## Variables
#

# Directory for CV
cvDir=/home/chris/CV

# Directory for CV Builds
cvBuildDir=/home/chris/CV/Builds

# Name of the CV file
cvName="Chris_Oldmeadow-CV-$(date +%Y-%m-%d)"


###
## Update the biobliography
#

pybtex-format oldmeadow.bib ./Builds/publications.html
# delete the first 6 lines of header
sed '1,6d' ./Builds/publications.html
echo '<h2>Publications</h2>' | cat - Builds/publications.html > temp && mv temp Builds/publications.html



###
## Update the funding 
#

rm Builds/funding.html
echo '<h2>Competative Funding</h2>' > Builds/funding.html
R < get_funding.R --no-save

###
## Create HTML files for each Markdown file
#

for i in $(ls $cvBuildDir/*md) ; do
  echo $i
  # Get the name of the file, sans extension, for generating HTML file
  cvBuildName=$(basename "$i" .md)
  # Convert to HTML
  pandoc --section-divs -f markdown -t html5 -o $cvBuildDir/$cvBuildName.html $i
done

###
## Join the HTML files into one HTML CV
#

pandoc --metadata title=" " --standalone -c $cvBuildDir/cv_style.css --section-divs -f markdown -t html5 \
-o "$cvDir/$cvName.html" \
-A $cvBuildDir/summary.html \
-A $cvBuildDir/education.html \
-A $cvBuildDir/employment.html \
-A $cvBuildDir/supervision.html \
-A $cvBuildDir/community.html \
-A $cvBuildDir/collaboration.html \
-A $cvBuildDir/funding.html \
-A $cvBuildDir/publications.html \
$cvBuildDir/cv.html

###
## Convert the HTML CV into PDF CV
#

#pandoc -H $cvBuildDir/tex_style.tex "$cvDir/$cvName.html" -o "$cvDir/$cvName.pdf"

