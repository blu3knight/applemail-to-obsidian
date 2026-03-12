# ===========================================================
# Apple Mail to Markdown Export (v2.8)
# Optimized for Obsidian & Layout Preservation
# ===========================================================

-- 1. USER SETTINGS
-- Use HFS format (colons instead of slashes)
-- Example: "Macintosh HD:Users:Username:Documents:Vault:Emails:"
property saveFolder : "Macintosh HD:Users:EXAMPLE_USER:PATH:TO:YOUR:VAULT:"

-- Comma-separated list of tags to be added to YAML Frontmatter
property tagList : "Resources/Email, Work/Inbox"

# ===========================================================
# MAIN SCRIPT LOGIC
# ===========================================================

tell application "Mail"
	activate
	set selectedMessages to selection
	if (count of selectedMessages) is 0 then
		display dialog "Please select one or more messages first." buttons {"OK"} default button "OK"
		return
	end if
	
	set currentISOFormattedDate to (do shell script "date '+%Y-%m-%d'")
	
	repeat with eachMessage in selectedMessages
		-- Metadata Extraction
		set msgDate to date received of eachMessage
		set msgSubject to subject of eachMessage
		set msgSender to sender of eachMessage
		set msgID to message id of eachMessage
		set internalID to id of eachMessage
		
		-- Recipient Extraction
		set toRecip to {}
		repeat with r in (to recipients of eachMessage)
			set end of toRecip to (address of r)
		end repeat
		set ccRecip to {}
		repeat with r in (cc recipients of eachMessage)
			set end of ccRecip to (address of r)
		end repeat
		
		-- String Conversion
		set oldDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to ", "
		set toStr to toRecip as string
		set ccStr to ccRecip as string
		set AppleScript's text item delimiters to oldDelims
		
		-- Fetch HTML Body (Using dynamic script to avoid compiler errors)
		try
			set rawHTML to my getHTMLByID(internalID)
		on error
			set rawHTML to content of eachMessage
		end try
		
		-- Apply Smart Linkifier (v2.7 "V-Preservation" Logic)
		set processedHTML to my htmlLinkify(rawHTML)
		
		-- Date Component Formatting
		set {y, m, d, h, min, s} to {year of msgDate, (month of msgDate as integer), day of msgDate, hours of msgDate, minutes of msgDate, seconds of msgDate}
		if (count of (m as string)) is 1 then set m to "0" & m
		if (count of (d as string)) is 1 then set d to "0" & d
		if (count of (h as string)) is 1 then set h to "0" & h
		if (count of (min as string)) is 1 then set min to "0" & min
		if (count of (s as string)) is 1 then set s to "0" & s
		
		set filePrefix to (y & "-" & m & "-" & d & "-" & h & min & s) as string
		set safeSubject to my sanitizeFilename(msgSubject)
		set fileName to filePrefix & "-" & safeSubject & ".md"
		set filePath to (saveFolder & fileName) as string
		
		-- Construct Markdown with YAML Frontmatter
		set markdownContent to "---" & return
		set markdownContent to markdownContent & "title: " & filePrefix & " ~ " & msgSubject & return
		set markdownContent to markdownContent & "aliases: " & return
		set markdownContent to markdownContent & "Tags: " & return
		set AppleScript's text item delimiters to ","
		repeat with t in (text items of tagList)
			set markdownContent to markdownContent & "  - " & my trim(t) & return
		end repeat
		set AppleScript's text item delimiters to oldDelims
		set markdownContent to markdownContent & "description: " & return
		set markdownContent to markdownContent & "publish: false" & return
		set markdownContent to markdownContent & "draft: false" & return
		set markdownContent to markdownContent & "enableToc: false" & return
		set markdownContent to markdownContent & "created: " & y & "-" & m & "-" & d & return
		set markdownContent to markdownContent & "modified: " & currentISOFormattedDate & return
		set markdownContent to markdownContent & "---" & return & return
		-- End of YAML Frontmatter
		
		-- Setting a Banner Graphic for Email
		-- If you have a Graphic that you would like to use just put in the name here
		-- and make sure it is in your obsidian Vault. 
		-- Uncomment the following line if you want to use:
		-- set markdownContent to markdownContent & "![[My_Email_Banner.jpg]]" & return & return
		
		
		-- Start of Subject Line
		set markdownContent to markdownContent & "# Subject: " & msgSubject & return & return
		-- End of Subject Line
		-- Start oF Header Information
		set markdownContent to markdownContent & "## Header" & return
		set markdownContent to markdownContent & "**From:** " & msgSender & return
		set markdownContent to markdownContent & "**Date:** " & (msgDate as string) & return
		set markdownContent to markdownContent & "**To:** " & toStr & return
		if ccStr is not "" then set markdownContent to markdownContent & "**Cc:** " & ccStr & return
		set markdownContent to markdownContent & "**Mail Link:** [Open in Mail](message://%3c" & msgID & "%3e)" & return
		set markdownContent to markdownContent & "***" & return & return
		-- End of Header 
		
		-- Body with CSS preservation wrapper
		set markdownContent to markdownContent & "## Message Body" & return & return
		set markdownContent to markdownContent & "<div style=\"white-space: pre-wrap; font-family: sans-serif; line-height: 1.5; color: var(--text-normal);\">" & return
		set markdownContent to markdownContent & processedHTML & return
		set markdownContent to markdownContent & "</div>" & return & return
		-- End of Body
		-- Extra Notes Section
		set markdownContent to markdownContent & "***" & return & return
		set markdownContent to markdownContent & "## Notes Information" & return & return
		-- End of Notes Section
		-- Ability to attach files to the Email (Not automatically extracted)
		set markdownContent to markdownContent & "## Documents" & return & return
		-- End of File Attachments
		
		
		-- Save File
		try
			set f to open for access file filePath with write permission
			set eof f to 0
			write markdownContent to f as «class utf8»
			close access f
		on error
			try
				close access f
			end try
		end try
	end repeat
end tell

# ===========================================================
# HANDLERS
# ===========================================================

on htmlLinkify(theText)
	try
		-- v2.7 Regex: Preserves first characters (like 'v') while avoiding existing HTML tags
		set perlCmarkdownContent to "perl -pe 's/(?<![\\/\\\"\\>\\=])\\b([a-zA-Z0-9][a-zA-Z0-9.-]+\\.(com|net|org|io|it|gov|biz|info)[a-z0-9.\\/\\?#%_\\-]*)/<a href=\"http:\\/\\/\\1\">\\1<\\/a>/gi'"
		return do shell script "echo " & quoted form of theText & " | " & perlCmarkdownContent
	on error
		return theText
	end try
end htmlLinkify

on getHTMLByID(mID)
	return run script "tell application \"Mail\" to get html body of item 1 of (every message whose id is " & mID & ")"
end getHTMLByID

on sanitizeFilename(str)
	set illegal to {":", "/", "\\", "*", "?", "\"", "<", ">", "|"}
	set out to str
	repeat with c in illegal
		set AppleScript's text item delimiters to c
		set t to text items of out
		set AppleScript's text item delimiters to "_"
		set out to t as string
	end repeat
	set AppleScript's text item delimiters to ""
	return out
end sanitizeFilename

on trim(t)
	repeat while t begins with " "
		set t to text 2 thru -1 of t
	end repeat
	repeat while t ends with " "
		set t to text 1 thru -2 of t
	end repeat
	return t
end trim
