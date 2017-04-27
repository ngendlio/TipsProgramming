# INstall ginx on Ubuntu 16.04 LTS
 First install
```
sudo apt-get update
sudo apt-get install nginx
```
Then edit this file:`sudo nano /etc/nginx/sites-available/default`
By using: 
Delete everything in the file and insert the following configuration. Be sure to substitute your own domain name for the server_name directive. 

Additionally, change the port (8080) if your application is set to listen on a different port:
```
server {
    listen 80;
    #server_name example.com; // in case you already got an domain name
    server_name 13.74.39.128;  // Here your public IP ADDRESS
    ## BLOCK SOME KNOWN USER AGENTS AND WEB SCRAWLERS
      if ($http_user_agent ~* LWP::Simple|BBBike|wget|sqlmap|havij|nmap|nessus|absinthe|nikto|w3af|pangolin|bsqlbf|prog.customcrawler|mysqloit|netsparker ) {
            return 403;
      }

      ## ONLY REQUESTS TO OUR HOST ARE ALLOWED
      #if ($host !~ ^(ourwebsite.com|www.ourwebsite.com|machine1.ourwebsite.com|machine_etc.ourwebsite.com)$ ) {
        #return 444;
      #}

      ## ONLY ALLOW THESE REQUEST METHODS AND DENY OTHERS LIKE DELETE, SEARCH, ETC ##
      if ($request_method !~ ^(GET|HEAD|POST)$ ) {
            return 444;
      }

      # ENABLE SESSION RESUMPTION TO IMPROVE HTTPS PERFORMANCE
      ssl_session_cache shared:SSL:10m;
      ssl_session_timeout 5m;

      # SOME LIMITATIONS AGAINST BUFFER OVERFLOW
      client_body_buffer_size  4K;
      client_header_buffer_size 1k;
      client_max_body_size 4M;
      large_client_header_buffers 2 1k;

      # DIFFIE-HELLMAN PARAMETER FOR DHE CIPHERSUITES, RECOMMENDED 4096 BITS
      ssl_dhparam /etc/nginx/ssl/dhparam.pem;

      # ENABLES SERVER-SIDE PROTECTION FROM BEAST ATTACKS
      ssl_prefer_server_ciphers on;

      # disable SSLv3(enabled by default since nginx 0.8.19) since it's less secure then TLS
      ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

      # CIPHERS CHOSEN FOR FORWARD SECRECY AND COMPATIBILITY
      ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:ECDHE-RSA-AES128-GCM-SHA256:AES256+EECDH:DHE-RSA-AES128-GCM-SHA256:AES256+EDH:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384$

      #PARANOID MODE
      #ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';

      # ENABLE OCSP STAPLING
      resolver 8.8.8.8;
      ssl_stapling on;

      # CONFIG TO ENABLE HSTS (HTTP Strict Transport Security)
      add_header Strict-Transport-Security "max-age=31536000; includeSubdomains;";

    location / {
        proxy_pass http://127.0.0.1:6700; // here Change with your app
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

```
