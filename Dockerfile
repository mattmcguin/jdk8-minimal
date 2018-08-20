FROM openjdk:8-jdk-slim

# Install goodies
RUN apt-get update && \
	apt-get install -y gnupg jq curl netcat wget bsdmainutils git unzip

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt-get update && apt-get install -y google-chrome-stable

# Install chromedriver
RUN mkdir -p /var/tmp/chromedriver && \
	cd /var/tmp/chromedriver && \
	wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip && \
	unzip chromedriver_linux64.zip && \
	mv chromedriver /usr/local/bin/chromedriver && \
	chown root:root /usr/local/bin/chromedriver && \
	chmod +x /usr/local/bin/chromedriver

# do the cleanup
RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/* /var/tmp/*
