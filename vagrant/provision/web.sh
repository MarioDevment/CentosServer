echo "******************************************"
echo "|  Descargando roles de Ansible-Galaxy   |"
echo "******************************************"

sudo mkdir -p /etc/ansible/roles

roles_list[0]='geerlingguy.repo-epel'
roles_list[1]='geerlingguy.ntp,1.5.2'
roles_list[2]='geerlingguy.firewall,2.3.0'
roles_list[3]='geerlingguy.php-versions,2.0.0'
roles_list[4]='geerlingguy.apache-php-fpm,1.0.2'
roles_list[5]='geerlingguy.composer,1.6.1'
roles_list[6]='geerlingguy.apache,2.1.1'
roles_list[7]='geerlingguy.php-mysql,2.0.1'
roles_list[8]='geerlingguy.php,3.5.0'
roles_list[9]='geerlingguy.mysql,2.8.0'
roles_list[10]='geerlingguy.nodejs,4.1.2'
roles_list[11]='geerlingguy.git,1.4.0'
roles_list[12]='geerlingguy.blackfire,1.0.0'
roles_list[13]='geerlingguy.repo-remi,1.2.0'
roles_list[14]='geerlingguy.repo-epel,1.2.2'
roles_list[15]='kbrebanov.selinux'

sudo mkdir -p /etc/ansible/roles
for role_and_version in "${roles_list[@]}"
do
    role_and_version_for_grep="${role_and_version/,/, }"

    if ! sudo ansible-galaxy list | grep -qw "$role_and_version_for_grep";
    then
            echo "Installing ${role_and_version}"
            sudo ansible-galaxy -f install $role_and_version
   else
        echo "Already installed ${role_and_version}"
    fi
done

# Execute Ansible
echo "-> Execute Ansible"
sudo ansible-playbook /ansible/web.yml -i /ansible/inventories/hosts --connection=local