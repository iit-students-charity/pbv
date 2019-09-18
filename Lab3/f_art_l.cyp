match (gg)<-[:is]-(art {name: "Штучная мова"})<-[:is]-(c)<-[:is]-(n)
return gg, art, c, n
