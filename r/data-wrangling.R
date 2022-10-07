# Set up 
library(tidyverse)
library(readxl)
library(stringr)

# Read in ETHIC MOUD location data
ethic_meth_raw <- read_xlsx("data/ethic-methadone.xlsx")
ethic_bup_raw <- read_xlsx("data/ethic-bup.xlsx")
ethic_nal_raw <- read.csv("data/ethic-naltrexone.csv")

# Read in MAARC MOUD location data, subset to IL
maarc_raw <- read.csv("~/Desktop/ETHIC Access/ethic-moud-access/data/us-wide-moudsCleaned_geocoded.csv")
str(maarc_raw)

##### MAARC data #####

# Clean data - filter for IL
maarc_moud <- maarc_raw %>% 
  filter(state == "IL")

# For county names, change first letter to uppercase and the rest to lower case
maarc_moud$countyName <- str_to_title(maarc_moud$countyName)

# Select only Southern IL counties of interest
counties <- c("Randolph", "Perry", "Franklin", "Hamilton", "White", "Jackson", "Williamson", 
              "Saline", "Gallatin", "Union", "Johnson", "Pope", "Hardin", "Alexander", "Pulaski", "Massac")

maarc_moud <- maarc_moud %>%
  filter(countyName %in% counties)

# Summarize count of providers by MOUD type and by county
maarc_meth <- maarc_moud %>% 
  filter(category == "methadone") %>%
  group_by(county = countyName) %>%
  summarise(maarcCount = n())

maarc_bup <- maarc_moud %>%
  filter(category == "buprenorphine") %>%
  group_by(county = countyName) %>%
  summarise(maarcCount = n())

maarc_nal <- maarc_moud %>%
  filter(category == "naltrexone/vivitrol") %>%
  group_by(county = countyName) %>%
  summarise(maarcCount = n())

##### ETHIC data #####

# For county names, change first letter to uppercase and the rest to lower case
ethic_bup_raw$County <- str_to_title(ethic_bup_raw$County)
ethic_meth_raw$county <- str_to_title(ethic_meth_raw$county)
ethic_nal_raw$county <- str_to_title(ethic_nal_raw$county)

# Select only Southern IL counties of interest
ethic_bup2 <- ethic_bup_raw %>%
  filter(County %in% counties)

ethic_meth2 <- ethic_meth_raw %>%
  filter(county %in% counties)

ethic_nal2 <- ethic_nal_raw %>%
  filter(county %in% counties)

# Summarize count of providers by MOUD type and by county
ethic_bup <- ethic_bup2 %>%
  group_by(county = County) %>%
  summarise(ethicCount = n())

ethic_meth <- ethic_meth2 %>%
  group_by(county) %>%
  summarise(ethicCount = n())

ethic_nal <- ethic_nal2 %>%
  group_by(county) %>%
  summarise(ethicCount = n())
