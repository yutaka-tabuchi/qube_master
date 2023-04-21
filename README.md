
## Pre-requirements

- Vivado 2020.1

## Build

```
ruby create_prj.rb
vivado -mode batch -source ./create_prj.tcl
```

## Embed netrork info into bit-file

```
pushd ./resources
ruby ../gen_config.rb < ../device_list.txt
popd
ruby updatemem.rb resources/config_*
```

You can get network info embedded bit files in `bin/`. The corresponding `.ltx` file is also copied there.

To create mcs file, execute the following command.

```
vivado -mode batch -source ./create_mcs.tcl
```


## Configuration

Write bit-file, for exmaple,

```
export BITFILE=<TARGET BIT FILE>
export ADAPTER=<TARGET ADAPTER ID>
vivado -mode batch -source ./config.tcl
```

Write mcs-file, for example,

```
export MCSFILE=<TARGET MCS FILE>
export ADAPTER=<TARGET ADAPTER ID>
vivado -mode batch -source ./program_mcs.tcl
```

