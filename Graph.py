import networkx as nx
import matplotlib.pyplot as plt

G = nx.Graph(day="Friday")
G.graph
G.graph['day']='Monday'
G.graph

familytxt = open("samp_profiles.txt", "r")
readtxt   = familytxt.readline()

#print(readtxt)
#i want to print the lines of my file line by line
profiles= [] #[row(person),column(information of the person)]
for line in familytxt:
    linesp = line.split()
    profiles.append(linesp)
    #profiles = profiles,linesp
    #add profiles i and increment
    #print(linesp)

id=[]
for i in profiles:
    id.append(i[0])


for i in range(0, len(id)):
    id[i] = int(id[i])
   # print(id)

genderlist=[]
for i in profiles:
    genderlist.append(i[1])

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




relationtxt = open("samp_relations.txt", "r")
readline    = relationtxt.readline()
#print(readline)

relations = []
for line in relationtxt:
    lines = line.split()
    relations.append(lines)

#for i in range(0,len(relations)):
 #   relations[i] = int(relations[i])

#intrelations = list(map(int,relations))
#intrelations = [int(i) for i in relations]





#print(profiles)

#tree = nx.read_edgelist('samp_relations.txt',create_using=nx.Graph(),nodetype=int)
#print nx.info(tree)
tree = nx.Graph()
tree.nodes
#creaing nodes
tree.add_node(id[0], gender = 'male') #gender = genderlist[0]
list(tree.nodes)
tree.add_node(id[1])
tree.add_node(id[2])
tree.add_node(id[3])
tree.add_node(id[4])


#use that same reference to connect the nodes
tree.add_edge(id[0],id[2])
tree.add_edge(id[0],id[3])
tree.add_edge(id[0],id[4])
tree.add_edge(id[1],id[2])
tree.add_edge(id[1],id[3])
tree.add_edge(id[1],id[4])
#tree.add_edges_from(relations)

nx.set_node_attributes(tree,genderlist,'gender')
nx.set_node_attributes(tree,isalive,'living/dead')
nx.set_node_attributes(tree,residence,'residence')
nx.set_node_attributes(tree,birthyr,"birthyear")

#NodeDataView(tree.nodes[1]['gender'])


nx.draw(tree,with_labels=True, font_weight='bold')

#labels= dict(id)
#print(labels)

#nx.draw_networkx_labels(G,pos=nx.spring_layout(G))

#plt.show()
#tree.add_nodes_from(profiles)
#tree.add_edges_from(relations)


#so this is not as simple as it seems but i think i can learn to use this tool to my advantage

#create a function to have the nodes created from a text file and then the relations.

#right now work on how attributes are added onto the nodes to save information with them
