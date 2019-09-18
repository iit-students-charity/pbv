match (nos)<-[:num_of_speakers]-(n)-[:is]-(g)
where not (n)-[:is]-(:class {name: "Адраджаемая мова"})
return nos, n, g
