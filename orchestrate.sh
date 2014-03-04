#!/usr/bin/env bash

set -ex
sudo salt-call state.sls halite.master.deploy
sudo salt-call state.sls halite.minions.deploy
sudo salt test-halite-master* cmd.run 'sudo salt-key -yA'
#sudo salt adi* state.sls halite.accept-keys
#sudo salt adi* cmd.run 'salt-key -ya adi-test-halite-minion*'
sudo salt test* state.sls halite.master.config
sudo salt test* state.sls halite.master.setup-halite
sudo salt test-halite* cmd.run 'salt-call tls.create_self_signed_cert tls'
sudo salt test-halite* cmd.run '. /root/.nvm/nvm.sh && nvm use 0.10 && npm install -g coffee-script && cd /root/halite && ./prep_dist.py'
sudo salt test-halite* cmd.run 'sudo service salt-master restart'
#sudo salt test* state.sls halite.restart-master
#sudo salt adi* state.sls halite.master.run-halite-testsuite
