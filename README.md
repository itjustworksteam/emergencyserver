# Emergency Numbers Server #

[![Build Status](https://travis-ci.org/itjustworksteam/emergencyserver.svg?branch=master)](https://travis-ci.org/itjustworksteam/emergencyserver)

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

GET ```/api/all```

For example:

Request: GET ```/api/all```

Response:

```
[ 
    { "name":"Switzerland", "code":"CH", "police":"112", "medical":"144", "fire":"118" },
    { "name":"Italy", "code":"IT", "police":"112", "medical":"118", "fire":"115"}
]
```
