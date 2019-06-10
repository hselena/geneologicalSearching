setwd("~/FamilialSearch/familinix")
ID_gender <- read.csv(file = "IDandGender.txt", header = T, sep = " ", stringsAsFactors = FALSE)
print("IDandGender.txt done ")
relation = read.csv( file ="child_parent.txt", header = T, sep = "\t", nrows = 25)
print("child_parent.txt done")

ID_gender[which(ID_gender[,2] == "*"), 2 ] = "unknown"
parentIDs = matrix(-1, nrow = length(ID_gender[,1]), ncol = 2)
kinshipformatDF = cbind(ID_gender, parentIDs)
colnames(kinshipformatDF) <- c("ID","gender" ,"FatherID", "MotherID")
print("kinshipformatDF created")

#another matrix of empty rows for new IDs created 
newIDs = matrix(c(NA,"unknown", NA, NA), nrow = 1943863, ncol = 4, byrow = TRUE)
newIDs[,1] = 86127513:88071375
colnames(newIDs) <- c("ID","gender" ,"FatherID", "MotherID")
print("1943863 newIDs created")

#combine matrix for newIDs and kinshipformatDF 
kinshipformatDF = rbind(kinshipformatDF, newIDs)
print("kinshipformatDF rbind w/ newIDs")

children = relation[,2]
newIDcounter = 86127512
i = 1
time1 = Sys.time()
count = 0

while (i <= length(children)) { 
  #count = count + 1 
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
    parents = c(relation[i,1], otherParent)
    # only the gender of one parent is known 
    if (kinshipformatDF[as.numeric(parents[1]),2] == "female"){
      kinshipformatDF[as.numeric(parents[2]),2] = "male"
      print("first parent gender is female")
      print(kinshipformatDF[as.numeric(parents[2]),2])
    } else{ 
      kinshipformatDF[as.numeric(parents[2]),2] = "female"
      print("first parent gender is male")
      print(kinshipformatDF[as.numeric(parents[2]),2])
    }
  } 
  print(paste("the child is: ", child))
  print(paste("parents are: ", parents))
  #finding the sex of the parents
  for( x in parents){
    print("assinging them to either MotherID or FatherID")
    sex = kinshipformatDF[as.numeric(x),2]
    print(sex)
    if (sex == "female"){
      # MOM ID 
      kinshipformatDF[as.numeric(child),4] = x
      print(paste("should be motherID", kinshipformatDF[as.numeric(child),4]))
    } else{
      # DAD ID
      kinshipformatDF[as.numeric(child),3] = x
      print(paste("should be fatherID", kinshipformatDF[as.numeric(child),3]))
    }
  } 
  i = i +1 
  print(paste("i is: ", i))
}
#end while  

if (count%%20 == 0){ # 
  time2 = Sys.time()
  print(time2 - time1)
  count = 0 
  print(paste("ID: ", children[i]))
  print(paste("parents: ", parents))
}
write.table(kinshipformatDF, "~/Cynthia/kinshipformat.txt", sep = "\t")

