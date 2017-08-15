# make sure a config file exists
touch ~/.softcover

# use "sc" as alias to invoke softcover inside the container
alias sc="docker run -v ~/.softcover:/root/.softcover -v `pwd`:/book --rm -p 4000:4000 miguelgrinberg/softcover sc"
