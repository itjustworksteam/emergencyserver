FROM therickys93/ubuntu14swiftenv
RUN swiftenv install
WORKDIR /vapor
ADD . /vapor
EXPOSE 80
RUN swift build
CMD .build/debug/App --workdir=./ --config:servers.http.port=80
