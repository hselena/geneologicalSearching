setwd("~/FamilialSearch/familinix")
if(!require(kinship2)) install.packages("kinship2",repos = "http://cran.us.r-project.org")
ID_gender <- read.csv(file = "IDandGender.txt", header = T, sep = " ", stringsAsFactors = FALSE)
 
relation = read.csv( file ="child_parent.txt", header = T, sep = "\t")

print("relations-anon.txt done")
ID_gender[which(ID_gender[,2] == "*"), 2 ] = "unknown"
parentIDs = matrix(-1, nrow = length(ID_gender[,1]), ncol = 2)
kinshipformatDF = cbind(ID_gender, parentIDs)
colnames(kinshipformatDF) <- c("ID","gender" ,"FatherID", "MotherID")

#another matrix of empty rows for new IDs created 
 
newIDs = matrix(c(NA,"unknown", NA, NA), nrow = 1943863, ncol = 4, byrow = TRUE)
newIDs[,1] = 86127513:88071375
colnames(newIDs) <- c("ID","gender" ,"FatherID", "MotherID")

#combine matrix for newIDs and kinshipformatDF 
kinshipformatDF = rbind(kinshipformatDF, newIDs)


children = relation[,2]
parentID = c()
childID = c()
newIDcounter = 86127512
count = 0
num = 0
i = 1
time1 = Sys.time()
while (i <= (children)) { #length(children)
  count = count + 1 
  #if this child has 2 parents, parents into vector, and child variable 
  if(relation[i,2] == relation[i+1,2]){ 
    parents = c(relation[i,1], relation[i+1,1])
    child = relation[i,2]
    i = i + 1 
  } 
  # this child has one parent 
  else{ 
    child = relation[i,2]
    otherParent = newIDcounter +1 
    parents = c(otherParent, relation[i,1])
  } 
  #finding the sex of the parents
  for( x in parents){
    sex = total[x,2]#total[as.character(x),2]
    if(!is.na(sex) && sex == "female"){
      #momID 
      total[child,4] = x#total[as.character(child), 4] = x
    } else if (!is.na(sex) && sex == "male") {
      #dadID 
      total[child,3] = x 
    } else { 
      #num = num + 1
      parentID = c(parentID, x)#[num] = x 
      childID = c(childID, child)#[num] = child
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
  


write.table(total, "~/Cynthia/familinix_data.txt", sep = "\t")

