git clone --depth 1 https://github.com/adham90/geekhub.git app

cd app/backend

source "/usr/local/share/chruby/chruby.sh"
chruby ruby

gem install bundler

bundle install

bundle exec rake db:migrate

if [[ $? != 0 ]]; then
  echo
  echo "== Faild to migrate. Running setup first."
  echo
  bundle exec rake db:setup && \
  bundle exec rake db:migrate
fi

bundle exec rails server