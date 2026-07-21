# AppleMail to Markdown (Obsidian Optimized)

A robust AppleScript for macOS that extracts selected emails from **Apple Mail** mail client and converts them into beautifully formatted **Markdown (.md)** files.

Unlike standard conversion scripts that strip all formatting, this script uses a **CSS-injected HTML wrapper** to ensure that email layouts, signatures, and line breaks are preserved as close as possible to the way they appear in Apple Mail. 

If you are not happy with the way it looks especially in replies there is an implementation of the option (see Configuration and Variables) to subdivide replies, to make it look even better. 


## 🚀 Key Features

* **Layout Preservation:** Uses `white-space: pre-wrap` CSS to prevent the common "wall of text" issue.
* **Smart Linkification:** Automatically identifies "naked" URLs (like `google.com`) and turns them into clickable links without breaking existing HTML tags or email address domains.
* **Obsidian Ready:** Automatically generates YAML frontmatter, including titles, dates, and nested tags.
* **Deep Linking:** Includes a native `message://` URI link in the header to jump back to the original email in Apple Mail instantly.
* **Sub-divide Replies:** Optionally splits email thread replies visually by inserting an underscore separator line.
* **Metadata Changes:** Changes the Metadata to remove the characters that cause issues in metadata (colons, semicolons, etc.)

---

## 🛠️ Configuration and Variables

**NOTE**: _Before running the script, you must configure the following variables at the top of the applescirpt_ 

### 1. Setting the Save Folder

AppleScript uses the **HFS (Macintosh)** path format (using colons `:` instead of slashes `/`).

**Example of a fake path for your configuration:**
```applescript
-- Correct HFS Format:
property saveFolder : "Macintosh HD:Users:YourName:Documents:Notes:Emails:Archive:"
```

### 2. Managing Tags

The `tagList` variable allows you to define Obsidian-style tags that will be added to every exported email. These are formatted as a comma-separated string and will be converted into a proper YAML list.

**Example:**
```applescript
property tagList : "Function/Type/Email, Focus/Work, Project/Alpha"
```

### 3. Sub-divide Replies

The `sub-divide-replies` variable controls whether threaded email replies are visually separated by an underscore divider line. 
Set to `true` to enable or `false` to disable.

**Example:**
```applescript
property |sub-divide-replies| : true
```

---

## 📂 Usage Modes

_Please note: The configuration and variables must be modified in the script before running it, or the script will not export the files correctly._

### 1. Standalone AppleScript

Open the script in **Script Editor**, select one or more emails in Apple Mail, and hit **Run**.

### 2. Automator Quick Action

Wrap this script in an **Automator Quick Action**. This allows you to right-click an email and select "Export to Markdown" from the context menu.

### 3. MailMaven Rules (Automation)

Set up a Apple Mail Rule to trigger this script automatically based on patterns (e.g., from specific senders or containing specific keywords) to automate your archival process.

---

## How to Use

Download the [applemail-to-obsidian.scpt](https://github.com/blu3knight/applemail-to-obsidian/blob/main/email-to-obsidian.scpt) to your system. You can then set up the script as above in **Usage Modes**. 

---

## About Using this Script and Support

Please be aware that I have switched to using the MailMaven Mail client for my daily use. It does not mean that I am abandoning this project, I am still going to maintain it and port all the features that I implement in the MailMaven applescript back to here. But it does mean that since I am not using it daily that if you find a bug please report it, otherwise I will never know about it. If you do report a bug I will test the problem, fix it, and release a new version. 

### If you ask what is MailMaven?

[MailMaven](https://mailmaven.app) is a fast, keyboard-driven, power-user-focused email client for macOS. It offers robust search capabilities, a clean interface, custom rules, and supports automated workflows via its AppleScript dictionary definitions. I have been beta testing this client for a long time, and I love a lot of the features and the development that I see. 

To obtain MailMaven, visit their official website at [mailmaven.app](https://mailmaven.app).

---

## ⚖️ License & Contributions

### MIT License

This project is licensed under the **MIT License**. You are free to use, copy, modify, merge, publish, and distribute this software. For the full legal text, please visit the [Open Source Initiative (OSI) MIT License page](https://opensource.org/license/mit).

### 🤝 Contribute to the Project

Contributions are what make the open-source community such an amazing place to learn, inspire, and create.

* **Bugs & Feature Requests:** If you encounter a bug or have a feature request, please open a formal report in the **Issues** section.
* **Questions & General Discussion:** For new ideas, setup help, or sharing your workflow, please use the **Discussions** section.
* **Code Improvements:** If you modify the script or optimize the Regex logic further, please **open a Pull Request** so that everyone can benefit from your changes!
