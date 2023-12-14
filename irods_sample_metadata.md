<!-- Space: NPG -->
<!-- Parent: iRODS -->
<!-- Title: NPG iRODS metadata -->

<!-- Macro: :box:([^:]+):([^:]*):(.+):
     Template: ac:box
     Icon: true
     Name: ${1}
     Title: ${2}
     Body: ${3} -->

:box:info:Note:This page is automatically generated; any edits will be overwritten:

###### Repository information
<!-- Include: docs/includes/repo-metadata.md -->

# Sample metadata used in Wellcome Sanger Institute iRODS

These metadata may be associated with any iRODS data object or collection that contains information derived from an identifiable biological sample.

They are applied to the entire `/seq` zone and have been applied
to the legacy `/archive/GAPI` area. They are applied by the NPG team.

## Definition of a Sample

We define "sample" as a discrete item of biomaterial. In cases where multiple samples may be taken from the same individual (e.g. a human donor), these are defined as distinct and unrelated i.e. they have different sample identifiers.

Where an iRODS data object contains data relating to multiple samples, it may have multiple sample identifiers in its metadata.

## Types of metadata

### Primary metadata

Metadata that cannot be changed without becoming invalid we define as "Primary". These values are often intrinsic to raw or early processed data and may be obtained directly from there. Example primary metadata are:

- The instrument used to process the material e.g. a DNA sequencer identifier, serial number or model.
- The flowcell or other container used to hold the material, e.g. a DNA sequencing flowcell identifier, optical mapping chip barcode or plate barcode.
- The location of material within a container when processed, e.g. a flowcell lane or well address within a plate.
- Analysis kit identifiers.

Often these values are obtained by parsing data files created by the instrument, or by querying a database supplied with the instrument by the manufacturer.

Also considered primary metadata are some types of process information that are not expected to change. Example process information:

- The date and time of deposition into iRODS.
- The data checksum at the time of deposition.
- The identity of the agent depositing the data.
    
### Secondary metadata

Metadata that can change without becoming invalid we define as "Secondary". These values are usually obtained from Laboratory Information Management Systems (LIMS) and reflect the current state of knowledge about origin of the data. Example secondary metadata are:

- Sample identifiers.
- Sample grouping information e.g. cohort.
- Taxonomic information.
- Patient consent flags.

Metadata in this category can change for legitimate reasons, such as:

- A species taxonomy is reclassified after data capture.
- Patient consent is withdrawn.
- A laboratory or LIMS tracking error is corrected.

## Metadata definition summary

We have adopted [Dublin Core](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/) standard metadata where we are able to do so. For reasons of backward compatibility, our metadata do not use [OBI](http://obofoundry.org/ontology/obi.html).

### Primary metadata

 | Platform | Attribute                                       | Type             | Definition                                          | Source    |
 |----------|-------------------------------------------------|------------------|-----------------------------------------------------|-----------|
 | NA       | `dcterms:created`                               | ISO8601 datetime | Date file stored in iRODS                           | App       |
 | NA       | `dcterms:creator`                               | URI              | Creating agent                                      | App       |
 | NA       | `dcterms:publisher`                             | URI              | Publishing agent                                    | App       |
 | NA       | `dcterms:identifier`                            | String           | Identifier                                          | LIMS      |
 | NA       | `dcterms:title`                                 | String           | Project title                                       | LIMS      |
 | NA       | `dcterms:audience`                              | URI              | Data audience (machine or person)                   | App       |
 | NA       | `type`                                          | String           | File type or format                                 | App       |
 | NA       | [`md5`](#NPGiRODSmetadata-md5)                  | String           | MD5 checksum of file                                | App       |
 | NA       | [`reference`](#NPGiRODSmetadata-reference)      | String           | Reference genome used in CRAM construction          | App       |
 | NA       | [`seqchksum`](#NPGiRODSmetadata-seqchksum)      | String           | Format-independent sequence data checksum           | App       |
 | NA       | `is_paired_read`                                | Integer          | Is paired-end sequencing                            | App       |
 | NA       | [`alignment`](#NPGiRODSmetadata-alignment)      | Integer          | Is aligned to a reference                           | App       |
 | NA       | `total_reads`                                   | Integer          | Total number of reads sequenced                     | App       |
 | NA       | `manual_qc`                                     | Integer          | If defined, the outcome of the QC assessment        | App       |
 | Illumina | `id_run`                                        | Integer          | Illumina run ID                                     | App       |
 | Illumina | `lane`                                          | Integer          | Illumina flowcell lane                              | App       |
 | Illumina | `tag_index`                                     | Integer          | Illumina multiplexing tag index                     | App       |
 | Illumina | [`component`](#NPGiRODSmetadata-component)      | JSON             | JSON document describing a unit of sequence data    | App       |
 | Illumina | [`composition`](#NPGiRODSmetadata-composition)  | JSON             | JSON document describing a mixture of `component`s  | App       |
 | ONT      | `ont:device_id`                                 | String           | Device ID                                           | MinKNOW   |
 | ONT      | `ont:device_type`                               | String           | Device type                                         | MinKNOW   |
 | ONT      | `ont:distribution_version`                      | String           | Distribution (i.e. software) version                | MinKNOW   |
 | ONT      | `ont:flowcell_id`                               | String           | Flowcell ID                                         | MinKNOW   |
 | ONT      | `ont:guppy_version`                             | String           | Guppy (basecaller) version                          | MinKNOW   |
 | ONT      | `ont:hostname`                                  | String           | Instrument hostname                                 | MinKNOW   |
 | ONT      | `ont:protocol_group_id`                         | String           | Protocol group ID                                   | MinKNOW   |
 | ONT      | `ont:run_id`                                    | String           | Run ID                                              | MinKNOW   |
 | ONT      | `ont:sample_id`                                 | String           | Sample ID supplied by operator                      | App       |
 | ONT      | `ont:experiment_name`                           | String           | Synonym for Protocol group ID                       | MinKNOW   |
 | ONT      | `ont:instrument_slot`                           | Integer          | Position of flowcell on instrument                  | App       |
 | PacBio   | `cell_index`                                    | String           | PacBio Cell index                                   | SMRT Link |
 | PacBio   | `collection_number`                             | String           | PacBio Collection number                            | SMRT Link |
 | PacBio   | `instrument_name`                               | String           | PacBio instrument name                              | SMRT Link |
 | PacBio   | `data_level`                                    | String           | Primary data or secondary (derived/analysis)        | App       |
 | PacBio   | `plate_number`                                  | Integer          | PacBio plate number (for Revio runs)                | SMRT Link |
 | PacBio   | `run`                                           | String           | PacBio run ID                                       | SMRT Link |
 | PacBio   | `well`                                          | String           | PacBio sample well                                  | SMRT Link |
 | PacBio   | `sample_load_name`                              | String           | PacBio sample load name                             | SMRT Link |

 Key:

   - NA: Not Applicable.
   - App: Values generated by a software application.
   - LIMS: Values obtained from LIMS.
   - MinKNOW: Values obtained from Oxford Nanopore MinKNOW software.
   - SMRT Link: Values obtained from PacBio SMRT Link server.

### Secondary metadata

  | Platform | Attribute                  | Type             | Definition                                                      | Source |
  |----------|----------------------------|------------------|-----------------------------------------------------------------|--------|
  | NA       | `dcterms:modified`         | ISO8601 datetime | Date file last modified in iRODS                                | App    |
  | NA       | `sample_accession_number`  | String           | Public database sample accession                                | LIMS   |
  | NA       | `sample_cohort`            | String           | Cohort from which sample was derived                            | LIMS   |
  | NA       | `sample_common_name`       | String           | Species common name for the sample                              | LIMS   |
  | NA       | `sample_consent_withdrawn` | Integer          | Sample consent was withdrawn                                    | LIMS   |
  | NA       | `sample_control`           | Integer          | Sample is a control                                             | LIMS   |
  | NA       | `sample_donor_id`          | String           | Donor ID for the sample                                         | LIMS   |
  | NA       | `sample_id`                | String           | Internal sample ID                                              | LIMS   |
  | NA       | `sample`                   | String           | Stable internal sample ID                                       | LIMS   |
  | NA       | `sample_public_name`       | String           | Public ID of the sample                                         | LIMS   |
  | NA       | `sample_supplier_name`     | String           | Sample ID provided by the researcher responsible for the sample | LIMS   |
  | NA       | `study_accession_number`   | String           | Public database study accession                                 | LIMS   |
  | NA       | `study_id`                 | String           | Internal study ID                                               | LIMS   |
  | NA       | `study_name`               | String           | Free text study name                                            | LIMS   |
  | NA       | `study_title`              | String           | Free text study title                                           | LIMS   |
  | NA       | `rt_ticket`                | String           | Internal RT (helpdesk) ticket ID                                | SOP    |
  | Illumina | `library`                  | String           | Sequencing library name                                         | LIMS   |
  | Illumina | `library_id`               | String           | Sequencing library ID                                           | LIMS   |
  | Illumina | `library_type`             | String           | Sequencing library type                                         | LIMS   |
  | Pacbio   | `pacbio_library_name`      | String           | Sequencing library name                                         | LIMS   |

   Key:

   - NA: Not Applicable.
   - App: Values generated by a software application.
   - LIMS: Values obtained from LIMS.
   - SOP: Values inserted manually, following a Standard Operating Procedure (SOP).
   - SMRT Link: Values obtained from PacBio SMRT Link server.


## Metadata definition details

Some more detailed definitions of the metadata are provided below.

### Primary metadata

### alignment

This indicates that the CRAM file is aligned against a reference. It
is calculated by the code uploading the file by inspecting the file
contents with samtools. The value is 1 if the CRAM header contains an
SQ record and the file contains reads.

### component

A record describing the origin of some sequence data.  An
example serialised as JSON:

`{"id_run":38321,"position":2,"tag_index":92}`

### composition

A record describing the data that were merged into this file,
consisting os one or more [`component`](#NPGiRODSmetadata-component)s.
An example serialised as JSON:

`{"components":[{"id_run":38321,"position":2,"tag_index":92},[{"id_run":38321,"position":2,"tag_index":93}]}`

### dcterms:publisher

This is standard [Dublin Core metadata in the dcterms
namespace](https://www.dublincore.org/specifications/dublin-core/dcmi-terms/#http://purl.org/dc/terms/publisher)

The range of `dcterms:publisher` should be the publishing agent, such
as a software agent, service account or user.

### id_product

This is an identifier created by taking a digest of the sequence
components (i.e. instrument runs, positions and tag indexes) in the
file. It is shared between files that have the same source data,
whether that be single-source, or merged from multiple runs, lanes or
tag indexes, but is otherwise unique.

### md5

This is added by NPG to record our expectation of what the MD5
checksum should be. We calculate a checksum locally before upload and
set this in the metadata. iRODS calculates its own checksums for each
replica on the server side. However, we have found it useful in
practice to retain this independent reference checksum for times when
we need to diagnose problems. We also retain a history of this AVU, so
that we can see the timestamps of any times when the file was updated.

### seqchksum

A format-independent sequence data checksum. The raw data are passed
through
[`bamseqchksum`](https://github.com/gt1/biobambam2/blob/master/src/programs/bamseqchksum.1)
which generates a table of checksums (we're using version 2.0.79).
[Code in our archiving
pipeline](https://github.com/wtsi-npg/npg_irods/blob/master/lib/WTSI/NPG/HTS/Seqchksum.pm)
creates a the digest from that table


### target

This is an indicator to consumers that it's data of interest to them,
rather than e.g. internal metrics. It's a convenient filter for users
to add to a metadata query so that they can filter out the
uninteresting (to them) parts of the results.



### Secondary metadata

### Implementation notes

#### Use of standard ontologies and/or controlled vocabularies

   If rebuilding our metadata without regard to backward compatibilty,
   we would use a standard ontology, if only for interoperability
   (rather than inference capability).

#### Namespaces

   We have adopted a namespace of `ont` for Oxford Nanopore Technology
   (ONT) metadata to prevent naming clashes with existing terms. This
   is something we probably should have implemented consistently from
   the outset, for all platforms.
