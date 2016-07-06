BIN = ${HOME}/bin

all: install

install:
	install -m 0700 bdsync.rb ${BIN}/bdsync

clean:
	${RM} *~ here/*


