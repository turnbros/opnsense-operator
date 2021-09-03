FROM quay.io/operator-framework/ansible-operator:v1.11.0

COPY requirements.yml ${HOME}/requirements.yml
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

#COPY dylanturn-opnsense-1.0.3.tar.gz ${HOME}/dylanturn-opnsense-1.0.3.tar.gz
#RUN ansible-galaxy collection install dylanturn-opnsense-1.0.3.tar.gz

COPY requirements.txt ${HOME}/requirements.txt
RUN pip install -r ${HOME}/requirements.txt

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/