# Example scripts

- `clear.sh` - clear master clock and kick synchronous with target clients
- `readclock.sh` - read master clock
- `qubemasterclient.py` - An utility script to control qube master
- `sequececlient.py` - A test script to make registrations of commands for target clients
- `reset.py` - A reset script of time-synch sequencer.

## blocked and reset

### blocked by trying to reset invalid client

```
$ sh ./clear.sh 10.2.0.200
open: 10.3.0.255:16384
b'4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
b'3\x00\x00\x00\x00\x00\x00\x00\xe4\xcb\x9e\x0e\x00\x00\x00\x00' ('10.3.0.255', 16384)
open: 10.3.0.255:16384
kick: 0x0a0200c8:16385
b'2\x00\x00\x00\x00\x00\x00\x00\n\x02\x00\xc8\x00\x00@\x01'
b'\xfe\x00\x00\x00\x00\x00\x00\x00M\xb3\x8f\x07\x00\x00\x00\x00' ('10.3.0.255', 16384)
```

`0xfe` indicates time-out error.

### Blocked by the previous invald client

```
$ sh ./clear.sh 10.2.0.16
open: 10.3.0.255:16384
b'4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
b'3\x00\x00\x00\x00\x00\x00\x00\xad\x01\xe6-\x01\x00\x00\x00' ('10.3.0.255', 16384)
open: 10.3.0.255:16384
kick: 0x0a020010:16385
b'2\x00\x00\x00\x00\x00\x00\x00\n\x02\x00\x10\x00\x00@\x01'
b'\xff\x00\x00\x00\x00\x00\x00\x00t&+\x00\x00\x00\x00\x00' ('10.3.0.255', 16384)
```

`0xff` indicates blocked error

### Reset the inner sequence

```
$ python3 reset.py
[Reset]: dummy message
```

### Reset valid client

```
$ sh ./clear.sh 10.2.0.16
open: 10.3.0.255:16384
b'4\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
b'3\x00\x00\x00\x00\x00\x00\x00E\xc06*\x00\x00\x00\x00' ('10.3.0.255', 16384)
open: 10.3.0.255:16384
kick: 0x0a020010:16385
b'2\x00\x00\x00\x00\x00\x00\x00\n\x02\x00\x10\x00\x00@\x01'
b'3\x00\x00\x00\x00\x00\x00\x00\xac0\x1e\x00\x00\x00\x00\x00' ('10.3.0.255', 16384)
```
