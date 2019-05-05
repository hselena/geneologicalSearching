setwd("~/Cynthia")
if(!require(kinship2)) install.packages("kinship2",repos = "http://cran.us.r-project.org")
fam_anon <- read.csv(file = "IDandGender.txt", header = T, sep = " ", stringsAsFactors = FALSE)
print("profiles-anon.txt done")
relation = read.csv( file ="child_parent.txt", header = T, sep = "\t")
print("relations-anon.txt done")
fam_anon[which(fam_anon[,2] == "*"), 2 ] = "unknown"
parentIDs = matrix(NA, nrow = length(fam_anon[,1]), ncol = 2)
total = cbind(fam_anon, parentIDs)
print("total matrix made")
write.table(total, "~/Cynthia/total.txt", sep = "\t")

children = unique(relation[,2])
print(length(children))
num = 0
parentID = c()
childID = c()
NewID = total[nrow(total),1]
count = 0
time1 = Sys.time()
for( i in 1:length(children)){
  count = count + 1 
  parents =  relation[which(relation[,2] == children[i]), 1]
  if (length(parents) == 1){
    NewID = NewID + 1 
    parents = append(parents, NewID)
    newrow = c(NewID, "unknown", NA, NA)
    total = rbind(total, newrow)
    rownames(total)[nrow(total)] = as.character(NewID)
  } 
  for ( x in parents){
    sex = total[as.character(x),2]
    if( sex == "female"){
      #momID 
      total[as.character(children[i]), 4] = x
    } else if (sex == "male") {
      #dadID 
      total[as.character(children[i]),3] = x 
    } else { 
      num = num + 1
      parentID[num] = x 
      childID[num] = children[i]
    }
    
  }
  if (count%%200 == 0){
    time2 = Sys.time()
    print(time2 - time1)
    count = 0 
    print(paste("ID: ", children[i]))
    print(paste("parents: ", parents))
  }
}

print("on to non gendered parents")
count = 0
for (i in 1:length(childID)){
  time1 = Sys.time()
  if (is.na(total[as.character(childID[i]), 4])){
    total[as.character(childID[i]), 4] = parentID[i]
    total[as.character(parentID[i]),2] = "female"
  } else{ 
    total[as.character(childID[i]),3] = parentID[i]
    total[as.character(parentID[i]),2] = "male"
  }
  if (count%%200 = 0){
    time2 = Sys.time()
    time2 - time1
    count = 0 
    print(paste("ID: ", childID[i]))
  }
}
print("parents are gendered")
write.table(total, "~/Cynthia/familinix_data.txt", sep = "\t")

