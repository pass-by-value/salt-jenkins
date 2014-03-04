runprep-dist:
  cmd.run:
    - name: '. /root/.nvm/nvm.sh; nvm use 0.10; ./prep_dist.py'
    - cwd: /root/halite
    - failhard: True

