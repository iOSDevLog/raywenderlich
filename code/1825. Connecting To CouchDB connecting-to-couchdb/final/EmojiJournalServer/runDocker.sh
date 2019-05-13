#!/bin/bash
docker build -t emojijournal-run .
docker build -t emojijournal-build -f Dockerfile-tools .
docker run -v $PWD:/root/project -w /root/project emojijournal-build /swift-utils/tools-utils.sh build release
docker run -it -p 8080:8080 -v $PWD:/root/project -w /root/project emojijournal-run sh -c .build-ubuntu/release/EmojiJournalServer
