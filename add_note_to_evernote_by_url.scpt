on run argv
	tell application "Evernote"
		set note_url to item 1 of argv
		set tweet_text to item 2 of argv
		set EVNote to (create note from url note_url title tweet_text created current date tags "twitever")
	end tell
end run