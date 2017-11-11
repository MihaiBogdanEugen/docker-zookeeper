## Docker [ZooKeeper] image using [Oracle JDK] ##

### Supported tags and respective Dockerfile links: ###

* ```3.4.10``` _\([3.4.10/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/zookeeper:3.4.10.svg)](https://microbadger.com/images/mbe1224/zookeeper:3.4.10 "")
* ```3.4.11```, ```latest``` _\([3.4.11/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/zookeeper:3.4.11.svg)](https://microbadger.com/images/mbe1224/zookeeper:3.4.11 "")
* ```3.5.3-beta``` _\([3.5.3-beta/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/zookeeper:3.5.3-beta.svg)](https://microbadger.com/images/mbe1224/zookeeper:3.5.3-beta "")

### Summary: ###

- Debian Stretch "slim" image variant
- Oracle JDK 8u152 addded, without MissionControl, VisualVM, JavaFX, ReadMe files, source archives, etc.
- Oracle Java Cryptography Extension added
- Python 2.7.13-2 & pip 9.0.1 added
- SHA 256 sum checks for all downloads
- JAVA\_HOME environment variable set up
- Utility scripts added for generating the configuration files

### Usage: ###

Build the image
```shell
docker build -t mbe1224/zookeeper /3.4.11/
```

Run the container
```shell
docker run -d --name=zookeeper mbe1224/zookeeper
```

### Configuration: ###

One can configure a ZooKeeper instance using environment variables. All [configuration options from the official documentation] can be used as long as the following naming rules are followed:
- upper caps
- "." replaced with "\_"
- snake case instead of pascal case
- "ZOOKEEPER\_" prefix

For example, in order to limit the number of concurrent connections a single client may make to a single member of the ZooKeeper ensemble, one has to modifiy the "maxClientCnxns" property, which is translated in the "ZOOKEEPER\_MAX\_CLIENT\_CNXNS" environment variable.

The following default values are used:

| # | Name | Default value | Meaning |
|---|---|---|---|
| 1 | ZOOKEEPER\_CLIENT\_PORT | 2181  | The port to listen for client connections |
| 2 | ZOOKEEPER\_DATA\_DIR | /var/lib/zookeeper/data | The location where ZooKeeper will store the in-memory database snapshots and, unless specified otherwise, the transaction log of updates to the database |
| 3 | ZOOKEEPER\_DATA\_LOG\_DIR | /var/lib/zookeeper/log | This allows a dedicated log device to be used, and helps avoid competition between logging and snaphots |
| 4 | ZOOKEEPER\_INIT\_LIMIT | 10 | Timeouts ZooKeeper uses to limit the length of time the ZooKeeper servers in quorum have to connect to a leader |
| 5 | ZOOKEEPER\_LOG4J\_ROOT\_LOGLEVEL | INFO | - |
| 6 | ZOOKEEPER\_SYNC\_LIMIT | 5 | Timeouts ZooKeeper to limit how far out of date a server can be from a leader |

In addition to these, the following environment variables are added for replicated scenarios:

| # | Name | Meaning |
|---|---|---|
| 1 | ZOOKEEPER\_GROUPS | Semicolon separated list of indexed group identifiers used for forming hierarchical quorums |
| 2 | ZOOKEEPER\_SERVER\_ID | Node identifier |
| 3 | ZOOKEEPER\_SERVERS | Semicolon separated list of *host:port1:port2* where *port1* is used for follower connections, if the current node is the leader and *port2* is used for server connections during the leader election phase |
| 4 | ZOOKEEPER\_WEIGHTS | Semicolon separated list of indexed weights used for forming quorums |

Furthrmore, one can tweak the JVM heap size using the "JVM\_HEAP\_SIZE" environment variable, that has a default value of 2GB.

For more information, check the [Apache ZooKeeper's Official Documentation].

### Dual licensed under: ###

* [MIT License]
* [Oracle Binary Code License Agreement]

   [Apache ZooKeeper]: <https://zookeeper.apache.org/>   
   [Apache ZooKeeper's Official Documentation]: <http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html>
   [configuration options from the official documentation]: <http://zookeeper.apache.org/doc/trunk/zookeeperAdmin.html#sc_configuration>
   [Oracle JDK]: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
   [ZooKeeper]: <https://zookeeper.apache.org/>   
   [3.4.10/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-zookeeper/blob/master/3.4.10/Dockerfile>
   [3.4.11/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-zookeeper/blob/master/3.4.11/Dockerfile>
   [3.5.3-beta/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-zookeeper/blob/master/3.5.3-beta/Dockerfile>
   [MIT License]: <https://raw.githubusercontent.com/MihaiBogdanEugen/docker-zookeeper/master/LICENSE>
   [Oracle Binary Code License Agreement]: <https://raw.githubusercontent.com/MihaiBogdanEugen/docker-zookeeper/master/Oracle_Binary_Code_License_Agreement%20for%20the%20Java%20SE%20Platform_Products_and_JavaFX>