BIN = ${HOME}/bin

all: install

install:
	install -m 0700 sync.rb ${BIN}/sync

clean:
	${RM} *~ here/*


