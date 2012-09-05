REPORT_GENERATOR_URL = YAML.load_file(File.join(Rails.root, 'config', 'report_generators.yml'))[Rails.env]
