#!/bin/bash
echo "$1" | ssh  -o StrictHostKeyChecking=accept-new -i /config/ssh/yoursshkey user@server
