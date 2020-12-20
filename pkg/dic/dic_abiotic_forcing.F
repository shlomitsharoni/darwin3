#include "DIC_OPTIONS.h"

CBOP
C !ROUTINE: DIC_ABIOTIC_FORCING

C !INTERFACE: ==========================================================
      SUBROUTINE DIC_ABIOTIC_FORCING(
     O                      SURC, SURA, SURO,
     I                      iDIC, iALK, iPO4, iSi, iO2,
     I                      ptr2mM,
     I                      bi, bj, iMin, iMax, jMin, jMax,
     I                      myIter, myTime, myThid )

C !DESCRIPTION:
C updates all the tracers for the effects of air-sea exchange,
C biological activity and remineralization

C !USES: ===============================================================
      IMPLICIT NONE
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "GRID.h"
#include "DYNVARS.h"
#include "DIC_VARS.h"
#include "PTRACERS_SIZE.h"
#include "PTRACERS_PARAMS.h"
#include "PTRACERS_FIELDS.h"

C !INPUT PARAMETERS: ===================================================
C  iDIC       :: ptracer index for dissolced inorganic carbon
C  iALK       :: ptracer index for alkalinity
C  iPO4       :: ptracer index for phosphate
C  iSi        :: ptracer index for silicate
c  iO2        :: ptracer index for oxygen
c  ptr2mM     :: conversion factor from ptracer units to mol/m3
c  bi, bj     :: current tile indices
c  iMin, iMax :: i loop range
c  jMin, jMax :: j loop range
C  myIter     :: current timestep
C  myTime     :: current time
C  myThid     :: thread number
      INTEGER iDIC, iALK, iPO4, iSi, iO2
      INTEGER bi, bj, iMin, iMax, jMin, jMax
      INTEGER myIter
      _RL ptr2mM
      _RL myTime
      INTEGER myThid

C !OUTPUT PARAMETERS: ==================================================
C  SURA :: tendency of alkalinity due to freshwater
C  SURC :: tendency of DIC due to air-sea exchange and virtual flux
C  SURO :: tendency of O2 due to air-sea exchange
      _RL SURA(1-OLx:sNx+OLx,1-OLy:sNy+OLy)
      _RL SURC(1-OLx:sNx+OLx,1-OLy:sNy+OLy)
      _RL SURO(1-OLx:sNx+OLx,1-OLy:sNy+OLy)

#ifdef ALLOW_DIC

C !LOCAL VARIABLES: ====================================================
C  i,j :: loop indices
      INTEGER i,j
CEOP

#ifdef ALLOW_DEBUG
      IF (debugMode) CALL DEBUG_ENTER('DIC_ABIOTIC_FORCING',myThid)
#endif

      IF ( useThSIce .OR. useSEAICE .OR. useCoupler ) THEN
#ifdef ALLOW_DEBUG
        IF (debugMode) CALL DEBUG_CALL('DIC_FIELDS_UPDATE',myThid)
#endif
        CALL DIC_FIELDS_UPDATE(
     I                    bi, bj, myTime, myIter, myThid )
      ENDIF

C carbon air-sea interaction
#ifdef ALLOW_DEBUG
      IF (debugMode) CALL DEBUG_CALL('DIC_SURFFORCING',myThid)
#endif
      CALL DIC_SURFFORCING(
     I                       iDIC, iALK, iPO4, iSi,
     O                       SURC,
     I                       ptr2mM,
     I                       bi, bj, iMin, iMax, jMin, jMax,
     I                       myIter, myTime, myThid )

#ifdef ALLOW_OLD_VIRTUALFLUX
C alkalinity air-sea interaction
#ifdef ALLOW_DEBUG
      IF (debugMode) CALL DEBUG_CALL('ALK_SURFFORCING',myThid)
#endif
      CALL ALK_SURFFORCING(
     O                       SURA,
     I                       bi, bj, iMin, iMax, jMin, jMax,
     I                       myIter, myTime, myThid )
#endif

      IF (iO2 .GT. 0) THEN
C oxygen air-sea interaction
#ifdef ALLOW_DEBUG
       IF (debugMode) CALL DEBUG_CALL('O2_SURFFORCING',myThid)
#endif
       CALL O2_SURFFORCING(
     I                       iO2,
     O                       SURO,
     I                       ptr2mM,
     I                       bi, bj, iMin, iMax, jMin, jMax,
     I                       myIter, myTime, myThid )
      ENDIF

#ifdef ALLOW_DEBUG
      IF (debugMode) CALL DEBUG_LEAVE('DIC_ABIOTIC_FORCING',myThid)
#endif

#endif /* ALLOW_DIC */

      RETURN
      END
