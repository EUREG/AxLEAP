#! /usr/bin/python3

import os, sys
import importlib


if __name__ == "__main__":
    sys.path.append(os.getcwd())

    design = sys.argv[1]
    application = sys.argv[2]

    myModule = importlib.import_module('designs.'+design+'.genvcd')
    myModule.genVCD(application)
    