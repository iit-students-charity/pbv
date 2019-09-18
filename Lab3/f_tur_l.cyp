match (m)<-[:is]-(tur_lg {name: "Цюркская моўная група"})<-[:is]-(n)-[:num_of_speakers]->(nos)
return m, tur_lg, n, nos
