# Docker PHP

## Introduction

Package with prepared environment to run your PHP application in docker containers.

This package contains PHP+APACHE, MySQL and Adminer images. The package uses docker-compose tool and whole environment
is started with it. 

## Usage

```bash
# On linux
> vendor/bin/run_local.sh

# On Windows
> vendor\bin\run_local.bat
```

## Contributing

If you find a bug or this package does not working for you at all, please create an issue and describe your problem. If
you successfully fixed that bug, please send a pull request. 

If you have some ideas, how to improve this package, please create an issue also.

## Installation

### Requirements

You should have installed docker or docker-toolbox on your machine. 

### Installation

#### Linux

In root folder of your project run this command to install your dependencies. 
More information [here](https://hub.docker.com/r/library/composer/)
```bash
> docker run --rm --interactive --tty --volume $PWD:/app composer require --dev artemevsin/docker-php
```

#### Windows

First of all ou should set `bin-compat` to `full` in your composer.json config section. So it should look like this:
```json
{
    "name": "john/doe",
    "authors": [
        {
            "name": "John Doe",
            "email": "john@doe.com"
        }
    ],
    "config": {
        "bin-compat": "full"
    },
    "require": {
        "artemevsin/docker-php": "v0.0.3"
    }
}
```

This setting is necessary to ensure, that composer will create .bat file in your vendor/bin folder, even you run 
`composer install` under linux (in container).   

For windows there are some short .bat scripts, that you can find in /bin folder. Download this folder to your project 
root folder and run bin\composer-install.bat

If you do not want to download this scripts, you should follow this steps:
1. be sure, that your docker-machine status is 'Running'. You can check it with `docker-machine status` command. 
If your docker-machine stopped, run `docker-machine start` to start it
2. then setup your environment: `@FOR /f "tokens=*" %i IN ('docker-machine env') DO @%i`
3. run composer install like `docker run --rm -v /c/Users/myawesomeproject:/app composer/composer require --dev artemevsin/docker-php`

### Configuration

With default configuration your application will be available on http://default.docker. Please do not forget to add 
corresponding record to your `/etc/hosts` file.  

You can pass path to your own docker-compose.yml as first argument, like run_local.bat /c/Users/my-project/docker-compose.yml.

## Credits

Created by Artem Evsin

## Contact

You can contact me by sending email to artem@evsin.cz.

## License

This project is licensed under MIT license.