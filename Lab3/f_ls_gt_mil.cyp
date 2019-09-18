match (gg)<-[:is]-(ls)<-[:unesco_ls]-(n)-[:num_of_speakers]->(nos)
where nos.value > 1000000
return gg, ls, n, nos
