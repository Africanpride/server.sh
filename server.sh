#!/bin/bash

read -p "Are you sure you want to run the script? (y/n) " confirm
if [ "$confirm" != "y" ]; then
  echo "Aborting script."
  exit 1
fi

read -p "Enter the URL of the Git repository to clone: " repourl
read -p "Enter the name of the folder to clone the repository into: " foldername
read -p "Specify full path to your .env file. eg. ~/.env : " dotenvFile
read -p "Enter the desired APP_URL (e.g. https://example.com): " appurl

# Clone or update the repository
cd /var/www/html/
sudo rm -rf "$foldername"
sudo mkdir -p "$foldername"
cd "$foldername"
sudo chown -R $USER:www-data /var/www/html/"$foldername"/
git clone "$repourl" .

## Run our installations
sudo chmod -R 0755 /var/www/html/"$foldername"/
sudo chmod -R 0775 /var/www/html/"$foldername"/storage
composer install --optimize-autoloader --no-dev --working-dir=/var/www/html/"$foldername"/ || { echo "Composer install failed"; exit 1; }
npm install && npm run build || { echo "NPM install failed"; exit 1; }

# Specify your current .env file source
cp "$dotenvFile" .

#set dot env parameters
sed -i 's/APP_DEBUG=true/APP_DEBUG=false/g' ./env || { echo "Sed command failed"; exit 1; }
sed -i 's/APP_ENV=production/APP_ENV=local/g' ./env || { echo "Sed command failed"; exit 1; }
sed -i "s|APP_URL=.*|APP_URL=$appurl|g" ./env || { echo "Sed command failed"; exit 1; }

## Finally set the right file and folder permissions
sudo chown -R www-data:www-data /var/www/html/"$foldername"/
sudo find ./ -type f -exec chmod 664 {} \;    
sudo find ./ -type d -exec chmod 775 {} \;

sudo chgrp -Rf www-data storage bootstrap/cache
sudo chmod -Rf ug+rwx storage bootstrap/cache
sudo chmod -Rf 775 storage/ bootstrap/

# Run necessary Laravel commands
php artisan storage:link
php artisan key:generate

# using Spatie/laravel-site-map
php artisan sitemap:generate

# Necessary Caches
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Reload our Nginx Server. Could be Apache or whatever.
sudo systemctl reload nginx.service
