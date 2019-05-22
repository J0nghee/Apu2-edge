Install virtualenv, ansible and openstack-cli

sudo pip install virtualenvwrapper
source virtualenvwrapper.sh
mkenv ansible
echo "source /path/to/virtualenvwrapper.sh" >> ~/.profile

workon ansible
pip install ansible
pip install python-openstackclient

mkdir roles
cd roles
ansible-galay init nginx
ansible-galaxy init 
files: Static files. (preseed e late_command)
defaults/main.yml: variables
handlers: Triggers (if conf file change, restart nginx)
meta: info about role
tasks: core code 
template: dynamic files.
vars: variables, but higher priority. 



ROLES: 
ansible.cfg: variables (priv_key, remote_user) and enable dynamic inventory
openstack.yml: dynamic inventory

**site.yml**: richiama i **deploy.yml**

**deploy.yml**: richiamano i roles (openstack_env and webserver). Vengono richiamati i **main.yml** dentro a role_name/tasks/ 

**main.yml**: richiama i singoli playbook dentro al roles
