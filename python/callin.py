import pandas as pd
import sys
import iris

sys.path += ['/usr/irissys/lib/python','/usr/irissys/mgr/python']
sql="select name,born from Person"
df = iris.sql.exec(sql).dataframe()
print(df)