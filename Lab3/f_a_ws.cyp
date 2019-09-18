match (g)<-[:is]-(ws), (n)-[:unesco_ls]->(ls)
where (ws)<-[:var_ws]-(n) or (ws)<-[:bas_ws]-(n)
return g, ws, n, ls
