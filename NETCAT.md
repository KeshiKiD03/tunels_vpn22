# Using Netcat for File Transfers

Netcat is like a swiss army knife for geeks. It can be used for just about anything involving TCP or UDP. One of its most practical uses is to transfer files. Non *nix people usually don't have SSH setup, and it is much faster to transfer stuff with netcat then setup SSH. netcat is just a single executable, and works across all platforms (Windows,Mac OS X, Linux).

On the receiving end running,

> nc -l -p 1234 > out.file

will begin listening on port 1234.

On the sending end running,

> nc -w 3 [destination] 1234 < out.file


https://nakkaya.com/2009/04/15/using-netcat-for-file-transfers/