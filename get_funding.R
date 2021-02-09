
library(tidyverse)
library(kableExtra)
library(here)

dat <- read_csv(file = here("funding_oldmeadow.csv"))
num_amt <- readr::parse_number(dat$Amount)
tot <- sum(as.numeric(num_amt))

#Dr Oldmeadow has been awarded over `r scales::dollar(tot)` in competitive funding as chief investigator.


res <- dat %>%
    kable() %>%
    column_spec(2, width = "15em") %>%
    column_spec(3, width = "20em")

capture.output(res, file = "Builds/funding.html", append = TRUE)
