""" Nombre maximum de processus parallèles. """

from multiprocessing import cpu_count

$NPROC = cpu_count()

del cpu_count
