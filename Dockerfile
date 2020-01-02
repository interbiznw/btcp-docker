# 1. Base OS Image
FROM ubuntu:16.04
SHELL ["/bin/bash", "-c"] 
# 2. Copy blockchain client
ADD btcp-1.0.15 /app

ADD btcp-1.0.15/libs/libgomp.so.1 /usr/lib/x86_64-linux-gnu

RUN apt-get update \
  && apt-get install -qqy wget
# 3. Setup directory
WORKDIR /app/bin
# 4. Make permissions
RUN chmod +x /app/bin/btcpd
# 5. Add client.conf file
COPY client.conf /app/client.conf
# 6. Entrypoint
RUN ls -al /app
RUN chmod +x /app/fetch-params.sh
RUN bash /app/fetch-params.sh


ENTRYPOINT ["/app/bin/btcpd", "-conf=/app/client.conf"]
