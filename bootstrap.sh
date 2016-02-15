# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo Installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo Updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'some dependencies' git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

install rvm libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

echo Installing Ruby 2.2.4
rvm install 2.2.4
rvm use 2.2.4 --default

echo Installing Bundler
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

echo Installing Nginx
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
install '' apt-transport-https ca-certificates

sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
apt-get -y update

install '' nginx-extras passenger

echo Starting Nginx
service nginx start

install 'MySQL' mysql-server mysql-client libmysqlclient-dev

install 'PostgreSQL' postgresql postgresql-contrib libpq-dev