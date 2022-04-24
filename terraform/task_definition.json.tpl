[
    {
        "essential": true,
        "memory": 256,
        "name": "worker",
        "cpu": 256,
        "image": "kheralalit/rearc:latest",
        "portMappings": [
         {
           "containerPort": 3000,
           "hostPort": 80
         }
        ],
        "environment": [
          {
            "name": "SECRET_WORD",
            "value": "DEVOPS"
          }
        ]
    }
]
