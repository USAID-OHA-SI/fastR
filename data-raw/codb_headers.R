#FAST sheet "6 CODB-E" headers have too many issues to import automatically -> define

#header list to apply to df
codb_headers <- c("operatingunit",
                  "cop",
                  "fundingagency_official_drop",
                  "fundingsource_drop",
                  "budget_code",
                  "costtype",
                  "techarea_drop",
                  "blank_1_drop",
                  "blank_2_drop",
                  "blank_3_drop",
                  "fundingagency",
                  "description_drop",
                  "amt",
                  "fte_drop",
                  "appliedpipeline",
                  "blank_4_drop",
                  "initiative_type_drop",
                  "keep_amt_drop")



#save
save(codb_headers, file = "data/codb_headers.rda")

rm(codb_headers)
