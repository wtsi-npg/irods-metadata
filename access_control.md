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

The Sequencescape study attribute "data access group" can be set to contain a
space separated list of Unix groups and usernames. A user will be granted
access to the study's data if they are a member of one of the Unix groups or
are explicitly included in the list.

When the data_access_group on a study is left empty:
- if the study is associated with sequencing, the members of the iRODS group
will be set to the public group
- if the study is not associated with sequencing, e.g. old Illumina
beadarray, the iRODS group will be left empty (except for the iRODS groupadmin
user). This means public access will be unavailable until the
"data_access_group" is changed.

The "data_access_group" in Sequencescape studies is normally edited by the DNAP
[SSR](https://fred.wellcomegenomecampus.org/page/5317?SearchId=2458147) team.

### Special "ss_" iRODS groups

There can be a large number of files in iRODS which belong to a particular
study. To allow fast updating of the access to these files when the "data
access group" or constituent Unix group membership changes, a separate iRODS
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
not automatic and so the data is not normally accessible. Although not currently
in the LIMS, requests for access are tracked in an audit-able manner by an RT
ticket to new-seq-pipe@sanger.ac.uk.


## Troubleshooting

If you have no iRODS account, or your username is not explicitly listed and
you are not a member of the Unix groups listed, then in order to gain access
you will need to: 
- ensure you have an iRODS account. Email servicedesk@sanger.ac.uk to request
one if required.

and either:
- request your addition to one of the Unix groups listed: email
servicedesk@sanger.ac.uk (ideally CC'ing the relevant person responsible for
the group membership), or
- request the relevant
[SSR](https://fred.wellcomegenomecampus.org/page/5317?SearchId=2458147)
to amend the "data access group" to include your username or a relevant Unix
group of which you are a member (ideally CC'ing the relevant person responsible
for the data access for the study, e.g. the PI). Note that UNIX groups need to
match exactly, for example team999 in UNIX is not equivalent to t999.
