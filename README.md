
## Pre-requirements

- Vivado 2020.1

## Build

```
ruby create_prj.rb
vivado -mode batch -source ./create_prj.tcl
```

To create mcs file, for example,

```
vivado -mode batch -source ./create_mcs.tcl
```


## Configuration

Write bit-file, for exmaple,

```
export BIFILE=./prj/qube_master.runs/impl_1/top.bit
vivado -mode batch -source ./config.tcl
```

Write mcs-file, for example,

```
vivado -mode batch -source ./program_mcs.tcl
```

When using Vivado Lab 2022.1 and Windows, `program_mcs.bat` is useful.

## Embed Netrork info

```
pushd ./resources
ruby ../gen_config.rb < ../device_list.txt
popd
ruby updatemem.rb resources/config_*
```

You can get network info embedded bit files in `bin/`. The corresponding `.ltx` file is also copied there.
