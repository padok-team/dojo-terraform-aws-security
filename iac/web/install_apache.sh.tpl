#!/bin/bash

echo '123' > /tmp/123
echo '123YOUHOU123'
sudo apt-get update
sudo apt-get install -y apache2
apachectl start
sleep 1
echo '<h2>This is the ${environment} environment </h2>' > /var/www/html/index.html
