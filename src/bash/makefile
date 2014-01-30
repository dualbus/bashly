BIN=\
		bin/my.paste.dpaste

all: $(BIN)

clean:
	-rm $(BIN)

bin/my.paste.dpaste:
	echo '#!/usr/bin/env bash' > bin/my.paste.dpaste
	BASHLY_PATH=lib/ ./bashly src/my.paste.dpaste >> bin/my.paste.dpaste
	chmod +x bin/my.paste.dpaste
