# Homelab PDS with web server

I use this setup to run the Bluesky PDS on my Mac Mini homelab server
on my personal domain, while still maintaining a landing page for
my personal stuff.

## Create an .env file

```
$ cp env.sample .env
```

Edit the .env file and update `PDS_HOSTNAME` to your domain name

## Create a cloudflared tunnel

1.  Log in to cloudflare
2.  Navigate to Zero Trust > Networks > Tunnels 
3.  Create a tunnel
4.  Select cloudflared
5.  Give it a name
6.  Copy any of the command-lines they give you

The cloudflared web UI won't just give you the token directly.  You will
need to copy a command, paste it into a text editor, and then copy the 
long random string to get the token.

Edit the .env file and update `CLOUDFLARE_TUNNEL_NAME` and `CLOUDFLARE_TUNNEL_TOKEN`

## Create tunnel-config.yml

```
$ cp tunnel-config.yml.sample tunnel-config.yml
```

Edit the `tunnel-config.yml` file and update `TUNNEL_NAME` and `DOMAIN`

## Create admin password and JWT secret

Create an admin password (or use your own strong password) and a JWT secret

```
$ openssl rand --hex 16
```

Update `PDS_ADMIN_PASSWORD` and `PDS_JWT_SECRET` with these values

## Generate a private key

Generate a private key

```
$ openssl ecparam --name secp256k1 --genkey --noout --outform DER | tail --bytes=+8 | head --bytes=32 | xxd --plain --cols 32
```

Update `PDS_PLC_ROTATION_KEY_K256_PRIVATE_KEY_HEX` with this value

## Update the admin scripts

```
$ bin/pdsadmin update
```

Note this is different than the update that the offical Bluesky PDS install method uses.

## Start the containers

```
$ docker compose up
```

## Check the tunnel config and DNS

Browse back to the cloudflare tunnel config page and ensure it is healthy and has the following mappings:

* Host: `YOURDOMAIN`, Path: `^/$`, Service: `http://pds-web`
* Host: `YOURDOMAIN`, Path: `^/s/.*$`, Service: `http://pds-web`
* Host: `YOURDOMAIN`, Path: (empty), Service: `http://pds:3000`
* Host: `*.YOURDOMAIN`, Path: (empty), Service: `http://pds:3000`

Also you will probably need to update your DNS on cloudflare to map *.YOURDOMAIN to the same CNAME that
YOURDOMAIN is pointed at.  It should be something like `abc12345-abc1-abc1-abc1-abc123456def.cfargotunnel.com`.




