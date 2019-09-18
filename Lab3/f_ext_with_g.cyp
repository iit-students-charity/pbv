match (gg {name: "Моўная група"})<-[:is]-(g)<-[:is]-(n)-[:is]->(ext {name: "Мёртвая мова"})
return gg, g, n, ext
