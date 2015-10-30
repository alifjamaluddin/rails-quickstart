clear
echo "This rails installation is scripted for Ubuntu 15.04"
echo "Please enter your git username first:[ENTER]"
read username
echo "Please enter your email:[ENTER]"
read email
echo "Update System"
sudo apt-get update
echo "Update System DONE"

echo "Install essential libraries"
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
echo "Install essential libraries DONE"

echo "Install Ruby"
cd
if [ ! -d ".rbenv" ]; then
git clone git://github.com/sstephenson/rbenv.git .rbenv
fi
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.2.3
rbenv global 2.2.3
ruby -v

echo "Install Ruby DONE"

echo "Install bundler"
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

echo "Install bundler DONE"

echo "Setup Git"

git config --global color.ui true
git config --global user.name "$username"
git config --global user.email "$email"
ssh-keygen -t rsa -C "$email"
cat ~/.ssh/id_rsa.pub
cp ~/.ssh/id_rsa.pub ~/id_rsa.pub
echo "Paste this SSH KEY to your git cloud"
echo "Setup Git DONE"

echo "Yeah! We are installing Rails now!"
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs
gem install rails -v 4.2.4
rbenv rehash
echo "Done installing rails"
echo "Lets see the rails version"
rails -v