twitever
========
I love Evernote.  I love Twitter.  I favorite tweets I love.  I want to automatically add web pages linked to in my favorite tweets to Evernote.  Now I can.

Hack!
-----
This project is a quick hack that is the Simplest Thing That Would Work.  Fork away and modify to your heart's content.

Setup
-----
1. You probably have to open add_note_to_evernote_by_url.scpt in AppleScript Editor and compile it.  AppleScript is pretty lame like that.

2. Copy .twitever.yml.example to ~/.twitever.yml and set configurations as needed

3. Invoke twitter.rb in some way.  This works best as a scheduled task, really.

What it does
------------
1. Fetches your favorite tweets from twitter
2. Checks to see if these tweets are newer than the ones you dealt with last time
3. For new favorite tweets, finds URLs in those tweets
4. Adds a page in Evernote that contains the contents of the URL, with the original tweet content as the title of the note

What it does not do
-------------------
Anything else :)
