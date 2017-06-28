# Select distinct 
db.getCollection('schools').distinct('_id',{institution:1})

# Add a new attribute 
Here we are creating academic_year and currentTerm
```
Ex1:

db.getCollection('classes').update({},{$set:{academic_year:17,currentTerm:1}},{multi:true})

Ex2: 
db.getCollection('items').update({}, {$set : {side_dishes:[]}}, {multi:true}) 
```
