[NAME()]
profile-desc="Base profile for best SHOW()"
SORT()
ytdl-format=BEST()

[NAME(u)]
profile-desc="Best SHOW() without sorting over size"
ytdl-format=BEST()

[NAME(b)]
profile-desc="Best SHOW() with big buffers"
BIG()
profile=NAME(s)

[NAME(f)]
profile-desc="Best SHOW() with higher fps"
SORT()
ytdl-format=BESTF()

[NAME(p)]
profile-desc="SHOW() with all big"
BIG()
profile=NAME(f)
