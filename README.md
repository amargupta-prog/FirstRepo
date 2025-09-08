 my_comp_dashboard

1. bundle install
2. Setup DB: bin/rails db:create db:migrate db:seed
3. Start server: bin/rails server
4. (Optional) Start sidekiq: bundle exec sidekiq -C config/sidekiq.yml