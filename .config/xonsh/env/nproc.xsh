""". Maximum number of parallel processus. """

from multiprocessing import cpu_count

$NPROC = cpu_count()

del cpu_count
