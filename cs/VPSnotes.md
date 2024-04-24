# VPS notes

## Digital Ocean
- setup Digital Ocean account (60 trial w/ $200 credit)
- created a droplet ($6/mo plan for 1gb memory)
- used ubuntu 22.04 LTS for oS
- IP appears to be 143.110.237.145 (from icanhazip.com)

- https://launchschool.com/gists/79b8e672 (LS instructions)


### initial steps
- `sudo apt update`
- `sudo apt upgrade`  (there were a significant number of upgrades)

#### initial server setup
- https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu
  - `adduser jjmchew`
  - `usermod -aG sudo jjmchew` : add user jjmchew to sudo group
  - could limit root login in SSH by altering the `/etc/ssh/sshd_config` file
      - `PermitRootLogin no`

#### install / configure nginx
- `sudo apt install nginx`
    (https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-22-04)
    - follow instructions above to setup nginx to serve separate resources at separate folders
      - having a temporary static site helps to confirm if the DNS / webserver is working
      - be sure to run `nginx -t` to test config files after making changes

    - https://kuldipmori.medium.com/nginx-for-managing-multiple-websites-via-subdomains-ddf1fdbd336b
    - domain files are in `/var/www/[domain]/html`
        - need to run `sudo chown -R jjmchew:jjmchew /var/www/77345.site/html` to give permissions for non-root user to modify files within the site folder
        - or could run `sudo chmod -R 755 /var/www` to provide universal read/write/execute permissions for web content
    - config files for each domain are in `/etc/nginx/sites-available/[domain]`
      - config files need to be symlinked to `/etc/nginx/sites-enabled/`
        (run `sudo ln -s /etc/nginx/sites-available/[domain] /etc/nginx/sites-enabled/`)
    - conf file is: `/etc/nginx/nginx.conf` (need to ensure `server_names_hash_bucket_size 64;` is enabled)


- get IP address using: `curl -4 icanhazip.com`

- register a domain name
    - add "A" record (@) to point to droplet server IP address
    - add "CNAME" (www...) to point to root domain name (i.e., the A record)

- after changes to nginx config:
  - `sudo systemctl reload nginx`

- `sites-available/[domain]` (config file):
```
server {

  root /var/www/80087355.xyz/html;
  index index.html index.htm;

  server_name 80087355.xyz www.80087355.xyz;

  location / {
    # try_files $uri $uri/ =404;
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
  }
  
}
```


#### install / configure postgresql
- https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-22-04-quickstart
- `sudo apt install postgresql postgresql-contrib`
- to access the `postgres` user:  `sudo -i -u postgres`
    - `exit` to logout `postgres` user

#### install / configure mongodb
- https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-20-04 (note version difference)
- from alternate source (https://www.mongodb.com/community/forums/t/installing-mongodb-over-ubuntu-22-04/159931):
  - `wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc |  gpg --dearmor | sudo tee /usr/share/keyrings/mongodb.gpg > /dev/null`
  - `echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list`
  - `sudo apt update`
  - `sudo apt install mongodb-org`

#### install node js (via NVM)
- from https://github.com/nvm-sh/nvm
  - `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash`
  - `nvm install v20.11.0` (to match my own linux)

#### install nvim
- install clang: `sudo apt install clang` (required for autocmds and treesitter)
- check nvim PPA:unstable repository and install using apt-get

#### Certbot (for SSL certificates from let's encrypt)
- https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal (these worked for ubuntu 22.04 although the version was different)

#### install PM2 (process manager for node.js applications)
- https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-22-04
  - `npm install pm2@latest -g`
  - `pm2 start [serverfile.js]`
  - `pm2 startup systemd`
      - then copy and paste the provided sudo env line
  - `pm2 save`
  - `systemctl start pm2-jjmchew`  or  `systemctl status pm2-jjmchew`
