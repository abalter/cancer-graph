#!/bin/bash

Rscript -e "rmarkdown::render('gdsc_data_download.Rmd')"
Rscript -e "rmarkdown::render('gdsc_data_harmonization.Rmd')"
Rscript -e "rmarkdown::render('gdsc_data_upload.Rmd')"
