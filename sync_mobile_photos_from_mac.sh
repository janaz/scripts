#!/bin/bash

rsync -rltv ~/"Dropbox/Camera Uploads"/ "rsync://192.168.3.10/raid/ZDJECIA/zdjecia/Camera Uploads/"
rsync -rltv ~/Pictures/iphone/ rsync://192.168.3.10/raid/ZDJECIA/zdjecia/iphone/
