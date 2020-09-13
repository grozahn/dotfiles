#!/usr/bin/env python

# Filter images with low resolution

import os
import sys
from PIL import Image


def main(argv):
    if len(argv) < 4:
        print("Usage: %s <src_dir> <width> <height>" % argv[0],
              file=sys.stderr)
        exit(1)

    source_dir = argv[1]
    width = int(argv[2])
    height = int(argv[3])

    for fn in os.listdir(source_dir):
        try:
            with Image.open(os.path.join(source_dir, fn)) as img:
                width, height = img.size
                if width >= width or height >= height:
                    print(os.path.join(source_dir, fn))
        except OSError as e:
            print(e, file=sys.stderr)


if __name__ == "__main__":
    main(sys.argv)
