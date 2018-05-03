# Pipelined MIPS Processor

MIPS I processor for EEL4713. Implementation relies heavily on templates to
create pseudo record types and pseudo enum types in macros. Is that a good idea?
Probably not. Is there a better solution? Who knows.

## Getting Started

### Prerequisites

Building the templated files requires
[Python 3](https://www.python.org/downloads),
[pyexpander](https://pypi.org/project/pyexpander/),
and [GNU make](https://www.gnu.org/software/make).

```
# pacman -S python make
# pip3 install pyexpander
```

### Building

Simply run

```
make
```

and the compiled templates will be automatically placed into `sv/`.

## License

This project is licensed under the MIT License - see the
[LICENSE.md](LICENSE.md) file for details.

