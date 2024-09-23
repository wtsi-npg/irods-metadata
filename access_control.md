<!-- Space: NPG -->
<!-- Parent: iRODS -->
<!-- Title: NPG iRODS access control -->

<!-- Macro: :box:([^:]+):([^:]*):(.+):
     Template: ac:box
     Icon: true
     Name: ${1}
     Title: ${2}
     Body: ${3} -->

:box:info:Note:This page is automatically generated; any edits will be overwritten:

###### Repository information

<!-- Include: docs/includes/repo-metadata.md -->

# NPG iRODS data access

## Access to data through "data_access_group" in Sequencescape

Access to data in iRODS is determined on a per-Sequencescape-study basis.

The Sequencescape study attribute "Data Access Group" can be set to contain a
space separated list of Unix groups and usernames. A user will be granted
access to the study's data if they are a member of one of the Unix groups or
are explicitly included in the list.

When the data_access_group on a study is left empty:
- if the study doesn't have a data release type of managed the members of the 
iRODS group will be set to the public group, else
- if the study has a data release type of managed the iRODS group will be left
empty (except for the iRODS groupadmin user). This means public access will be
unavailable until the "data_access_group" is changed.

When 'no_access_granted' is entered as the only data_access_group for a study
only members of default DNAP access groups will be able to access the
relevant protected data. This is useful when users with a right to access the 
protected data are unknown but due to the nature of the samples the data_access_group
should not be left empty. No unix group should ever be created with the name
'no_access_granted'.

The "data_access_group" in Sequencescape studies is normally edited by the DNAP
[SSR](https://fred.wellcomegenomecampus.org/page/5317?SearchId=2458147) team.

### Special "ss_" iRODS groups

There can be a large number of files in iRODS which belong to a particular
study. To allow fast updating of the access to these files when the "Data
Access Group" or constituent Unix group membership changes, a separate iRODS
access control group is created for each Sequencescape study, called 
`ss_<study_id>`. This is used on the files to grant access. These groups are
checked automatically several times per day to ensure they reflect current
Sequencescape study and LDAP unix group information.

### Data contaminated with human sequence

A special case is for studies with samples that can be contaminated with human
material. When processed to try to separate human contamination from the residue
"target" data, the normal study group is used to allow access to the target data,
but an `ss_<study_id>_human` iRODS group is created and used for access to the
likely human contamination data. Membership of these special iRODS groups is
also automatic and based on the "Contaminated Human Data Access Group" in a
similar manner to the above access control but defaulting to no access if empty.


## Troubleshooting

If you cannot access your data, and your username is not explicitly listed in 
the "data access group" details, you should confirm if you are a member of one
of the Unix groups in the data access group associated with the study. To find
out if you are a member of a Unix group you can use the following command to
display all Unix groups associated with your username: `groups <username>`.
Note that Unix groups need to match exactly, for example team999 in UNIX is
not equivalent to t999. 

If the above command returns the prompt `no such user`, you should confirm you
are checking the correct username.

If there are no Unix groups listed in a sequencing study's data access group,
the access should be open to all iRODS users.

If the access is open or your user should be allowed you should check for a
corresponding iRODS account. 

This can be achieved using the following command with your username:
`iquest --no-page -z seq "group member: %s" "select USER_NAME where USER_GROUP_NAME = 'public'" | grep <username>`.
This will search the public group for your username, as you are automatically
added to the public group when your iRODS account is created. If it finds your
username it will return with the output `group member <username>`, confirming
that you have an iRODS account. If you yourself do not have an iRODS account
(and so no configuration to use it) there will be an error e.g.
`ERROR: _rcConnect: setRhostInfo error, IRODS_HOST is probably not set correctly`

You will also receive an error if you do have an iRODS account but are not
logged in to iRODS. Use `iinit` to login.

If you have an iRODS account but are testing for another account and the above
command has no output then there is no iRODS account corresponding to that other
account.

If you do not have an iRODS account, or your username is not explicitly listed
and you are not a member of the Unix groups listed in the study details, then
in order to gain access you will need to: 
- Submit a ticket to Freshservice via the Okta [app](https://sanger.okta.com/)
to request an iRODS account if required

and either:
- request your addition to one of the Unix groups listed in the study's data
access group: submit a Freshservice request (ideally CC'ing the relevant person
responsible for the Unix group membership), or
- request the relevant
[SSR](https://fred.wellcomegenomecampus.org/page/5317?SearchId=2458147)
to amend the "data access group" to include your username or a relevant Unix
group of which you are a member (ideally CC'ing the relevant person responsible
for the data access for the study, e.g. the PI).
