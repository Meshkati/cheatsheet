from transformers import AutoModel, AutoConfig
config = AutoConfig.from_pretrained('Qwen/Qwen3-VL-Embedding-2B', trust_remote_code=True)
model = AutoModel.from_config(config)

print('=== FULL MODULE TREE OF LAYER 0 ===')
print()
for name, module in model.named_modules():
    if name.startswith('layers.0'):
        depth = name.count('.') - 1
        short = name.split('.')[-1]
        cls = module.__class__.__name__
        # show param shapes if leaf
        params = list(module.named_parameters(recurse=False))
        param_info = ''
        if params:
            param_info = '  params: ' + ', '.join(f'{p[0]}{list(p[1].shape)}' for p in params)
        print(f"{'  ' * depth}{short:30s} {cls:35s}{param_info}")

print()
print('=== TOP-LEVEL MODULES (outside layers) ===')
for name, module in model.named_modules():
    if '.' not in name and name != '':
        cls = module.__class__.__name__
        params = list(module.named_parameters(recurse=False))
        param_info = ''
        if params:
            param_info = '  params: ' + ', '.join(f'{p[0]}{list(p[1].shape)}' for p in params)
        print(f'  {name:30s} {cls:35s}{param_info}')

print()
print(f'Total parameters: {sum(p.numel() for p in model.parameters()):,}')
print(f'Total layers: {config.num_hidden_layers}')


# 
# 
# 

from transformers import AutoModel, AutoConfig
config = AutoConfig.from_pretrained('Qwen/Qwen3-VL-Embedding-2B', trust_remote_code=True)
model = AutoModel.from_config(config)

print('=== FULL MODULE TREE OF LAYER 0 ===')
print()
for name, module in model.named_modules():
    if name.startswith('language_model.layers.0.'):
        depth = name.count('.') - 3
        short = name.split('.')[-1]
        cls = module.__class__.__name__
        # show param shapes if leaf
        params = list(module.named_parameters(recurse=False))
        param_info = ''
        if params:
            param_info = '  params: ' + ', '.join(f'{p[0]}{list(p[1].shape)}' for p in params)
        print(f"{'  ' * depth}{short:30s} {cls:35s}{param_info}")

print()
print('=== TOP-LEVEL MODULES (outside layers) ===')
for name, module in model.named_modules():
    if '.' not in name and name != '':
        cls = module.__class__.__name__
        params = list(module.named_parameters(recurse=False))
        param_info = ''
        if params:
            param_info = '  params: ' + ', '.join(f'{p[0]}{list(p[1].shape)}' for p in params)
        print(f'  {name:30s} {cls:35s}{param_info}')

print()
print(f'Total parameters: {sum(p.numel() for p in model.parameters()):,}')
num_layers = getattr(config, 'num_hidden_layers', None) or getattr(config.text_config, 'num_hidden_layers', None)
print(f'Total layers: {num_layers}')
