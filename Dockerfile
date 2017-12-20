FROM ruby:2.4.2
RUN gem install jekyll -v '3.6.2'

RUN apt-get update && apt-get install -y sudo

# Add a new user to have development workflow on a non root user, that way the files that are
# created inside the container on a directory mounted via the -v option will belong to the right
# user and not the root user. The values of uid and gid might need to be changed depending on
# your config use the command `id` to get the right values
# Probably unnecessary for Windows and Mac users

# one convenient location to set the gid and uid
ENV gid=1000 uid=1000

# adds the group
RUN groupadd -g $gid developer && \
  # creates the user named developer with the right uid and gid
  useradd -g $gid -u $uid -m developer && \
  # allow the developer user use sudo without a password
echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# create the directory that will be used on the mount
RUN mkdir /home/developer/app

WORKDIR /home/developer/app
