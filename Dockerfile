FROM ubuntu:18.04

RUN apt-get update -qq
RUN apt-get install -y binutils build-essential \
    sysstat strace wget git \
    openssl libreadline6-dev git-core gdb \
    bison autoconf automake ruby libtool sqlite3 \
    zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev \
    libxml2-dev libxslt-dev libc6-dev ncurses-dev
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /work
RUN git clone -b ruby_2_6 https://github.com/ruby/ruby

WORKDIR /work/ruby
RUN autoreconf
RUN ./configure optflags="-O0" debugflags="-g3"
RUN make
RUN make install

WORKDIR /work
RUN gem install bundler -v 1.17.2
COPY ./Gemfile /work/Gemfile
COPY ./Gemfile.lock /work/Gemfile.lock
RUN $(which bundle) install
COPY . /work

CMD gdb --args ruby $(which bundle) exec ruby ./test.rb
