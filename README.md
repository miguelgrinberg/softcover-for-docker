Softcover for Docker
====================

This repository builds a Docker container image that contains a complete installation of the [softcover.io](https://www.softcover.io/) toolchain for building ebooks.

The `init.sh` script creates a config file and an alias (bash, zsh, etc) that invokes the softcover command inside the container as `sc`.

Examples:

    $ sc check
    Checking Softcover dependencies...
    Checking for LaTeX...         Found
    Checking for GhostScript...   Found
    Checking for ImageMagick...   Found
    Checking for Node.js...       Found
    Checking for PhantomJS...     Found
    Checking for Inkscape...      Found
    Checking for Calibre...       Found
    Checking for KindleGen...     Found
    Checking for Java...          Found
    Checking for zip...           Found
    Checking for EpubCheck...     Found
    All dependencies satisfied.

    $ sc --help
    Commands:
      sc build, build:all           # Build all formats
      sc build:epub                 # Build EPUB
      sc build:html                 # Build HTML
      sc build:mobi                 # Build MOBI
      sc build:pdf                  # Build PDF
      sc build:preview              # Build book preview in all formats
      sc check                      # Check dependencies
      sc clean                      # Clean unneeded files
      sc config                     # View local config
      sc config:add key=value       # Add to your local config vars
      sc config:remove key          # Remove key from local config vars
      sc deploy                     # Build & publish book
      sc epub:validate, epub:check  # Validate EPUB with epubcheck
      sc exercises                  # Add exercise id elements as spans (warning:...
      sc help [COMMAND]             # Describe available commands or one specific...
      sc login                      # Log into Softcover account
      sc logout                     # Log out of Softcover account
      sc new <name>                 # Generate new document directory structure
      sc open                       # Open book on Softcover website
      sc publish                    # Publish your book on Softcover
      sc publish:media              # Publish media
      sc server                     # Run local server
      sc unpublish                  # Remove book from Softcover
      sc version                    # Return the version number (-v for short)

