Move weibo's updates to twitter
===============================

Since we are in China, a world protected by a GFW, so all popular websites are forbidden for us,
Facebook, Twitter, Google. It's convenient to use weibo, but sometimes we want to post twitter also,
then you need to 翻墙. This small app is used to solve this problem, we can post things on weibo, then
all posts will be conveyed to Twitter.

How to use?
===========

This tool has 2 parts:

1. Sinatra parts used to get and store access token from each service. that means you have to authorize this app to read and write things on your twitter or weibo.

2. Background daemon process, this is used to check new posts on weibo and post them to twitter.

Installation:

Step 1:

`git clone git@github.com:hlxwell/weibo-2-twitter.git`

Step 2:

`bundle install`

Step 3:

To run the sinatra: `ruby app.rb` or `rackup`

Step 4:

Open browser and click on the links "Sign in with Weibo" and "Sign in with Twitter".

Step 5:

Run Synch Service: `bin/synch_service.rb start`

TODO
====

* Maybe can use streaming api, but actually we need it for monitoring weibo but not twitter.

https://dev.twitter.com/docs/streaming-api

* Weibo's limit is 280, but Twitter 140, so many words will be truncated.


API Reference
=============

http://open.weibo.com/wiki/2/statuses/user_timeline

http://rdoc.info/gems/twitter/Twitter/Client/Timelines

https://github.com/ballantyne/weibo/blob/master/lib/weibo/base.rb

