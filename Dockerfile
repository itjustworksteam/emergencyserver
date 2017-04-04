FROM therickys93/ubuntu14swiftenv
WORKDIR /vapor
ADD . /vapor
EXPOSE 80
RUN swiftenv install -s
RUN swift build
CMD .build/debug/App --workdir=./ --config:servers.http.port=80
