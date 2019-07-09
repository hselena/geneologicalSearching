if(!require(tidyverse)) install.packages("tidyverse",repos = "http://cran.us.r-project.org")
setwd(~/Cynthia)
IDandGender <- read_delim("IDandGender.txt", delim=" ")
head(IDandGender)

system.time({
  tbl <- 
    read_tsv("child_parent.txt") %>% 
    left_join(IDandGender, by=c("parent" = "profileid" ))
})

tblUnknown <-
  tbl %>%
  rename( parentGender=gender) %>% 
  group_by( child ) %>% 
  filter( all(parentGender=='*') )

#both parents present and known 
tblknown <-
  tbl[tbl$child %in% tbl$child[duplicated(tbl$child)],] %>%
  rename( parentGender=gender) %>% 
  group_by( child ) %>% 
  filter( all(parentGender!='*'))

tblknown%>% 
  mutate(i = row_number()) %>% 
  spread(key = parentGender, value = parent) %>%
  # spread(key = parentGender, value = parent) %>% 
  left_join(IDandGender, by = c("child" = "profileid"))



while ( i <= length(tblknown[,2])){
  if(tblknown$child[i] == tblknown$child[i+1]){
    if(tblknown$parentGender[i] == tblknown$parentGender[i+1]){
    tblknown$parentGender[i] = "male"
    tblknown$parentGender[i+1] = "female"
    }
    i = i + 1 
  }
}

tblSemiknown <-
  tbl %>%
  rename( parentGender=gender) %>% 
  group_by( child ) %>% 
  filter( any(parentGender=='*') & any(parentGender!='*') )



write.table(tblknown, "~/Cynthia/tblknown.txt", sep = "\t")
# * -> Female 
# *, * -> Female, male 
# Male, * <- male, female 
#female, * = female, male 
# sort(c("*", "F")) * comes first 

#seperating into different catagories using the filter command
# before 2936 create a pedigree -- create it with kinship2 
# create IBD data with pedgiree package  