#!/bin/sh

#This script is configuring a new VM to run weight tracker app.

HOST_URL=${HOST_URL}
OKTA_CLIENT_SECRET=${OKTA_CLIENT_SECRET}
OKTA_CLIENT_ID=${OKTA_CLIENT_ID}
OKTA_ORG_URL=${OKTA_ORG_URL}
OKTA_KEY=${OKTA_KEY}
PGUSERNAME=${PGUSERNAME}
PGPASSWORD=${PGPASSWORD}
PGHOST=${PGHOST}


#Install all the packages needed for the app to run.
#Including downloading the app from git.
sudo apt update
sudo apt install -y curl
sudo curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt-get install -y nodejs
node --version
sudo apt install git
git clone https://github.com/Gridin94/bootcamp-app.git
cd bootcamp-app
sudo npm i
sudo npm install pm2 -g
#sudo curl -sL https://raw.githubusercontent.com/Unitech/pm2/master/packager/setup.deb.sh | sudo -E bash -

#creating the .env file that
#contains all of the configuration for the app.
echo "# Host configuration
PORT=8080
HOST=0.0.0.0
NODE_ENV=development
HOST_URL=http://$HOST_URL:8080
COOKIE_ENCRYPT_PWD=superAwesomePasswordStringThatIsAtLeast32CharactersLong!
# Okta configuration
OKTA_ORG_URL=https://$OKTA_ORG_URL/
OKTA_CLIENT_ID=$OKTA_CLIENT_ID
OKTA_CLIENT_SECRET=$OKTA_CLIENT_SECRET
# Postgres configuration
PGHOST=$PGHOST
PGUSERNAME=$PGUSERNAME
PGDATABASE=postgres
PGPASSWORD=$PGPASSWORD
PGPORT=5432" > .env

#starting the app.
npm run initdb
sudo pm2 start npm -- run dev
sudo pm2 save
sudo pm2 startup

#update okta uris:
curl --location --request PUT 'https://${OKTA_ORG_URL}//api/v1/apps/${OKTA_CLIENT_ID}' \
--header 'Accept: application/json' \
--header 'Content-Type: application/json' \
--header 'Authorization: SSWS ${OKTA_KEY}' \
--data-raw '{
    "name": "oidc_client",
    "label": "Node Weight Tracker",
    "credentials": {
        "oauthClient": {
            "autoKeyRotation": true,
            "client_id": "${OKTA_CLIENT_ID}",
            "token_endpoint_auth_method": "client_secret_basic"
        }
    },
    "settings": {
        "oauthClient": {
            "redirect_uris": [
                "http://${HOST_URL}:8080/authorization-code/callback"
            ],
            "post_logout_redirect_uris": [
                "http://${HOST_URL}:8080/logout"
            ],
            "response_types": [
                "code"
            ],
            "application_type": "web",
            "consent_method": "REQUIRED",
            "issuer_mode": "DYNAMIC"
        }
    }
}'