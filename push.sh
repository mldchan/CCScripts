#!/bin/bash

echo "Enter message: "
read -r message

git add .
git commit -a -m "$message"
git push

