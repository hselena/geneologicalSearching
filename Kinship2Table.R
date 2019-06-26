setwd("~/Cynthia")
ID_gender <- read.csv(file = "IDandGender.txt", header = T, sep = " ", stringsAsFactors = FALSE)
print("IDandGender.txt done ")
relation = read.csv( file ="child_parent.txt", header = T, sep = "\t")
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
kinshipformatDF = rbind(kinshipformatDF, newIDs)-
print("kinshipformatDF rbind w/ newIDs")

children = relation[,2]
newIDcounter = 86127512
i = 1
count = 0
time1= Sys.time()

while (i <= length(children)) {
    count = count + 1
  if(relation[i,2] == relation[i+1,2]){ 
    parents = c(relation[i,1], relation[i+1,1])
    child = relation[i,2]
    i = i + 1 
    #if statement where you ask if parent 1 or parent 2 have unknown gender 
    if (kinshipformatDF[as.numeric(parents[1]),2] == "unknown" ||  kinshipformatDF[as.numeric(parents[2]),2] == "unknown"){
      #parent 1 has an unknown gender 
      if (kinshipformatDF[as.numeric(parents[1]),2] == "unknown"){
        #parent 2 is female then parent 1 is now male 
        if(kinshipformatDF[as.numeric(parents[2]),2] == "female"){ 
          kinshipformatDF[as.numeric(parents[1]),2] = "male"
          
        }
        #parent 2 is male then parent 1 is now female 
        else{ 
          kinshipformatDF[as.numeric(parents[1]),2] = "female"
        }
      }
      #parent 2 has an unknown gender
      else if (kinshipformatDF[as.numeric(parents[2]),2] == "unknown") {
        # parent 1 is female then parent 2 is male 
        if(kinshipformatDF[as.numeric(parents[1]),2] == "female"){
          kinshipformatDF[as.numeric(parents[2]),2] = "male"
        }
        #parent 1 is male then parent 2 is female 
        else{ 
          kinshipformatDF[as.numeric(parents[2]),2] = "female"
        }
      } 
      #both parents are unknown 
      else if (kinshipformatDF[as.numeric(parents[1]),2] == "unknown" &&  kinshipformatDF[as.numeric(parents[2]),2] == "unknown"){
        kinshipformatDF[as.numeric(parents[2]),2] = "female"
        kinshipformatDF[as.numeric(parents[1]),2] = "male"
      }
    } 
  } 
  # this child has one parent 
  else{ 
    child = relation[i,2]
    newIDcounter = newIDcounter +1 
    parents = c(relation[i,1], newIDcounter)
    # only the gender of one parent is known 
    if (kinshipformatDF[as.numeric(parents[1]),2] == "female"){
      kinshipformatDF[as.numeric(parents[2]),2] = "male"
    } else{ 
      kinshipformatDF[as.numeric(parents[2]),2] = "female"
    }
  } 
  #finding the sex of the parents
  for( x in parents){
    sex = kinshipformatDF[as.numeric(x),2]
    if (sex == "female"){
      # MOM ID 
      kinshipformatDF[as.numeric(child),4] = x
    } else{
      # DAD ID
      kinshipformatDF[as.numeric(child),3] = x
    }
  } 
  i =  i +1
  count = count + 1
  if (count%%1000 == 0){ #
    time2 = Sys.time()
    print(time2 - time1)
    count = 0 
    print(paste("ID: ", children[i]))
    print(paste("parents: ", parents))
    print(paste("this is i:", i))
  }
}
#end while  
write.table(kinshipformatDF, "~/Cynthia/kinshipformat.txt", sep = "\t")

