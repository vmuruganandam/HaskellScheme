# Our handy-dandy Makefile. Update this if the build process changes
# It spits out an executable named "scheme" that is .gitignore'd

scheme : Main.hs Parser.hs Datatypes.hs Eval.hs Primitives.hs Primitives/Equal.hs Primitives/IO.hs Primitives/List.hs Unpackers.hs
	ghc -fglasgow-exts -o scheme --make Main.hs
