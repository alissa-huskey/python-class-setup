

# python -- set PYTHONPATH
# --------------------------------------------------------------------
# make sure that python will always look for modules in the working directory
#
# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONPATH

PYTHONPATH=".${PYTHONPATH:+:}${PYTHONPATH:+:}"  # mksh: check if present
