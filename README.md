# Apple Mail to Markdown (Obsidian Optimized)

A robust AppleScript for macOS that extracts selected emails from **Apple Mail** and converts them into beautifully formatted **Markdown (.md)** files.

Unlike standard conversion scripts that strip all formatting, this script uses a **CSS-injected HTML wrapper** to ensure that email layouts, signatures, and line breaks are preserved exactly as they appear in Mail.

## 🚀 Key Features

* **Layout Preservation:** Uses `white-space: pre-wrap` CSS to prevent the common "wall of text" issue.
* **Smart Linkification:** Automatically identifies "naked" URLs (like `google.com`) and turns them into clickable links without breaking existing HTML tags.
* **Obsidian Ready:** Automatically generates YAML frontmatter, including titles, dates, and nested tags.
* **Deep Linking:** Includes a `message://` URI link in the header to jump back to the original email in Mail instantly.
* **Dynamic ID Fetching:** Uses a runtime bypass to access the `html body` property, avoiding common AppleScript compiler "Unknown Identifier" errors.

---

## 🛠️ Configuration & Variables

Before running the script, you must configure two primary variables at the top of the file:

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

---

## 📂 Usage Modes

### 1. Standalone AppleScript

Open the script in **Script Editor**, select one or more emails in Apple Mail, and hit **Run**.

### 2. Automator Quick Action

Wrap this script in an **Automator Quick Action**. This allows you to right-click an email and select "Export to Markdown" from the context menu.

### 3. Apple Mail Rules (Automation)

Set up a Mail Rule (`Settings > Rules`) to trigger this script automatically based on patterns (e.g., from specific senders or containing specific keywords) to automate your archival process.

---

## ⚖️ License & Contributions

### MIT License

This project is licensed under the **MIT License**. You are free to use, copy, modify, merge, publish, and distribute this software. For the full legal text, please visit the [Open Source Initiative (OSI) MIT License page](https://opensource.org/license/mit).

### 🤝 Contribute to the Project

Contributions are what make the open-source community such an amazing place to learn, inspire, and create.

* **Bugs & Feature Requests:** If you encounter a bug or have a feature request, please open a formal report in the **Issues** section.
* **Questions & General Discussion:** For new ideas, setup help, or sharing your workflow, please use the **Discussions** section.
* **Code Improvements:** If you modify the script or optimize the Regex logic further, please **open a Pull Request** so that everyone can benefit from your changes!
