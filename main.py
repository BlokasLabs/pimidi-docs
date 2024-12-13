import importlib.metadata

def define_env(env):
	env.variables['pimidipy_version'] = importlib.metadata.version("pimidipy")
