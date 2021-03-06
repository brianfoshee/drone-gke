FROM alpine:3.4

ENV GOOGLE_CLOUD_SDK_VERSION=135.0.0

RUN apk add --no-cache curl python

# Install the gcloud SDK
RUN curl -fsSLo google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$GOOGLE_CLOUD_SDK_VERSION-linux-x86_64.tar.gz
RUN tar -xzf google-cloud-sdk.tar.gz
RUN rm google-cloud-sdk.tar.gz
RUN ./google-cloud-sdk/install.sh --quiet

# Install kubectl
RUN ./google-cloud-sdk/bin/gcloud components install kubectl

# Clean up
RUN rm -rf ./google-cloud-sdk/.install

# Add the Drone plugin
ADD drone-gke /bin/

ENTRYPOINT ["/bin/drone-gke"]
