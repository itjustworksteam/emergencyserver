FROM therickys93/ubuntu14swiftenv
RUN apt-get update && apt-get install libmysqlclient18 libmysqlclient-dev -y
RUN swiftenv install 3.0 && swiftenv global 3.0
WORKDIR /vapor
ADD . /vapor
EXPOSE 80
RUN swift build -Xswiftc -I/usr/local/mysql/include -Xlinker -L/usr/local/mysql/lib -Xswiftc -DNOJSON
CMD .build/debug/App --workdir=./ --config:servers.http.port=80
