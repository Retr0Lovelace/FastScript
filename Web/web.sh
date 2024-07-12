#!/bin/bash

# Script to start a web server with Python3

# Function to display help
usage() {
    echo "Usage: $0 [-p port] [-h] [file]"
    echo "  -p port    Choose the port for the web server (default: 8080)"
    echo "  -h         Display this help"
    echo "  [file]     File to serve (default: current directory)"
    exit 1
}

# Default port
port=8080

# Parse command line options
while getopts "p:h" opt; do
    case ${opt} in
        p )
            port=${OPTARG}
            ;;
        h )
            usage
            ;;
        \? )
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# File or directory to serve
target=${1:-$(pwd)}

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null
then
    echo "Python3 is not installed. Please install Python3 and try again."
    exit 1
fi

# Check if the target exists
if [ ! -e "$target" ]; then
    echo "The specified file or directory does not exist: $target"
    exit 1
fi

# Start the web server on the specified port
echo "Starting web server on port ${port} serving $target..."
if [ -d "$target" ]; then
    # If the target is a directory, start the server from that directory
    cd "$target"
    python3 -m http.server ${port}
else
    # If the target is a file, create a temporary directory to serve the file with download headers
    tempdir=$(mktemp -d)
    cp "$target" "$tempdir/"
    cd "$tempdir"
    
    # Create a simple HTTP server to serve the file with the correct headers
    python3 -c "
import http.server
import socketserver

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Content-Disposition', 'attachment; filename=$(basename "$target")')
        super().end_headers()

Handler = CustomHandler
httpd = socketserver.TCPServer(('', ${port}), Handler)
print('Serving file for download on port ${port}...')
httpd.serve_forever()
"
    # Clean up the temporary directory after the server stops
    rm -rf "$tempdir"
fi

# Display a message when the server stops
echo "The web server has been stopped."
