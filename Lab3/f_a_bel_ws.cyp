match (g)<-[:is]-(ws), (n {name: "Беларуская мова"})-[:num_of_speakers]->(nos)
where (ws)<-[:var_ws]-(n) or (ws)<-[:bas_ws]-(n)
return g, ws, n, nos
