#!/bin/bash

echo "=== File and System Checker ==="
echo ""

# Check if a file exists
FILE="example.txt"

if [ -f "$FILE" ]; then
    echo "✓ File '$FILE' exists"
    
    # Check if file is readable
    if [ -r "$FILE" ]; then
        echo "  - File is readable"
    else
        echo "  - File is NOT readable"
    fi
    
    # Check file size
    SIZE=$(stat -f%z "$FILE" 2>/dev/null || stat -c%s "$FILE" 2>/dev/null)
    if [ "$SIZE" -gt 0 ]; then
        echo "  - File size: $SIZE bytes"
    else
        echo "  - File is empty"
    fi
else
    echo "✗ File '$FILE' does not exist"
    echo "  Creating it now..."
    echo "Hello from bash script!" > "$FILE"
fi

echo ""

# Check disk space
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "Checking disk usage..."
if [ "$DISK_USAGE" -lt 50 ]; then
    echo "✓ Disk usage is healthy: ${DISK_USAGE}%"
elif [ "$DISK_USAGE" -lt 80 ]; then
    echo "⚠ Disk usage is moderate: ${DISK_USAGE}%"
else
    echo "✗ WARNING: Disk usage is high: ${DISK_USAGE}%"
fi

echo ""

# Check number of arguments
echo "Checking command line arguments..."
if [ $# -eq 0 ]; then
    echo "No arguments provided"
elif [ $# -eq 1 ]; then
    echo "You provided 1 argument: $1"
    
    # Check if argument is a number
    if [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "  - '$1' is a number"
        
        if [ "$1" -gt 10 ]; then
            echo "  - The number is greater than 10"
        else
            echo "  - The number is 10 or less"
        fi
    else
        echo "  - '$1' is not a number"
    fi
else
    echo "You provided $# arguments: $@"
fi

echo ""

# Check current user
if [ "$EUID" -eq 0 ]; then
    echo "⚠ Running as root (superuser)"
else
    echo "✓ Running as regular user: $USER"
fi

echo ""
echo "=== Script completed ==="