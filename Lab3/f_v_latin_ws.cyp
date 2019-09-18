match (lat_ws {name: "Лацініца"})<-[:var_ws]-(n)-[:is]-(m)
return lat_ws, n, m
