<!-- Space: NPG -->
<!-- Parent: iRODS -->
<!-- Title: Linking samples to data in iRODS -->

<!-- Macro: :box:([^:]+):([^:]*):(.+):
     Template: ac:box
     Icon: true
     Name: ${1}
     Title: ${2}
     Body: ${3} -->

:box:info:Note:This page is automatically generated; any edits will be overwritten:

###### Repository information

<!-- Include: docs/includes/repo-metadata.md -->

<!-- Include: ac:toc -->

# iRODS

[iRODS](https://irods.org) is the main platform the NPG use at WSI to enable the 
distribution of DNAP data products to researchers. It provides access control, data
virtualisation, data replication and metadata services:

- Access control: limits access to data appropriately
- Data virtualisation: presents multiple storage systems in different physical 
  locations as a single file system.
- Data replication: automatically maintains replicas of data on different physical
  sites to guard against loss.
- Metadata: to record the identity and origin of data for discovery and management. 

# iRODS locations

Data products from recent platorms are placed in a hierarchy split by manaufacturer closest to the root. i.e.

- `/seq/illumina` for Illumina (sequencing)
- `/seq/pacbio` for Pacific Biosciences: PacBio (sequencing)
- `/seq/ont` for Oxford Nanopore Technology: ONT (sequencing)
- `/seq/fluidigm` for Fluidigm (genotyping)
- `/seq/elembio` for Element Biosciences: ElemBio (sequencing)
- `/seq/ultimagen` for Ulitma Genomics: UltimaGen (sequencing) 

## run, further processing and data product hierarchies

For the newest platforms (`ont`, `elembio`, `ultimagen`) we try to reflect/maintain hierarchy of the data as output by the instrument or by the manufacturer's software.

Where possible we try to use only automatically generated metadata in the hierarchies i.e. data which is unlikely to be wrong due to inevitable human errors.

Don't expect absolute consistency! We've changed as new platforms have made new demands and as NPG has learnt lessons...

### Illumina
NovaSeq and later instruments have the default NPG processing data products in separate collections where the path describes the lanes and plexs:
- `/seq/illumina/runs/`_thousands_elements_of_NPG_id_run_`/`_NPG_id_run_`/lane`_flowcell_lane_number(s)_`/plex`_Sequencescape_tag_index_`/` , or
- if all lanes are merged `/seq/illumina/runs/`_thousands_elements_of_NPG_id_run_`/`_NPG_id_run_`/plex`_Sequencescape_tag_index_`/` 

e.g.
- `/seq/illumina/runs/48/48468/lane1/plex10` per-lane and per-plex
- `/seq/illumina/runs/48/48461/plex85` all-lanes-merged and per-plex
- `/seq/illumina/runs/48/48454/lane7-8/plex2` lane-subset-merge, per-plex

If the NPG pipeline is run with alterntive parameters _and_ the result saved to iRODS _as well as_ (rather than replacing) the origin processing output, another "`alt_process`" layer is added e.g. `/seq/illumina/runs/48/48367/lane2/plex10/bowtie2_kraken2_T2T`

Other pipelines output are stored at the same level as `runs/` or within the indiviual run `/seq/illumina/runs/`_thousands_elements_of_NPG_id_run_`/`_NPG_id_run_`/`_analysis_pipeline_`/`:
- `/seq/illumina/`_analysis_pipeline_`/`_id_for_that_instance_of_pipeline_`/` for (typically single cell) data from multiple runs, or
- `/seq/illumina/pp/runs/`_per_product_hierarchy_from_above_`/`_analysis_pipeline_`/`_pipeline_version_`/`

e.g.
- `/seq/illumina/cellranger-arc/cellranger-arc202_count_fd5ca7f373cdfbc381c221b2115ebbe8`
- `/seq/illumina/pp/runs/48/48445/lane2/plex7/ncov2019_artic_nf/v1.3.0_wsi2.0` 
- `/seq/illumina/runs/48/48297/cellranger/cellranger720_count_48297_HCA_BSTOP_RNA14593660_GRCh38-2020-A`

### ONT
Data is copied directly off instruments into iRODS into `/seq/ont/`_instrument_type_`/`_instrument_name_`/`_hierarchy_from_instrument_`/` e.g.
- `/seq/ont/promethion/PC24B148/ONTRUN-197/TRAC-2-7701/20240219_1444_2E_PAU53948_979fa814/fastq_pass/`
- `/seq/ont/promethion/PC24B148/ONTRUN-197/TRAC-2-7701/20240219_1444_2E_PAU53948_979fa814/pod5_pass/`

Offline basecalled and deplexing data goes into _similar_ hierarchies split at the `/`_instrument_name_`/` level i.e.
- `/seq/ont/`_instrument_type_`/offline-basecalls/`_instrument_name_`/`_enhanced_hierarchy_from_instrument_`/` and
- `/seq/ont/`_instrument_type_`/offline-deplexes/`_instrument_name_`/`_enhanced_hierarchy_from_instrument_`/`

e.g. `/seq/ont/promethion/offline-basecalls/PC24B148/ONTRUN-188/TRAC-2-7230/20240103_1539_3G_PAQ63575_f4272350/dorado/7.1.4/sup/simplex/pass/` .


## legacy hierarchies

Pre-NovaSeq Illumina instruments have their data stored in a higher and flat hierarchy in `/seq/` e.g.
- `/seq/48462/48462_1#9.cram`
- `/seq/48462/RunInfo.xml`
- `/seq/48462/qc/48462_1#9.ref_match.json`

Illumina Beadarray (Infinium) and Sequenom genotyping platforms have their data stored in `/archive` zone (rather than `/seq`) 
- `/archive/GAPI/gen/infinium` for Illumina Beadarray: Infinium

# iRODS metadata

The metadata in iRODS comes from two main sources:

1. The [ML warehouse](https://ssg-confluence.internal.sanger.ac.uk/x/CYIbB), which 
   provides information collated from multiple LIMS. 
2. Laboratory instruments (Illumina, PacBio, ONT, BioNano).

Metadata from the ML warehouse enables identification and tracking of data in 
relation to the originating biological material, while metadata from the instruments 
typically provide additional detail. 

In many respects, the ML warehouse is a better query platform than iRODS; it has 
more detailed and more up-to-date information, it has far better performance and 
uses SQL rather than a non-portable query DSL (domain-specific language).

Using the ML warehouse to locate in iRODS data for a particular sample has the 
disadvantage that it becomes a two-step process; first a query to the warehouse to 
identify the associated instrument runs and then a query to iRODS to locate the data 
files.

Metadata from the ML warehouse are copied to iRODS as a convenience for performing 
useful metadata queries there. However, doing this introduces the possibility for the 
metadata in iRODS to become stale when the ML warehouse is updated. More information 
about the metadata attributes and values [is available](https://ssg-confluence.internal.sanger.ac.uk/display/NPG/NPG+iRODS+metadata).

Recently we have introduced a table of iRODS data locations to the ML warehouse to 
eliminate the need for an iRODS query. This table currently covers only locations of 
Illumina runs.

## Use cases for iRODS metadata

### User stories for result retrieval and result curation


:box:info:User story:As a customer, I want to find the results of analysis on my sample, so that I can download that data for further work.:

Starting from a sample identifier (or set if identifiers), the goal is to find the 
paths of data objects in iRODS for particular result types (e.g. Illumina, PacBio), 
in order to download them.

In this situation, the simplest query would require only the ML warehouse, using 
sample identifier(s) as the parameter and yielding paths in iRODS from the 
`seq_product_irods_locations` table.

Another slightly more involved method would be to query the ML warehouse using 
sample identifier(s) as the parameter and yielding `id_product`s which could 
subsequently be used to query iRODS.


:box:info:User story:As a data curator, I want to find which sample is associated with some analysis results, so that I can ensure metadata are correct and up-to-date.:

Starting from a data object path (or paths) in iRODS, the goal is to find which 
sample (or set of samples) their data came from, in order to check or update their 
metadata.

In this situation, the simplest query would use `id_product`, joined via the 
appropriate platform-specific tables, to the sample and study tables, yielding the 
sample identity and the study it was a member of at the time of analysis.

Another possible query would be to use the data object path as a query parameter and 
join from the `seq_product_irods_locations` table. However, this assumes that all 
iRODS paths of interest will be represented in that table, which may not be the case.

Many data objects do not have an `id_product` in their iRODS metadata, or recorded 
in the ML warehouse. The workaround which give the greatest coverage of data objects 
currently is to use the iRODS `component` metadata where that exists, parse their JSON 
values and extra search parameters to use in the ML warehouse, or to use other 
metadata fields described in the table below, for their respective platforms:


### Available query parameters by platform


| Platform                | Query parameters (MLWH and iRODS)                | MLWH result                | iRODS result                    |
|-------------------------|--------------------------------------------------|----------------------------|---------------------------------|
| Illumina                | id_run, lane, tag index                          | All                        | Unmerged only                   |
| Illumina                | component JSON (id_run, lane, tag index)         | All (once parsed)          | Unmerged and merged, no subsets |
| Illumina                | component JSON (id_run, lane, tag index, subset) | None (subset not captured) | Subsets only                    |
| Illumina                | id_product                                       | All                        | Unmerged and merged, no subsets |
| Illumina library merge  | id_run, lane, tag index                          | Incorrect (too general)    | Incorrect (too general)         |
| Illumina library merge  | component JSON (id_run, lane, tag index)         | All                        | All                             |
| Illumina 10x            | id_run                                           | Incorrect? (too general)   | Incorrect? (too general)        |
| PacBio                  | run_name, well label, tag identifier             | All                        | All                             |
| PacBio                  | id_product                                       | All                        | All                             |
| ONT                     | experiment name, instrument slot, flowcell id    | All                        | All                             |
| ONT (offline processed) | experiment name, instrument slot                 | All                        | All                             |
| Fluidigm                | barcode, well address                            | All                        | All                             |
| BioNano Saphyr          | chip serial number, flowcell position            | All                        | All                             |
