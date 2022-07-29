# https://towardsdatascience.com/create-a-graph-database-in-neo4j-using-python-4172d40f89c4
from neo4j import GraphDatabase, Driver
import pandas as pd
import json
import time

class Neo4jConnection:
    
    def __init__(self, uri, user, pwd):
        self.__uri = uri
        self.__user = user
        self.__pwd = pwd
        self.__driver = None
        try:
            self.__driver = GraphDatabase.driver(self.__uri, auth=(self.__user, self.__pwd))
        except Exception as e:
            print("Failed to create the driver:", e)
        
    def close(self):
        if self.__driver is not None:
            self.__driver.close()
        
    def query(self, query, parameters=None, db=None):
        assert self.__driver is not None, "Driver not initialized!"
        session = None
        response = None
        try: 
            session = self.__driver.session(database=db) if db is not None else self.__driver.session() 
            response = list(session.run(query, parameters))
        except Exception as e:
            print("Query failed:", e)
        finally: 
            if session is not None:
                session.close()
        return response


def add_persons(conn, rows, batch_size=10000):
    query = '''
            UNWIND $rows AS row
            MERGE (:Person {name: row.name, born: row.born})
            RETURN count(*) as total
            '''
    return insert_data(conn,query, rows, batch_size)

def add_movies(conn, rows, batch_size=10000):
    query = '''
            UNWIND $rows AS row
            MERGE (:Movie {title: row.title, released: row.released, tagline: row.tagline})
            RETURN count(*) as total
            '''
    return insert_data(conn, query, rows, batch_size)

def add_actors(conn, rows, batch_size=5000):
   query = '''
   UNWIND $rows as row
   MATCH (m:Movie {title: row.title})
   MATCH (p:Person {name: row.name})
   MERGE (p)-[:ACTED_IN {roles:[row.roles]}]->(m)
   RETURN count(*) as total
   '''
   #  (Keanu)-[:ACTED_IN {roles:['Neo']}]->(TheMatrix),
       
   return insert_data(conn, query, rows, batch_size)

def insert_data(conn,query, rows, batch_size = 10000):
    # Function to handle the updating the Neo4j database in batch mode.
    
    total = 0
    batch = 0
    start = time.time()
    result = None
    
    while batch * batch_size < len(rows):

        res = conn.query(query, 
                         parameters = {'rows': rows[batch*batch_size:(batch+1)*batch_size].to_dict('records')})
        total += res[0]['total']
        batch += 1
        result = {"total":total, 
                  "batches":batch, 
                  "time":time.time()-start}
        print(result)
        
    return result

            
if __name__ == '__main__':
    conn = Neo4jConnection(uri="bolt://neo4j:7687", 
                        user="neo4j",              
                        pwd="pass")

    # delete all
    conn.query('MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n,r')
                
    persons=[{'name':'Keanu Reeves','born':1964},{'name':'Carrie-Anne Moss','born':1967},{'name':'Laurence Fishburne','born':1961}]
    columns =['name','born']
    df = pd.DataFrame(data=persons,columns=columns)
    add_persons(conn,df)

    movies=[
        {'title':'The Matrix','released':1964,'tagline':'Welcome to the Real World'},
        {'title':'The Matrix Reloaded','released':2003,'tagline':'Free your mind'},
        {'title':'The Matrix Revolutions','released':2003,'tagline':'Everything that has a beginning has an end'},
            ]
    columns =['title','released','tagline']
    df = pd.DataFrame(data=movies,columns=columns)
    add_movies(conn,df)

    actors=[
        {'title':'The Matrix','name':'Keanu Reeves','roles':'neo'},
        {'title':'The Matrix','name':'Carrie-Anne Moss','roles':'Trinity'}
    ]
    columns =['title','name','roles']
    df = pd.DataFrame(data=actors,columns=columns)
    print(df)
    add_actors(conn,df)
