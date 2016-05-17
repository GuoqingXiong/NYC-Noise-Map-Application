
# coding: utf-8

# In[29]:

from pyspark.mllib.clustering import KMeans, KMeansModel
from numpy import array
from math import sqrt

# Load and parse the data
data = sc.textFile("s3://elasticbeanstalk-us-east-1-115132263887/hehe/data.txt")
parsedData = data.map(lambda line: array([float(x) for x in line.split("\t")]))

# Build the model (cluster the data)
clusters = KMeans.train(parsedData, 10, maxIterations=5,
        runs=3, initializationMode="random")

# Evaluate clustering by computing Within Set Sum of Squared Errors
def error(point):
    center = clusters.centers[clusters.predict(point)]
    return sqrt(sum([x**2 for x in (point - center)]))

WSSSE = parsedData.map(lambda point: error(point)).reduce(lambda x, y: x + y)
print("Within Set Sum of Squared Error = " + str(WSSSE))



# In[30]:

hehe=clusters.clusterCenters


# In[31]:

filename = "s3://elasticbeanstalk-us-east-1-115132263887/output/kmeansCentersCSV2.csv"
logfile = open(filename, "w")
i = 0
while i < len(hehe):
	line = hehe[i]
	writestring = "%s,%s\n" % (str(line[0]), str(line[1]))
	logfile.write(writestring)
	i += 1
logfile.close()


# In[ ]:



