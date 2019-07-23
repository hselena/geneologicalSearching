class node:
    def __init__(self, mom=None, dad=None, id=-1, children=None, birthyear=-1, sex=-1):
        self.mom = mom
        self.dad = dad
        self.id = id
        self.children = []
        self.birthyear = birthyear
        self.sex = sex
        if children is not None:
            for child in children:
                self.add_child(child)

    def __str__(self):
        return str(self.id)

    def add_child(self, child):
        assert isinstance(child, node)
        self.children.append(child)
        # def in_tree(self, targetid):
        #    self.rec_tree_search(self.mom, targetid)
        #    ?????


def intersection(lst1, lst2):
    lst3 = [value for value in lst1 if value in lst2]
    return lst3


# open profiles file
f = open("samp_profiles.txt", "r")
# read header
f.readline()
# initialize profiles array of arrays
profiles = [-1 for i in range(58 + 1)]
for line in f:
    linearr = line.split()
    profiles[int(linearr[0])] = line.split()
    print(profiles[5])
# open relations file
f = open("samp_relations.txt", "r")
# read header
f.readline()
# initialize array of individuals, indexed by id
indivs = [-1 for i in range(58 + 1)]
# read in each relationship, storing in pedigree
for line in f:
    parentid = int(line.split()[0])
    childid = int(line.split()[1])
    # if neither parent nor child are in pedigree, create new nodes
    if ((indivs[parentid] == -1) and (indivs[childid] == -1)):
        parnode = node(id=parentid)
        indivs[parentid] = parnode
        # print "pre children are "
        # for i in range(len(indivs[parentid].children)):
        #    print str(indivs[parentid].children[i])
        if (profiles[parentid][1] == "female"):
            childnode = node(id=childid, mom=parnode)
        else:
            childnode = node(id=childid, dad=parnode)
        indivs[childid] = childnode
        parnode.add_child(childnode)
        # print "post children are "
        # for i in range(len(indivs[parentid].children)):
        #    print str(indivs[parentid].children[i])
    # if parent is in pedigree, and child is not in pedigree
    elif (indivs[parentid] != -1 and indivs[childid] == -1):
        if (profiles[parentid][1] == "female"):
            childnode = node(id=childid, mom=indivs[parentid])
        else:
            childnode = node(id=childid, dad=indivs[parentid])
        indivs[childid] = childnode
        indivs[parentid].add_child(childnode)
    # if child is in pedigree, and parent is not
    elif (indivs[parentid] == -1 and indivs[childid] != -1):
        parnode = node(id=parentid, children=[indivs[childid]])
        indivs[parentid] = parnode
        if (profiles[parentid][1] == "female"):
            indivs[childid].mom = parnode
        else:
            indivs[childid].dad = parnode
            # print "**added dad to child "+str(childid)
            # print "**new parent relationshp between " + str(parentid) + " and " + str(childid) + "  " + str(
            #    parentid) + " with gender "+profiles[parentid][1]+" has kids "
            # for i in range(len(indivs[parentid].children)):
            #    print "   " + str(indivs[parentid].children[i]) + "'s dad is " + str(indivs[childid].dad)
    # if both parent and child are in pedigree
    elif (indivs[parentid] != -1 and indivs[childid] != -1):
        indivs[parentid].add_child(indivs[childid])
        if (profiles[parentid][1] == "female"):
            indivs[childid].mom = indivs[parentid]
        else:
            indivs[childid].dad = indivs[parentid]
            # print "added relationship between parent "+str(parentid)+" and "+str(childid)+ "  " + str(parentid) + " has kids "
            # for i in range(len(indivs[parentid].children)):
            #    print "   " + str(indivs[parentid].children[i]) + "'s dad is " + str(indivs[childid].dad)
# print indivs
# count full siblings (people with same mom and dad)
sibships = []
for i in range(1, 58 + 1):
    masibs = []
    # print "for i="+str(i)+", indiv " + str(indivs[i])
    # print indivs[i].mom
    if (indivs[i] != -1 and indivs[i].mom != None):
        # print "  "+str(indivs[i])+" has a mom"
        for j in range(len(indivs[i].mom.children)):
            masibs.append(indivs[i].mom.children[j].id)
            # print "   for i=" + str(i) + ", indiv " + str(indivs[i]) + "'s mom has " + str(len(masibs)) + " kids: " + str(indivs[i].mom.children[j].id)
    # print "for i=" + str(i) + ", indiv " + str(indivs[i]) + "'s mom has " + str(len(masibs)) + " kids: "
    # print "masibs are "; print(masibs)
    pasibs = []
    # if(indivs[i]!=-1): print "  cur id " + str(i) + "indivs i " + str(indivs[i]) + " indivs i's dad " + str(indivs[i].dad)
    if (indivs[i] != -1 and indivs[i].dad != None):
        for j in range(len(indivs[i].dad.children)):
            pasibs.append(indivs[i].dad.children[j].id)
            # print "  cur id " + str(i) + " pa id " + str(indivs[i].dad.id)
    # print "pasibs are "; print(pasibs)
    cursibs = intersection(masibs, pasibs)
    sibships.append(cursibs)
    # print "indiv " + str(indivs[i]) + " is in sibship of " + str(len(cursibs))
#an edit
