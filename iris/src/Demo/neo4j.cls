Class Demo.neo4j
{

ClassMethod Length(p1, p2) [ Language = python ]
{
from neo4j import GraphDatabase, Driver

query: str = """
MATCH p=shortestPath(
(bacon:Person {name:"%s"})-[*]-(meg:Person {name:"%s"})
)
RETURN length(p)
""" % (p1,p2)

driver: Driver = GraphDatabase.driver('bolt://neo4j:7687', auth=('neo4j', 'pass'), encrypted=False)
with driver.session() as session:
	with session.begin_transaction() as tx:
		for row in tx.run(query):
			return row['length(p)']
}

ClassMethod Path() [ Language = python ]
{
from neo4j import GraphDatabase, Driver

query: str = """
MATCH p=shortestPath(
(bacon:Person {name:"Kevin Bacon"})-[*]-(meg:Person {name:"Meg Ryan"})
)
RETURN p
"""

driver: Driver = GraphDatabase.driver('bolt://neo4j:7687', auth=('neo4j', 'pass'), encrypted=False)
with driver.session() as session:
	with session.begin_transaction() as tx:
		for row in tx.run(query):
			nodes = row["p"].nodes
			for node in nodes:
				print(node)
}

ClassMethod query() [ Language = python ]
{
	import iris
	import pandas as pd
	import movie
	sql="select name,born from Person"
	df = iris.sql.exec(sql).dataframe()
	print(df)
}

ClassMethod addmovies() [ Language = python ]
{
	from neo4j import GraphDatabase, Driver
	import iris
	import pandas as pd
	import neo4jwrapper as n

	conn = n.Neo4jConnection(uri="bolt://neo4j:7687", user="neo4j", pwd="pass")

    # delete all
	conn.query('MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r')

	sql="select name,born from Person"
	df = iris.sql.exec(sql).dataframe()
	print(df)
	n.add_persons(conn,df)

	sql="select title, released, tagline from Movie"
	df = iris.sql.exec(sql).dataframe()
	print(df)
	n.add_movies(conn,df)

	sql="SELECT title, name, roles FROM SQLUser.Person_Movie pm left outer join Person p on pm.Person=p.PID left outer join Movie m on pm.Movie=m.MID"
	df = iris.sql.exec(sql).dataframe()
	print(df)
	n.add_actors(conn,df)
}

}
