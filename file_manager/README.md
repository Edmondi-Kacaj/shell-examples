# File Management Utility - Learning Shell Scripting

[![Blog Post](https://img.shields.io/badge/Related%20Blog-Mastering%20Bash%20Scripting-blue)](https://www.edmondkacaj.com/posts/mastering-bash-scripting-a-practical-guide)

This is a Bash script designed part of the blog post [mastering-bash-scripting-a-practical-guide](https://www.edmondkacaj.com/posts/mastering-bash-scripting-a-practical-guide). It demonstrates how to organize files, log operations, handle errors, and create an interactive menu using Bash. 

This script is purely for educational purposes and serves as a practical example to understand key scripting techniques.


## Features

- **Organize Files by Extension**: Copies files into subdirectories based on their file extensions.
- **Logging**: Logs all script activities with timestamps for better understanding and debugging.
- **Interactive Menu**: Provides a user-friendly menu to perform tasks like viewing, deleting, and archiving files.
- **Error Handling**: Uses `trap` to clean up resources and handle interruptions gracefully.

## Usage

1. **Download the script** to your local machine.
   ```bash
     git clone https://github.com/Edmondi-Kacaj/shell-examples.git
     cd shell-examples/file_manager
   ```
2. **Make the script executable**:
   ```bash
     chmod +x file_manager.sh
   ```
3. **Run the script** with a target directory as an argument:
   ```bash
       ./file_manager.sh /path/to/your/directory

       # Or you can test the example files in files folder
        ./file_manager.sh files
   ```
4. **Follow the menu prompts** to explore the script's functionality.

## Script Details

### Variables

- `LOG_FILE`: Log file to store script activities.
- `ARCHIVE_FILE`: Name of the archive file.

### Functions

- **log_message**: Logs messages with a timestamp to both the console and the log file.
- **cleanup**: Cleans up temporary files and resources upon script exit.
- **organize_files**: Organizes files in the specified directory by their extensions.
- **view_files**: Displays the organized files.
- **delete_files**: Deletes the organized files directory.
- **archive_files**: Archives the organized files into a `.tar.gz` file.
- **clean_archive**: Removes the archive file.
- **menu**: Provides a menu-driven interface for the user to interact with the script.

