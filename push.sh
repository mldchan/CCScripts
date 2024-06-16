#!/bin/bash

message="$(date)"
echo "Push message: $message"

git add .
git commit -a -m "$message"
git push

