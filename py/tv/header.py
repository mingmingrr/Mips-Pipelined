$py(
import importlib
tv = importlib.machinery.SourceFileLoader('*',
  'py/tv/__init__.py').load_module()
)
