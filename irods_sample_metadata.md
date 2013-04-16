Title:   iRODS Sample-level metadata
Author:  Keith James
Date:    Tue 16 Apr 2013
Version: 1.1
Comment: This document describes sample-level metadata i.e. metadata on material related to individual biological samples

## iRODS sample-level metadata ##

These metadata are attached to each iRODS data object that represents a biological sample.

## Metadata keys and values ##

|Tag	| Value	| Value source	| Value type	|  
| :----------------------	| :--------------------------	| :----------------------------------	| :-------------------------------------------------------	|  
| sample	| Sanger sample name	| S2 current_samples.name	| String	|  
| sample_id	| Sanger sample ID	| S2 current_samples.internal_id	| Integer	|  
| sample_common_name	| Sample common name	| S2 current_samples.common_name	| String	|  
| sample_accession_number	| Sample accession number	| S2 current_samples.accession number	| String	|  
| sample_consent	| Consent exists	| S2 current_samples.consent_withdrawn	| Integer [^consent]	|  
| study_id	| S2 study ID	| S2 current_studies.internal_id	| Integer	|  
| study_title	| S2 study title	| S2 current_studies.study_title	| String	|  
|	|	|	|	|  
| dcterms:creator	| Entity making the data	| Data provider	| URI e.g. http://www.sanger.ac.uk	|  
| dcterms:created	| Date stored in iRODS	| Publisher (machine or person)	| ISO8601 format date	|  
| dcterms:publisher	| Entity publishing into iRODS	| Publisher (machine or person)	| URI e.g. URI of entity in Sanger LDAP	|  
| dcterms:modified	| Date last modified in iRODS	| Updater (machine or person)	| ISO8601 format date	|  
| dcterms:identifier	| Various	| Various	| Variable [^reiterated]	|  
| dcterms:title	| Genotyping project title	| Illumina Infinium LIMS	| String	|  
| beadchip	| Unique Beadchip number	| Illumina Infinium LIMS	| Integer	|  
| beadchip_design	| Beadchip chip design name	| Illumins Infinium LIMS	| String	|  
| beadchip_section	| Beadchip section row/column|	| Illumina Infinium LIMS	| String	|  
| 	|	|	| 	|
| md5	| MD5 checksum of data	| Publisher	| String	|  
| type	| Data type/format	| Publisher	| String e.g. gtc, idat	|  

[^consent]: 1=consented, 0=unconsented, missing=unconsented

[^reiterated]: Sample identifiers mentioned elsewhere in this table may be reiterated under this key

Definitions of the domain and range of dcterms metadata may be found at the 
[Dublin Core website](http://dublincore.org/documents/dcmi-terms/)