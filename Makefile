all: compile
 
compile:
    rebar co
 
clean:
    rm -rf ebin/*.beam