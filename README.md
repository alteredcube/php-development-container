# Docker PHP development
SImple docker container to assist with local php development. The container features NGINX, the latest PHP, Mariadb, Redis, PhpMyAdmin and of course NodeJS for NPM and Composer for php


>❗NOTE
>
> This container is NOT meant for production usage, please do not use it for such. The environment is optimized for development and should only be used for such.


# Getting started
1. Make sure you have docker & docker compose installed
2. Execute a simple `docker compose up` and wait
3. Start developing your app in `./app/www/public`

The contents of `./app/www/public` will be available on `http://localhost` PhpMyAdmin will be available on `http://localhost:8080`

Happy developing!

*note: See FAQ for composer, npm and database usage

# FAQ

## How do I use redis?
First step is to uncomment the redis section in the `docker-compose.yml` file and you are ready to go! In your php you can use the host `redis` as a host connection parameter for the redis connection.

## How do I execute composer commands?
Execute the following command: 
`docker compose exec php composer *composer command / arguments here*`


## How do I execute nodejs /npm commands?
Same as the above! Just replace composer with `node` or `npm` so the command could be: `docker compose exec php npm install`


## How do I connect to MySQL from my PHP script?
There is a database called `development` which is automatically created for you. You can access it with the following settings:

host: `database`
username: `development`
password: `development`

Your PDO code could look like this:
```php
$pdo = new \PDO('mysql:dbname=development;host=database', 'development', 'development');
```
