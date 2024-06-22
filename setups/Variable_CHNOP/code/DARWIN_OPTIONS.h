#ifndef DARWIN_OPTIONS_H
#define DARWIN_OPTIONS_H
#include "PACKAGES_CONFIG.h"
#ifdef ALLOW_DARWIN

#include "CPP_OPTIONS.h"

CBOP
C    !ROUTINE: DARWIN_OPTIONS.h
C    !INTERFACE:

C    !DESCRIPTION:
C options for darwin package
CEOP

C tracer selection

C enable nitrogen quotas for all plankton
#define DARWIN_ALLOW_NQUOTA

C enable phosphorus quotas for all plankton
#define DARWIN_ALLOW_PQUOTA

C enable iron quotas for all plankton
#define DARWIN_ALLOW_FEQUOTA

C enable silica quotas for all plankton
#undef DARWIN_ALLOW_SIQUOTA

C enable chlorophyll quotas for all phototrophs
#undef DARWIN_ALLOW_CHLQUOTA

C enable internal c store for all phototrophs; also enables exudation
#undef DARWIN_ALLOW_CSTORE
#undef DARWIN_ALLOW_CSTORE_DIAGS

C enable a dynamic CDOM tracer
#undef DARWIN_ALLOW_CDOM

C enable air-sea carbon exchange and Alk and O2 tracers
#define DARWIN_ALLOW_CARBON

C consistently use the total pH scale for carbon chemistry coefficients
#undef DARWIN_TOTALPHSCALE

C Compile Munhoven (2013) "Solvesaphe" package for pH/pCO2
C  can still select Follows et al (2006) solver in data.darwin,
C  but will use solvesaphe dissociation coefficient options.
#undef DARWIN_SOLVESAPHE

C this needs to be defined for coupling to atmospheric model:
#undef DARWIN_USE_PLOAD

C enable RADI sediment model
#undef DARWIN_ALLOW_RADI

C enable macromolecular growth code; requires N, P and Fe quotas
#define DARWIN_MACROMOLECULAR_GROWTH

C enable mvariable C:H:N:O:P code; requires MACROMOLECULAR_GROWTH
C does not work yet with Bacteria and Carbon Exudation
#define DARWIN_ALLOW_VARIABLE_CHNOP


C optional bits

C enable denitrification code
#undef DARWIN_ALLOW_DENIT

C enable separate exudation of individual elements
#undef DARWIN_ALLOW_EXUDE

C enable old virtualflux code for DIC and Alk
#define ALLOW_OLD_VIRTUALFLUX

C reduce nitrate uptake by iron limitation factor
C only effective with both nitrogen and iron quota
C this option was used pre-2015 in the quota model, together with Geider,
C so the iron limitation factor is also applied to alpha_I
#undef DARWIN_NITRATE_FELIMIT

C allow organic matter to sink into bottom (sedimentize)
#undef DARWIN_BOTTOM_SINK

C CDOM is in carbon units and follows POC
#undef DARWIN_CDOM_UNITS_CARBON

C include code for reading nutrient runoff from files
#undef DARWIN_NUTRIENT_RUNOFF


C light

C compute average PAR in layer, assuming exponential decay
C (ignored when radtrans package is used)
#undef DARWIN_AVPAR

C enable GEIDER light code
#undef DARWIN_ALLOW_GEIDER

C use rho instead of acclimated Chl:C for chlorophyll synthesis
#undef DARWIN_GEIDER_RHO_SYNTH

C initialize chl as in darwin2 (with radtrans package)
#undef DARWIN_CHL_INIT_LEGACY

C scattering coefficients are per Chlorophyll (with radtrans package)
#undef DARWIN_SCATTER_CHL

C make diagnostics for instrinsic optical properties available
#undef DARWIN_DIAG_IOP


C grazing

C for quadratic grazing as in darwin2+quota
#undef DARWIN_GRAZING_SWITCH

C compute palat from size ratios
#undef DARWIN_ALLOMETRIC_PALAT

C turn off grazing temperature dependence
#undef DARWIN_NOZOOTEMP


C temperature

C turn off all temperature dependence
#undef DARWIN_NOTEMP

C select temperature version: 1, 2 or 3
#define DARWIN_TEMP_VERSION 2

C restrict phytoplankton growth to a temperature range
#undef DARWIN_TEMP_RANGE


C iron

C restrict maximum free iron
#define DARWIN_MINFE

C enable particle scavenging code
#define DARWIN_PART_SCAV

C enable variable iron sediment source
#define DARWIN_IRON_SED_SOURCE_VARIABLE

C revert to old variable iron sediment source in terms of POP
#define DARWIN_IRON_SED_SOURCE_POP

C add iron source from hydrothermal vents
#undef DARWIN_ALLOW_HYDROTHERMAL_VENTS


C diagnostics

C include code for per-type diagnostics
#define DARWIN_DIAG_PERTYPE


C debugging

C turn on debugging output
#undef DARWIN_DEBUG

C compute and print global element totals
#define DARWIN_ALLOW_CONS

C value for unused traits
#define DARWIN_UNUSED 0

C fill diagnostics for most tendency terms
#undef DARWIN_DIAG_TENDENCIES


C deprecated

C base particle scavenging on POP as in darwin2
#undef DARWIN_PART_SCAV_POP


C random trait generation

C assign traits based on random numbers as in darwin2
#undef DARWIN_RANDOM_TRAITS

C set traits for darwin2 2-species setup (requires DARWIN_RANDOM_TRAITS)
#undef DARWIN_TWO_SPECIES_SETUP

C set traits for darwin2 9-species setup (requires DARWIN_RANDOM_TRAITS)
#undef DARWIN_NINE_SPECIES_SETUP

C enable diazotrophy when using (requires DARWIN_RANDOM_TRAITS)
#undef DARWIN_ALLOW_DIAZ

#endif /* ALLOW_DARWIN */
#endif /* DARWIN_OPTIONS_H */

