match (l)-[:unesco_ls]->(ls), (l)-[:num_of_speakers]->(nos), (l)-[:is]->(gg)
where (gg)-[:is]->(:class {name: "Моўная група"}) and nos.value > 300000 and nos.value < 5000000
return l, ls, gg
