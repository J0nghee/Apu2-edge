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


