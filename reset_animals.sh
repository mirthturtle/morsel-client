#!/bin/sh

rm animalfriends.json
cp animal-backup.json animalfriends.json

rm orders.json
rm order-history.json

echo "[]" > orders.json
echo "[]" > order-history.json

echo "Reset."