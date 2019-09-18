match (a)<-[*]-(b)<-[*]-(l {name: "Адыгейская мова"})-[*]->(c)
return a, b, c, l
