""" Scripts RC chargés par les shells de connexion. """

from importlib import import_module
from pathlib import Path


for p in Path(__file__).parent.iterdir():
    if not p.samefile(__file__)  and p.suffix in (".xsh", ".py"):
        import_module(f".{p.stem}", __package__)
