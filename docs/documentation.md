# Documentation for the webhooks. 

## Gems
[https://github.com/lynndylanhurley/devise_token_auth](Devise token Auth) gem is used to add token based authentication

## Api End points
### Sign up user 

*Request*

URL `POST /auth`

Body
```
{
  "email": "test@email.com",
  "password": "password",
  "password_confirmation": "password"
}
```

*Response*

Body 

```
{
    "status": "success",
    "data": {
        "id": 2,
        "provider": "email",
        "uid": "test2@email.com",
        "allow_password_change": false,
        "name": null,
        "nickname": null,
        "image": null,
        "email": "test2@email.com",
        "created_at": "2022-01-20T15:59:05.115Z",
        "updated_at": "2022-01-20T15:59:05.304Z"
    }
}
```

Headers

- access-token
- token-type
- client
- expiary
- uid