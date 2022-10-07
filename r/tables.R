library(tidyverse)
library(stargazer)

# Create comparison tables
meth <- full_join(ethic_meth, maarc_meth, by = "county")
bup <- full_join(ethic_bup, maarc_bup, by = "county")
nal <- full_join(ethic_nal, maarc_nal, by = "county")

meth_table <- stargazer(meth, summary=FALSE, type='text', 
          title = "Methadone Locations by County, Southern IL",
          out = "figures/meth_table.txt")

bup_table <- stargazer(bup, summary=FALSE, type='text', 
          title = "Buprenorphine Locations by County, Southern IL")

nal_table <- stargazer(nal, summary=FALSE, type='text',
          title = "Naltrexone Locations by County, Southern IL")
