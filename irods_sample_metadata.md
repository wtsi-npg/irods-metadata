Title:   iRODS Sample-level metadata
Author:  Keith James
Date:	Tue 16 Apr 2013
Version: 1.1
Comment: This document describes sample-level metadata i.e. metadata on material related to individual biological samples

## iRODS sample-level metadata ##

These metadata are attached to each iRODS data object that represents a biological sample.

## Metadata keys and values ##

|Tag	| Value	| Value source	| Value type	|  
| :----------------------	| :--------------------------	| :----------------------------------	| :------------------------------------	|  
| sample	| WTSI sample name	| SS current_samples.name	| String	| 
| sample_id	| WTSI sample ID	| SS current_samples.internal_id	| Integer	|  
| sample_cohort	| WTSI cohort name	| SS current_samples.cohort	| String	|  
| sample_control	| WTSI sample control flag	| SS current_samples.control	| Integer	|  
| sample_common_name	| WTSI common name	| SS current_samples.common_name	| String	|  
| sample_accession_number	| Sample accession number	| SS current_samples.accession number	| String	|  
| sample_consent	| Consent exists	| SS current_samples.consent_withdrawn	| Integer [^consent]	|  
| study_id	| WTSI study ID	| SS current_studies.internal_id	| Integer	|  
| study_title	| WTSI study title	| SS current_studies.study_title	| String	|  
|  md5	| MD5 checksum of data	| Publisher	| String	|  
| type	| Data type/format	| Publisher	| String e.g. gtc, idat	|  
| beadchip	| Unique Beadchip number	| Illumina Infinium LIMS	| Integer	|  
| beadchip_design	| Beadchip chip design name	| Illumins Infinium LIMS	| String	|  
| beadchip_section	| Beadchip section row/column	| Illumina Infinium LIMS	| String	|  
| infinium_plate	| Infinium plate barcode	| SS current_samples.infinium_barcode	| String	|  
| infinium_well	| Infinium plate well address	| SS well.map	| String [^unpadded_plate_address]	|  
| sequenom_plate	| Sequenom plate ID	| Sequenom MSPEC LIMS	| String	|  
| sequenom_well	| Sequenom plate well address	| Sequenom MSPEC LIMS	| String [^padded_plate_address]	| 
| fluidigm_plate	| Fluidigm plate ID	| SS current_samples.fluidigm_barcode	| String	|  
| fluidigm_well	| Fluidigm well address	| SS well.map	| String [^padded_plate_address]	| 
| dcterms:creator	| Entity making the data	| Data provider	| URI e.g. http://www.sanger.ac.uk	|  
| dcterms:created	| Date stored in iRODS	| Publisher (machine or person)	| ISO8601 format date	|  
| dcterms:publisher	| Entity publishing into iRODS	| Publisher (machine or person)	| URI e.g. URI of entity in Sanger LDAP	|  
| dcterms:modified	| Date last modified in iRODS	| Updater (machine or person)	| ISO8601 format date	|  
| dcterms:identifier	| Various	| Various	| Variable [^reiterated]	|  
| dcterms:title	| Genotyping project title	| Illumina Infinium LIMS	| String [^reiterated]	|  
| dcterms:audience	| Various	| Data audience (machine or person)	| URI	|  

[^consent]: 1=consented, 0=unconsented, missing=unconsented.

[^reiterated]: Sample identifiers mentioned elsewhere in this table may be reiterated under this key.

[^padded_plate_address]: Padded address of the form 'A01', 'H12'.

[^unpadded_plate_adress]: Padded address of the form 'A1', 'H12'.

Definitions of the domain and range of dcterms metadata may be found at the 
[Dublin Core website](http://dublincore.org/documents/dcmi-terms/)