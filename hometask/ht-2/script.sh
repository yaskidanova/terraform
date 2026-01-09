#! /bin/bash

sudo dnf install httpd -y 
sudo systemctl start httpd
sudo systemctl enable httpd
echo '<html><body><h1>Session-2 homework is complete! </h1></body></html>' > /var/www/html/index.html