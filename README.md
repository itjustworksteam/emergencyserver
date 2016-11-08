# Emergency Numbers Server #

## API ##

GET ```/api/:countryCode```

For example:

Request: GET ```/api/it``` or ```/api/IT```

Response: 

```
{"code":"IT","fire":"115","police":"113","name":"Italy","medical":"118"}
```

GET ```/api/:latitude/:longitude```

For example:

Request: GET ```/api/45.650433/9.197645```

Response:

```
{"code":"IT","fire":"115","police":"113","name":"Italy","medical":"118"}
```