halite_unittest_master:
  cloud.present:
    - provider: rackspace
    - size: 1 GB Performance
    - image: Ubuntu 12.04 LTS (Precise Pangolin)
    - script_args: -U -M -A {{ grains.get('external_ip') }} -g https://github.com/saltstack/halite.git git master
    - minion:
        master: {{ grains.get('external_ip') }}
    - failhard: True


https://github.com/saltstack/halite.git:
  git.latest:
    - rev: master
    - target: /root/halite
    - require:
      - pkg: git
    - failhard: True

install-nvm:
  cmd.run:
    - name: 'curl https://raw.github.com/creationix/nvm/master/install.sh | sh'
    - require:
      - pkg: curl
    - failhard: True

install-js-halite:
  cmd.script:
    - source: salt://halite-unittests/files/install_node_npm.sh
    - cwd: /root/halite

restart-master:
  salt.function:
    - name: 'cmd.run_all'
    - tgt: halite_unittest_master
    - arg:
      - 'salt-call service.restart salt-master'
    - failhard: True
