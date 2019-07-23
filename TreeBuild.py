from numpy import *


familytxt = open("samp_profiles.txt", "r")
readtxt   = familytxt.readline()

#print(readtxt)
#i want to print the lines of my file line by line
profiles= [] #[row(person),column(information of the person)]
for line in familytxt:
    linesp = line.split()
    profiles.append(linesp)
    #tuple(profiles)
    #profiles = profiles,linesp
    #add profiles i and increment
    #print(linesp)

#print(profiles[0])
#print(profiles[0][0])

#creating an array to use when we store the node information

genderlist=[]
for i in profiles:
    genderlist.append(i[1])
#print(genderlist)

id=[]
for i in profiles:
    id.append(i[0])

isalive=[]
for i in profiles:
    isalive.append(i[2])

residence=[]
for i in residence:
    residence.append(i[3])

birthyr=[]
for i in birthyr:
    birthyr.append(i[4])

birthmth=[]
for i in birthmth:
    birthmth.append(i[5])

birthday=[]
for i in birthday:
    birthday.append(i[6])

#print(id)


#is there any way i can set the gender to an empty array of a certain size?

#okay so i with whatever text file i input i will be able to save the information of each thing on the node, but
#as of right now i cant do an individual person that has everything.

# i need help with making the nodes, i think that may be where my problem is
class nodes:
    def __init__(self, profileid = None , gender = None , is_alive=[], current_residence_location=None, birth_year=None, birth_month=None, birth_day=None):
        self.profileid = []
        self.gender = []
        self.is_alive = is_alive
        self.birth_year = birth_year
        self.current_residence_location = current_residence_location
        self.birth_month = birth_month
        self.birth_dat = birth_day
#do i need to make functions to set one specific value to one specific node , right now they are only reading in
        for i in genderlist:
            self.gender.append(i)

        #if self.is_alive == None:
        for i in isalive:
            self.is_alive.append(i)

        for i in id:
            self.profileid.append(i)
#def refer (self):
    #how can i call "self from init to my code


# i want it to individually assign to each node, how can i create a node with the profile information?

            #profile id one doesnt work and i dont know why









    #def setgender(self): #why doesnt it work in a function??
        #if self.profileid == None:
            #for i in id:
        #self.profileid = id[2]

        #if self.gender == None:
            #print("ha")
        #for i in self.gender:
         #   if self.gender == None:
          #      print ("ha")
        #self.gender= genderlist[2] # #how can i do this for every one?

        #if self.profileid == None:
         #   for i in id:
          #      self.profileid= id[i]


    #okayyyy so these didnt work but i feel like there will be an easier way to replace the array with
        #the ones that i made

#okay so right now the nodes have no setting to assign the specific thing to them
#i will do it manually then do it with functions tomorrow



#fam1.profileid = id[0]
#fam2.profileid = id[1]
#fam3.profileid = id[2]
#fam4.profileid = id[3]
#fam5.profileid = id[4]

#fam1.gender = genderlist[0]
#fam2.gender = genderlist[1]
#fam3.gender = genderlist[2]
#fam4.gender = genderlist[3]
#fam5.gender = genderlist[4]

#gettign and setting a part of the node?

#def getgender(self):
 #   return self.gender

#def setgender(self):
 #   if self.gender == None:
  #      for i in genderlist:
   #         self.gender = genderlist[i]


# need to reference the node in another way, create an array of the nodes and call them





relationtxt = open("samp_relations.txt", "r")
readline    = relationtxt.readline()
#print(readline)

relations = []
for line in relationtxt:
    lines=line.split()
    relations.append(lines)

#print(relations)

#okay i took this from roris code but i will use it for future use
#when reading in the lines, i assign the parentid variable to the first column and childid to the second so
#i can refer to it later on in my code
#for line in relationtxt:
 #   parentid = int(line.split()[0])
  #  childid = int(line.split()[1])



#MAKE THIS INTO A FUNCTION vvvv
#right now my nodes have the information that i need each profile

#but it is different than what i want, am i able to just create an empty node like fam 2?
#this shows me that the problem i have right now is the need to set one specific value to
#the specific node
fam1 = nodes() #self.profileid
fam2 = nodes() #why is this not referencing back?
fam3 = nodes()
fam4 = nodes()
fam5 = nodes(profiles[4])


print(fam2.gender)

print(fam2.profileid) #why does this not work but the gender does?

print(fam1.is_alive)

print (fam1) #idk what this means
