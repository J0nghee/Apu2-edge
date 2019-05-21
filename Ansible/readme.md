- Install python
- ansible-lint
- commit

ROLES: 
ansible.cfg: variables (priv_key, remote_user) and enable dynamic inventory
openstack.yml: dynamic inventory

**site.yml**: richiama i **deploy.yml**

**deploy.yml**: richiamano i roles (openstack_env and webserver). Vengono richiamati i **main.yml** dentro a role_name/tasks/ 

**main.yml**: richiama i singoli playbook dentro al roles
