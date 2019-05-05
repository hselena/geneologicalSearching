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

children = relation[,2]
print(length(children))
parentID = c()
childID = c()
NewID = total[nrow(total),1]
count = 0
num = 0
i = 1
time1 = Sys.time()
while (i <= length(children)) {
  count = count + 1 
  if(relation[i,2] == relation[i+1,2]){ #if this child has 2 parents, parents into vector, and child variable 
    parents = c(relation[i,1], relation[i+1,1])
    child = relation[i,2]
    print(parents)
    print(child)
    i = i + 1 
  } else{ # this child has one parent 
    NewID = as.numeric(NewID) + 1 
    parents = c(NewID, relation[i,1])
    child = relation[i,2]
    newrow = c(NewID, "unknown", NA, NA)
    total = rbind(total, newrow)
    print(parents)
    print(child)
  } 
  for( x in parents){
    sex = total[as.character(x),2]
    print(sex)
    if(!is.na(sex) && sex == "female"){
      #momID 
      total[as.character(child), 4] = x
    } else if (!is.na(sex) && sex == "male") {
      #dadID 
      total[as.character(child),3] = x 
    } else { 
      num = num + 1
      parentID[num] = x 
      childID[num] = child
    }
  } 
  i = i +1 
  if (count%%200 == 0){ # 
    time2 = Sys.time()
    print(time2 - time1)
    count = 0 
    print(paste("ID: ", children[i]))
    print(paste("parents: ", parents))
  }
 
}#end while  
  


print("on to non gendered parents")
count = 0
time1 = Sys.time()
for (i in 1:length(childID)){
  count = count + 1 
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

