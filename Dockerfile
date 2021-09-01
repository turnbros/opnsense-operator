FROM quay.io/operator-framework/ansible-operator:v1.11.0

COPY requirements.yml ${HOME}/requirements.yml
RUN ansible-galaxy collection install -r ${HOME}/requirements.yml \
 && chmod -R ug+rwx ${HOME}/.ansible

COPY watches.yaml ${HOME}/watches.yaml
COPY roles/ ${HOME}/roles/
COPY playbooks/ ${HOME}/playbooks/

USER root
RUN mkdir -p /usr/share/ansible/openshift &&\
    chown -R 1001:1001 /usr/share/ansible \
USER 1001

COPY modules/opnsense_firewall_alias.py /usr/share/ansible/openshift/opnsense.py
COPY modules/requirements.txt /usr/share/ansible/openshift/requirements.txt
RUN pip3 install /usr/share/ansible/openshift/requirements.txt

ENTRYPOINT ["/bin/bash"]