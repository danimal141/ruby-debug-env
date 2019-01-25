# ruby-debug-env

## How to use
```
$ docker build . -t ruby-debug-env:latest
$ docker run --rm --privileged --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it ruby-debug-env bash
$ gdb --args ruby $(which bundle) exec ruby ./test.rb
```
