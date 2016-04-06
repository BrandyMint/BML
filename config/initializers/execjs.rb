module ExecJS
  module Runtimes
    remove_const :Node
    Node = ExternalRuntime.new(
      name:        'Node.js (V8) fixed',
      command:     ['node'], # Избавились от nodejs, которая искалась в начале
      runner_path: ExecJS.root + '/support/node_runner.js',
      encoding:    'UTF-8'
    )
  end
end
