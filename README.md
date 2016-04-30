# Run your own outbound SMTP server with Haraka.

Login to your (i assume ubnutu based) server:

ssh -A root@example.com

## Install docker and docker-compose:
```sh
wget -qO- https://get.docker.com/ | sh
wget -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m`
chmod +x /usr/local/bin/docker-compose
```

## Fork and pull this repo:

git clone git@github.com:username/haraka-relay

## Generate TLS certificate

Run the following command to generate a self signed certificate. It will ask you
questions, and it's important that you enter the hostname of your server for the FQDN.

```sh
openssl req -x509 -nodes -days 2190 -newkey rsa:2048 \
      -keyout config/tls_key.pem -out config/tls_cert.pem
```

Update docker-compose.yml with the hostname of your server.

run dkim-key-gen for the domain you're sending mail on behalf of.
fill in dkim_sign.ini with selector and domain

    create dns record for dkim and spf

    generate a user/password combo

    you good!

to run:
docker-compose up -d

To learn more about docker have a look at this:
https://larry-price.com/blog/2015/02/26/a-quick-guide-to-using-docker-compose-previously-fig
