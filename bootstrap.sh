# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo Installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

# Install Git & Rvm & Ruby 2.2.4
echo Updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'some dependencies' git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

install rvm libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc
echo "export rvm_max_time_flag=20" >> ~/.rvmrc
echo "[[ -s '${HOME}/.rvm/scripts/rvm' ]] && source '${HOME}/.rvm/scripts/rvm'" >> ~/.bashrc
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -L https://get.rvm.io | bash -s stable --ruby
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB
source /usr/local/rvm/scripts/rvm
# Fix permissions and add Vagrant to the RVM group
rvm group add rvm vagrant
rvm fix-permissions

echo Installing Ruby 2.2.4
rvm install ruby-2.2.4
rvm use 2.2.4 --default

# Install gem Bundler
echo Installing Bundler
gem install bundler

# Install gem Rails
echo Installing Rails
gem install rails

# Install gem Hanami
echo Installing Hanami
gem install hanami

# Install gem Whenever
echo Installing Whenever
gem install whenever

# Install Nginx
echo Installing Nginx
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
apt-get -y install apt-transport-https ca-certificates

sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
apt-get -y update >/dev/null 2>&1

apt-get -y install nginx-extras passenger

echo Starting Nginx
service nginx start

# Install MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password secret'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password secret'
install MySQL mysql-server mysql-client libmysqlclient-dev
mysql -uroot -psecret <<SQL
CREATE USER 'rubick'@'localhost' IDENTIFIED BY 'secret';
GRANT ALL PRIVILEGES ON *.* to 'rubick'@'localhost';
SQL

# Install PostgreSQL
install PostgreSQL postgresql postgresql-contrib libpq-dev
sudo -u postgres createuser --superuser vagrant

# Install Sqlite3
install SQLite sqlite3 libsqlite3-dev

# Install Redis
install Redis redis-server

# Install Memcached
install Memcached memcached

echo 'Done is better than perfect!'