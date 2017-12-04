# JBoss EAP and BPM Suite Ansible Playbooks

This project contains several Ansible playbooks to install the following:

1. JDK 1.8
2. JBoss EAP 7
3. JBoss BPM Suite 6.4

The playbooks will also configure the following:

1. [WIP] Custom datasource for Oracle, MS SQL Server, Postgres, and MySQL databases.
2. Management and application users.
3. Certificates and use them for the HTTPS configuration.
4. Custom Maven settings.xml file with custom remote repositories.
5. Open firewall ports
6. Other options!

This playbook aims to be a complete resource for installing BxMS and configuring it on an EAP server with any possible option that's documented. Many options are still in progress, but many more should be included. Check configuration files for details, as variables are only present if they're not placeholders - if the variable exists, so should the feature.

**NOTE:** You must provide the binary archives yourself! The `files` directory must first be populated with, at a minimum, the ZIP archives for Red Hat EAP and Red Hat BPMS. No, not the JAR installer. No, not the RPM either. (The community versions, Wildfly and jBPM, haven't yet been tested and are outside the intended scope of this playbook.)

## Usage

- Installation `./install.sh <environment>`
- Uninstallation `./uninstall.sh <environment>`
- [WIP] Generate self-signed SSL CSRs `./make_ssl_csr.sh <environment>`
- Update Ansible Vault password for an environment `./update_passwd.sh <environment>`

## Configuration

This playbook is configured by the files in the `inventories` folder. Each folder represents an environment (such as "dev", "prod", etc.) and are intended to be installed as such.

The `inventories\<env>\hosts` file should be used to list out the IP addresses of machines to install EAP + BxMS software on, and the relevant user names needed per machine to do so. Only the `[jboss_bxms_bc_hosts]` and `[jboss_bxms_kie_hosts]` sections need to be filled out for a standard BPMS install, as any machines listed will automatically trigger an EAP install before attempting to deploy Business Central or KIE Server.

The `inventories\<env>\group_vars` folder contains the meat of the configuration details, and was inspired by the OpenShift Ansible playbook's master configuration example. Variables for all the groups mentioned in `inventories\<env>\hosts` are present, with their file names corresponding to the section names in the `hosts` file. Options unique to EAP go in `jboss_eap_hosts`, options shared by BC and KIE Server go in `jboss_bxms_hosts`, etc.

These top-level configuration files all contain a header which points to the location of the "default" configuration files. Inside these default locations you will find greatly expanded explanations and examples, where appropriate. "Default" configuration files also rarely will hold variables that should remain static and were unnecessary for the user to access, so please DO NOT edit the "default" configuration files - use the top level files, which will override the defaults anyway!
