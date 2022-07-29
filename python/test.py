# https://rinoguchi.net/2020/03/neo4j-python-subgraph.html
#  :play movie-graph
from neo4j import GraphDatabase, Driver

p1="Kevin Bacon"
p2="Meg Ryan"

query: str = """
MATCH p=shortestPath(
(bacon:Person {name:"%s"})-[*]-(meg:Person {name:"%s"})
)
RETURN length(p)
""" % (p1,p2)

driver: Driver = GraphDatabase.driver('bolt://localhost:7687', auth=('neo4j', 'pass'), encrypted=False)
with driver.session() as session:
	with session.begin_transaction() as tx:
		for row in tx.run(query):
			print(row['length(p)'])

session = driver.session()
v_name = 'Keanu Reeves'
result = session.run("MATCH (a:Person { name : '%s'})-[r:ACTED_IN]->(b) RETURN a.name,type(r) AS Type, b.title" % (v_name))

for record in result:
	print("%s-%s->%s " % (record["a.name"], record["Type"], record["b.title"]))
