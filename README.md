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

Update docker-compose.yml with the hostname of your server.

Run the following command to generate a self signed certificate. It will ask you
questions, and it's important that you enter the hostname of your server for the FQDN.

```sh
openssl req -x509 -nodes -days 2190 -newkey rsa:2048 \
      -keyout config/tls_key.pem -out config/tls_cert.pem
```

Run dkim-key-gen for the domain you're sending mail on behalf of. When you
send mail from an address with this domain, it will be DKIM signed.

```sh
cd config/dkim
sh dkim_key_gen.sh example.com
```

There is now a folder called example.com, and in there is a file called `dns`.

Open that file and create the DKIM and SPF TXT records it specifies.

See [dkim_sign](https://haraka.github.io/manual/plugins/dkim_sign.html) for more info if you need.

Also add an SPF record on the root of the domain. This is good for basic purposes.

```
TXT "v=spf1 mx a -all"
```

fill in dkim_sign.ini with selector and domain

    create dns record for dkim and spf


Create a user and password to use when connecting. This command adds a user called `user` and a generates a random password for you.

```sh
echo "user=`openssl rand -hex 20`" >> config/auth_flat_file.ini
```

you good!

Commit your changes

to run:
```sh
docker-compose up -d
```

To see what's going on:
```sh
docker-compose logs
```

To learn more about docker have a look at this:
https://larry-price.com/blog/2015/02/26/a-quick-guide-to-using-docker-compose-previously-fig
