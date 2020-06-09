# Docker PHP

## Introduction

Package with prepared environment to run your PHP applications in docker containers.

This package contains PHP (5.6, 7.1, 7.2, 7.4) + Apache , MySQL and Adminer images. The package uses docker-compose tool 
and whole environment is started with it.

This package also contains Blackfire for better profiling your application and Selenium for running acceptance tests. 

## Contributing

If you find a bug or this package does not work at all on you machine, please create an issue and describe your problem. If
you successfully fixed that bug, please send a pull request. 

If you have some ideas, how to improve this package, please create an issue also.

## Installation

### Requirements

Docker and Docker-compose are required.

### Installation

#### Linux

In root folder of your project run this command to install your dependencies. 
More information [here](https://hub.docker.com/r/library/composer/)
```bash
docker run --rm --interactive --tty --volume $PWD:/app composer require --dev artemevsin/docker-php
```

### Configuration

Create new .env file (or existing one if exists) in root folder. You can use these variables to define your configuration.

- PROJECT_NAME=myproject
- PHP_VERSION=7
- DOCUMENT_ROOT=/www

With default configuration your application will be available on http://myproject.local.

### Usage
In root folder of your project run
```bash
vendor/bin/docker-php
```

#### MySQL
You can access MySQL DB from your app with this config:
```
host: mysql
user: dev
pass: dev
```

#### Blackfire
If you want to use Blackfire you can put your credentials to .env like:
```
BLACKFIRE_SERVER_ID=xxx
BLACKFIRE_SERVER_TOKEN=xxx
```

#### Selenium tests

For running acceptance tests with codeception you should put something like this in your acceptance.suite.yml:
```yaml
actor: AcceptanceTester
modules:
    enabled:
        - WebDriver
        - \Helper\Acceptance
    config:
      WebDriver:
        url: 'http://myproject.local/'
        host: chrome
        port: 4444
        browser: chrome
```

Tests are started using this command:
```bash
docker exec -it myproject_webserver_1 php vendor/bin/codecept run acceptance
```

## Credits

Created by Artem Evsin

## Contact

You can contact me by sending email to artem@evsin.cz.

## License

This project is licensed under MIT license.