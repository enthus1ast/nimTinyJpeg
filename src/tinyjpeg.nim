import os, strformat

const cdir = currentSourcePath().splitFile.dir / "tinyjpeg.h"
const headerText = &"""
#define TJE_IMPLEMENTATION
#include "{cdir}"
"""

proc tje_encode_to_file*(dest_path: cstring; width: cint; height: cint;
                        num_components: cint; src_data: ptr cuchar): cint {.importc, header: headerText.}
  ## - tje_encode_to_file -
  ##
  ## Usage:
  ##  Takes bitmap data and writes a JPEG-encoded image to disk.
  ##
  ##  PARAMETERS
  ##      dest_path:          filename to which we will write. e.g. "out.jpg"
  ##      width, height:      image size in pixels
  ##      num_components:     3 is RGB. 4 is RGBA. Those are the only supported values
  ##      src_data:           pointer to the pixel data.
  ##
  ##  RETURN:
  ##      0 on error. 1 on success.



proc tje_encode_to_file_at_quality*(dest_path: cstring; quality: cint; width: cint;
                                   height: cint; num_components: cint;
                                   src_data: ptr cuchar): cint {.importc, header: headerText.}
  ##  - tje_encode_to_file_at_quality -
  ##
  ##  Usage:
  ##   Takes bitmap data and writes a JPEG-encoded image to disk.
  ##
  ##   PARAMETERS
  ##       dest_path:          filename to which we will write. e.g. "out.jpg"
  ##       quality:            3: Highest. Compression varies wildly (between 1/3 and 1/20).
  ##                           2: Very good quality. About 1/2 the size of 3.
  ##                           1: Noticeable. About 1/6 the size of 3, or 1/3 the size of 2.
  ##       width, height:      image size in pixels
  ##       num_components:     3 is RGB. 4 is RGBA. Those are the only supported values
  ##       src_data:           pointer to the pixel data.
  ##
  ##   RETURN:
  ##       0 on error. 1 on success.


type
  tje_write_func* = proc (context: pointer; data: pointer; size: cint): void

proc tje_encode_with_func*(`func`: ptr tje_write_func; context: pointer;
                          quality: cint; width: cint; height: cint;
                          num_components: cint; src_data: ptr cuchar): cint {.importc, header: headerText.}
  ##  - tje_encode_with_func -
  ##
  ##  Usage
  ##   Same as tje_encode_to_file_at_quality, but it takes a callback that knows
  ##   how to handle (or ignore) `context`. The callback receives an array `data`
  ##   of `size` bytes, which can be written directly to a file. There is no need
  ##   to free the data.
