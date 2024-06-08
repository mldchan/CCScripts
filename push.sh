#!/bin/bash

echo "Enter message: "
read -r message

git commit -a -m "$message"
git push

