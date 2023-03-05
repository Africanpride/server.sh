#!/bin/bash

read -p "Are you sure you want to run the script? (y/n) " confirm
if [ "$confirm" != "y" ]; then
  echo "Aborting script."
  exit 1
fi

read -p "Enter the URL of the Git repository to clone: " repourl
read -p "Enter the name of the folder to clone the repository into: " foldername

# Clone or update the repository
cd /var/www/html/
if [ -d "$foldername" ]; then
  sudo rm -rf "$foldername"
fi
sudo mkdir "$foldername"
cd "$foldername"
sudo chown -R $USER:www-data /var/www/html/"$foldername"/
git clone "$repourl" .
sudo chmod -R 0755 /var/www/html/"$foldername"/
sudo chmod -R 0777 /var/www/html/"$foldername"/storage
composer install --working-dir=/var/www/html/"$foldername"/
npm install && npm run build
cp ~/.env .
php artisan storage:link
php artisan key:generate
php artisan sitemap:generate
sudo chown -R www-data:www-data /var/www/html/"$foldername"/
sudo systemctl reload nginx.service

