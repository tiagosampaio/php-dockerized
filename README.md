# PHP Dockerized

> Dockerized PHP development stack: Nginx, MySQL, MongoDB, PHP-FPM, HHVM, Memcached, Redis, Elasticsearch, RabbitMQ and Solr.

[![Build Status](https://travis-ci.org/tiagosampaio/php-dockerized.svg?branch=master)](https://travis-ci.org/tiagosampaio/php-dockerized)

PHP Dockerized gives you everything you need for developing PHP applications locally. The idea came from the need of having an OS-agnostic and virtualized alternative to the great [MNPP](https://github.com/jyr/MNPP) stack as regular LAMP stacks quite simply can't keep up with the Nginx + PHP-FPM/HHVM combo in terms of performance. I hope you'll find it as useful an addition to your dev-arsenal as I've found it!

## What's Inside

* [Nginx](http://nginx.org/)
* [PHP-FPM](http://php-fpm.org/)
* [MySQL](http://www.mysql.com/)

## What's Commented

* [MongoDB](http://www.mongodb.org/)
* [HHVM](http://www.hhvm.com/)
* [Memcached](http://memcached.org/)
* [Redis](http://redis.io/)
* [Elasticsearch](http://www.elasticsearch.org/)
* [RabbitMQ](https://www.rabbitmq.com/)
* [Solr](http://lucene.apache.org/solr/)

## Requirements

* [Docker Engine](https://docs.docker.com/installation/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Docker Machine](https://docs.docker.com/machine/) (Mac and Windows only)

## Running

Set up a Docker Machine and then run in background:

```sh
$ docker-compose up -d
```

That's it! You can now access your configured sites via the IP address of the Docker Machine or locally if you're running a Linux flavour and using Docker natively.

## License

Copyright &copy; 2016 [Tiago Sampaio](http://tiagosampaio.com). Licensed under the terms of the [MIT license](LICENSE.md).
