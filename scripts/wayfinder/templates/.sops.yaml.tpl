creation_rules:
  # # Single Encrypted files
  # - path_regex: .*.encrypted
  #   shamir_threshold: 1
  #   key_groups:
  #     - age: '{{ .Env.SOPS_AGE_KEY }}'
  # # Encrypted config files
  # - path_regex: .*.yaml
  #   encrypted_regex: ^(data|stringData)$
  #   shamir_threshold: 1
  #   key_groups:
  #     - age: '{{ .Env.SOPS_AGE_KEY }}'
  # Catch All
  - age: '{{ .Env.SOPS_AGE_KEY }}'
