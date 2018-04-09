GHC=ghc

NAME=HelloWindows 

.PHONY: $(NAME)
$(NAME): HelloWindows.hs
	$(GHC) -XFlexibleContexts HelloWindows.hs
	
.PHONY: run
run: $(NAME)
	./$(NAME)
	
.PHONY: clean
clean:
	rm *.o *.hi HelloWindows
