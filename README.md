# postfix-catchall-dockerfile
From @adepasquale's [gist](https://gist.github.com/adepasquale/2efd04d6491b7e7be1bdced46ace09e9).

To use it, create a new instance as usual:

```
$ sudo docker run --name postfix -p 25:25 -d fmantuano/postfix-catchall
```

Once the docker instance is created, you can control it by running:

```
$ sudo docker start postfix

$ sudo docker stop postfix
```