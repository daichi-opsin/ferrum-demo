FROM ruby:3.3

ARG app_root="myapp"

RUN mkdir /${app_root}
WORKDIR /${app_root}
COPY Gemfile /${app_root}/Gemfile
COPY Gemfile.lock /${app_root}/Gemfile.lock
RUN bundle install
COPY . /${app_root}

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
