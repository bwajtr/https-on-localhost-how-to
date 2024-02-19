## How to easily test any localhost website using a valid HTTPS protocol

### What is this about?

You typically develop webapps using HTTP protocol, because it's simple to run and use e.g. on http://localhost:8080
But the app might behave differently when running using HTTPS in production.
Below are fairly simple steps that are needed to set up HTTPS protocol (HTTP/2 actually) for your webapp testing locally.

Advantages of the below approach: 
  - you don't have to change anything in your app at all
  - the app is still accessible on http://localhost:8080 - so you can test it using HTTP and HTTPS at the same time
  - it mimics a typical production setup, where the SSL termination is done before the request even reaches your app

### How it works?

We use `mkcert` tool to generate (and install) self-signed SSL certificates so your browser will trust them.
Then we use `docker compose` to startup `nginx` local server running on https://secure.localhost that will use those
certificates and simply redirect all traffic to your local webapp running on http://localhost:8080. In technical terms the `nginx` server
will perform SSL termination and acts as a reverse proxy to your local webapp. 

### How to run it?

1. Clone this repository locally
2. Install Docker Desktop
3. Install mkcert (https://github.com/FiloSottile/mkcert#installation)
    - this is a tool that we will use to generate certificates required to run HTTPS locally
    - Note that it's not safe to share these certificates, it's better to generate them on your own
    - see this article for more details: https://web.dev/articles/how-to-use-local-https
4. Go to `nginx/certs/` and run `generate-certs.sh` there (this is required just once)
    - It will probably require your system admin password, so it can add generated root CA certificate to your system
    - `cert.pem` and `key.pem` should be generated in `nginx/certs/` directory
    - You may need to restart your browsers to changes to take effect
5. Run your webapp (so it is available at http://localhost:8080)
6. Run `docker compose up` in the root directory of this repository
    - HTTPS proxy is now running, accessible at https://secure.localhost, it redirects all traffic to http://localhost:8080
7. You can now keep docker compose running, you can restart your application as you like
8. When you are done, run `docker compose down` to stop the proxy   

### Troubleshooting

* I see `502 Bad Gateway` instead of my website
    - Make sure your webapp is running on http://localhost:8080