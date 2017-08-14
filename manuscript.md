---
author-meta:
- Daniel S. Himmelstein
- Anthony Gitter
- Venkat S. Malladi
- Evan M. Cofer
date-meta: '2017-08-14'
keywords:
- work-in-progress
- markdown
- manuscript
- publishing
title: 'Manubot Rootstock: Manuscript Title'
...

<small><em>
This manuscript was automatically generated
from [greenelab/manubot-rootstock@03de821](https://github.com/greenelab/manubot-rootstock/tree/03de82178edfc62f43feb57add42739c39b3b7e0)
on August 14, 2017.
</em></small>

## Authors


+ **Daniel S. Himmelstein**<br>
    ![ORCID icon](images/orcid.svg){height="13px"}
    [0000-0002-3012-7446](https://orcid.org/0000-0002-3012-7446)
    · ![GitHub icon](images/github.svg){height="13px"}
    [dhimmel](https://github.com/dhimmel)
    · ![Twitter icon](images/twitter.svg){height="13px"}
    [dhimmel](https://twitter.com/dhimmel)<br>
  <small>
     Department of Systems Pharmacology and Translational Therapeutics, University of Pennsylvania
     · Funded by GBMF4552
  </small>

+ **Anthony Gitter**<br>
    ![ORCID icon](images/orcid.svg){height="13px"}
    [0000-0002-5324-9833](https://orcid.org/0000-0002-5324-9833)
    · ![GitHub icon](images/github.svg){height="13px"}
    [agitter](https://github.com/agitter)<br>
  <small>
     Department of Biostatistics and Medical Informatics, University of Wisconsin-Madison and Morgridge Institute for Research
     · Funded by NIH U54AI117924
  </small>

+ **Venkat S. Malladi**<br>
    ![ORCID icon](images/orcid.svg){height="13px"}
    [0000-0002-0144-0564](https://orcid.org/0000-0002-0144-0564)
    · ![GitHub icon](images/github.svg){height="13px"}
    [vsmalladi](https://github.com/vsmalladi)<br>
  <small>
     The Laboratory of Signaling and Gene Expression, Cecil H. and Ida Green Center for Reproductive Biology Sciences, University of Texas Southwestern Medical Center
  </small>

+ **Evan M. Cofer**<br>
    · ![GitHub icon](images/github.svg){height="13px"}
    [evancofer](https://github.com/evancofer)<br>
  <small>
  </small>



## Abstract

Offspring of the [Deep Review](https://github.com/greenelab/deep-review).
We cite the Deep Review like [@tJKvnIaZ] or [@tJKvnIaZ].
The source repository is [@1B7Y2HVtw].


### Equations {.page_break_before}

Numbered equations can be included by using `$$` delimiters with embedded LaTeX math.
Equations can be labeled with tags like this `{#eq:label}` and referenced in text using `@eq:label`.

$$ y = mx + b $$ {#eq:line}

Equation @eq:line is the equation for a line in slope-intercept form.


### Figures

Numbered figures can be included by using the format `![Caption text](URL){#fig:label}`.
The figures can be referenced in the text by using `@fig:label`.

Figure @fig:googletrends shows the interest for "Sci-Hub" and "LibGen" over time.

![Google Trends Search interest for Sci-Hub and LibGen.](https://cdn.rawgit.com/greenelab/scihub/7891082161dbcfcd5eeb1d7b76ee99ab44b95064/explore/trends/google-trends.svg){#fig:googletrends}


### Tables

Numbered tables can be included by using Markdown syntax to create the table and then adding a tag after the caption like this `{#tbl:label}`.
The tables can be referenced in the text by using `@tbl:label`.

Table @tbl:interest shows the relative search interest of the terms "Sci-Hub" and "LibGen" the week of June 25, 2017.

| week       | search_term | interest |
|------------|-------------|----------|
| 2017-06-25 | LibGen      | 47       |
| 2017-06-25 | Sci-Hub     | 56       |

Table: Google Trends Search interest for Sci-Hub and LibGen. {#tbl:interest}
