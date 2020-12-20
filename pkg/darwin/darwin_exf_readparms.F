#include "DARWIN_OPTIONS.h"
#include "EXF_OPTIONS.h"

CBOP
C !ROUTINE: DARWIN_EXF_READPARMS

C !INTERFACE: ==========================================================
      SUBROUTINE DARWIN_EXF_READPARMS( iUnit, oUnit, myThid )

C !DESCRIPTION:
C     Initialize DARWIN parameters, read in data.darwin

C !USES: ===============================================================
      IMPLICIT NONE
#include "EEPARAMS.h"
#include "SIZE.h"
#include "PARAMS.h"
#ifdef ALLOW_EXCH2
#include "W2_EXCH2_SIZE.h"
#include "W2_EXCH2_TOPOLOGY.h"
#endif
#ifdef ALLOW_GCHEM
#include "GCHEM.h"
#endif
#ifdef ALLOW_EXF
#include "EXF_PARAM.h"
#include "EXF_INTERP_SIZE.h"
#include "EXF_INTERP_PARAM.h"
#endif
#ifdef ALLOW_RADTRANS
#include "RADTRANS_SIZE.h"
#include "RADTRANS_PARAMS.h"
#endif
#include "DARWIN_SIZE.h"
#include "DARWIN_PARAMS.h"
#include "DARWIN_EXF_PARAMS.h"
#include "DARWIN_EXF_FIELDS.h"

C !INPUT PARAMETERS: ===================================================
C  iUnit   :: unit number for reading
C  oUnit   :: unit number for writing
C  myThid  :: thread number
      INTEGER iUnit, oUnit, myThid

C !OUTPUT PARAMETERS: ==================================================
C  none
CEOP

#ifdef ALLOW_DARWIN

C !LOCAL VARIABLES: ====================================================
      CHARACTER*(MAX_LEN_MBUF) msgBuf
      LOGICAL darwin_haveIce
      INTEGER j, errCount

      NAMELIST/darwin_forcing_params/
     &    darwin_useQsw,
     &    darwin_useSEAICE,
C
     &    PARfile,
     &    PARperiod,
     &    PARRepCycle,
     &    PARStartTime,
     &    PARstartdate1,
     &    PARstartdate2,
     &    PARconst,
     &    PAR_exfremo_intercept,
     &    PAR_exfremo_slope,
     &    PARmask,
     &    darwin_inscal_PAR,
C
     &    ironfile,
     &    ironperiod,
     &    ironRepCycle,
     &    ironStartTime,
     &    ironstartdate1,
     &    ironstartdate2,
     &    ironconst,
     &    iron_exfremo_intercept,
     &    iron_exfremo_slope,
     &    ironmask,
     &    darwin_inscal_iron,
C
     &    icefile,
     &    iceperiod,
     &    iceRepCycle,
     &    iceStartTime,
     &    icestartdate1,
     &    icestartdate2,
     &    iceconst,
     &    ice_exfremo_intercept,
     &    ice_exfremo_slope,
     &    icemask,
     &    darwin_inscal_ice

#ifdef USE_EXF_INTERPOLATION
      NAMELIST/darwin_interp_params/
C
     &    PAR_lon0,
     &    PAR_lat0,
     &    PAR_nlon,
     &    PAR_nlat,
     &    PAR_lon_inc,
     &    PAR_interpMethod,
     &    PAR_lat_inc,
C
     &    iron_lon0,
     &    iron_lat0,
     &    iron_nlon,
     &    iron_nlat,
     &    iron_lon_inc,
     &    iron_interpMethod,
     &    iron_lat_inc,
C
     &    ice_lon0,
     &    ice_lat0,
     &    ice_nlon,
     &    ice_nlat,
     &    ice_lon_inc,
     &    ice_interpMethod,
     &    ice_lat_inc
#endif

C Open and read the data.darwin file

      darwin_useQsw = .FALSE.

      PARfile = ' '
      PARperiod             = 0.0 _d 0
      PARRepCycle           = repeatPeriod
      PARStartTime          = UNSET_RL
      PARstartdate1         = 0
      PARstartdate2         = 0
      PARconst              = UNSET_RL
      PAR_exfremo_intercept = 0.0 _d 0
      PAR_exfremo_slope     = 0.0 _d 0
      PARmask = 'c'

      darwin_inscal_PAR    =  1. _d 0

      ironfile = ' '
      ironperiod             = 0.0 _d 0
      ironRepCycle           = repeatPeriod
      ironStartTime          = UNSET_RL
      ironstartdate1         = 0
      ironstartdate2         = 0
      ironconst              = 0.0 _d 0
      iron_exfremo_intercept = 0.0 _d 0
      iron_exfremo_slope     = 0.0 _d 0
      ironmask = 'c'

      darwin_inscal_iron    =  1. _d 0

      icefile = ' '
      iceperiod             = 0.0 _d 0
      iceRepCycle           = repeatPeriod
      iceStartTime          = UNSET_RL
      icestartdate1         = 0
      icestartdate2         = 0
      iceconst              = UNSET_RL
      ice_exfremo_intercept = 0.0 _d 0
      ice_exfremo_slope     = 0.0 _d 0
      icemask = 'c'

      darwin_inscal_ice    =  1. _d 0

#ifdef USE_EXF_INTERPOLATION
      PAR_lon0 = inp_lon0
      PAR_lat0 = inp_lat0
      PAR_nlon = inp_gNx
      PAR_nlat = inp_gNy
      PAR_lon_inc = inp_dLon
      PAR_interpMethod  = 1

      iron_lon0 = inp_lon0
      iron_lat0 = inp_lat0
      iron_nlon = inp_gNx
      iron_nlat = inp_gNy
      iron_lon_inc = inp_dLon
      iron_interpMethod  = 1

      ice_lon0 = inp_lon0
      ice_lat0 = inp_lat0
      ice_nlon = inp_gNx
      ice_nlat = inp_gNy
      ice_lon_inc = inp_dLon
      ice_interpMethod  = 1

      DO j=1,MAX_LAT_INC
        PAR_lat_inc(j) = inp_dLat(j)
        iron_lat_inc(j) = inp_dLat(j)
        ice_lat_inc(j) = inp_dLat(j)
      ENDDO
#endif /* USE_EXF_INTERPOLATION */

C ======================================================================

      PARconst = UNSET_RL
      iceconst = UNSET_RL

      READ(UNIT=iUnit, NML=darwin_forcing_params)
#ifdef USE_EXF_INTERPOLATION
      READ(UNIT=iUnit, NML=darwin_interp_params)
#endif

C ======================================================================
C set alternate forcing sources

      DARWIN_haveSurfPAR = PARFile.NE.' ' .OR. PARconst.NE.UNSET_RL
      IF (PARconst .EQ. UNSET_RL) THEN
        PARconst = 0 _d 0
      ENDIF

      DARWIN_haveIce = iceFile.NE.' ' .OR. iceconst.NE.UNSET_RL
      IF (iceconst.EQ.UNSET_RL) THEN
        iceconst = 0 _d 0
      ENDIF

      IF (DARWIN_haveSurfPAR .AND. DARWIN_useQsw) THEN
        WRITE(msgBuf,'(2A)') 'DARWIN_EXF_READPARMS: ',
     &    'cannot set both PARFile/PARconst and darwin_useQsw'
       CALL PRINT_ERROR( msgBuf, myThid )
       STOP'ABNORMAL END: DARWIN_EXF_READPARMS: inconsistent light forc'
      ENDIF

      IF (DARWIN_haveIce .AND. DARWIN_useSEAICE) THEN
        WRITE(msgBuf,'(2A)') 'DARWIN_EXF_READPARMS: ',
     &    'cannot set both iceFile/iceconst and darwin_useSEAICE'
       CALL PRINT_ERROR( msgBuf, myThid )
       STOP 'ABNORMAL END: DARWIN_EXF_READPARMS: inconsistent ice forc'
      ENDIF

#ifdef ALLOW_SEAICE
      IF (useSEAICE .AND. .NOT. DARWIN_useSEAICE) THEN
        WRITE(msgBuf,'(2A)') '** WARNING ** DARWIN_EXF_READPARMS: ',
     &    'iceFile or iceconst set, not using ice area from seaice pkg'
        CALL PRINT_MESSAGE( msgBuf, errorMessageUnit,
     &                      SQUEEZE_RIGHT, myThid )
      ENDIF
#endif

#ifdef ALLOW_RADTRANS
C     darwin iceFile is used for carbon air-sea exchanges while
C     RT_iceFile is used for light.
C     If one is set but not the other we stop.
C     If they are both set but different, we warn (see further below).
      IF (DARWIN_haveIce .NEQV. RT_haveIce) THEN
       WRITE(msgBuf,'(A,A)') 'DARWIN_EXF_READPARMS: ',
     &  'One of darwin and radtrans does not have ice forcing set.'
       CALL PRINT_ERROR( msgBuf, myThid )
       WRITE(msgBuf,'(A,A)') 'DARWIN_EXF_READPARMS: ',
     &  'If you really want this, set iceconst or RT_iceconst to zero.'
       CALL PRINT_ERROR( msgBuf, myThid )
       STOP 'ABNORMAL END: DARWIN_EXF_READPARMS: ice inconsistency'
      ENDIF
#endif

#ifdef ALLOW_RADTRANS
C     warn if darwin and radtrans ice forcing are different
      IF (iceFile.NE.RT_iceFile .OR. iceconst.NE.RT_iceconst) THEN
       WRITE(msgBuf,'(A,A)') '** WARNING ** DARWIN_EXF_READPARMS: ',
     &  'iceFile or iceconst different from RT_iceFile or RT_iceconst.'
       CALL PRINT_MESSAGE( msgBuf, errorMessageUnit,
     &                     SQUEEZE_RIGHT, myThid )
       WRITE(msgBuf,'(A,A)') '** WARNING ** DARWIN_EXF_READPARMS: ',
     &  'darwin settings will be used for carbon surface forcing and'
       CALL PRINT_MESSAGE( msgBuf, errorMessageUnit,
     &                     SQUEEZE_RIGHT, myThid )
       WRITE(msgBuf,'(A,A)') '** WARNING ** DARWIN_EXF_READPARMS: ',
     &  'radtrans settings for light.'
       CALL PRINT_MESSAGE( msgBuf, errorMessageUnit,
     &                     SQUEEZE_RIGHT, myThid )
      ENDIF
#endif

      errCount = 0
      IF ( useExfYearlyFields ) THEN
       IF ( PARRepCycle.NE.0. ) THEN
        WRITE(msgBuf,'(2A)') 'DARWIN_EXF_READPARMS: The use of ',
     &       'useExfYearlyFields AND PARRepCycle is not implemented'
        CALL PRINT_ERROR( msgBuf, myThid )
        errCount = errCount + 1
       ENDIF
       IF ( ironRepCycle.NE.0. ) THEN
        WRITE(msgBuf,'(2A)') 'DARWIN_EXF_READPARMS: The use of ',
     &       'useExfYearlyFields AND ironRepCycle is not implemented'
        CALL PRINT_ERROR( msgBuf, myThid )
        errCount = errCount + 1
       ENDIF
       IF ( iceRepCycle.NE.0. ) THEN
        WRITE(msgBuf,'(2A)') 'DARWIN_EXF_READPARMS: The use of ',
     &       'useExfYearlyFields AND iceRepCycle is not implemented'
        CALL PRINT_ERROR( msgBuf, myThid )
        errCount = errCount + 1
       ENDIF
      ENDIF
      IF ( errCount.GE.1 ) THEN
        WRITE(msgBuf,'(A,I3,A)')
     &     'DARWIN_EXF_READPARMS: detected', errCount,' fatal error(s)'
        CALL PRINT_ERROR( msgBuf, myThid )
        CALL ALL_PROC_DIE( 0 )
        STOP 'ABNORMAL END: S/R DARWIN_EXF_READPARMS'
      ENDIF

      IF (oUnit .GE. 0) THEN
       WRITE(UNIT=oUnit, NML=DARWIN_FORCING_PARAMS)
#ifdef USE_EXF_INTERPOLATION
       WRITE(UNIT=oUnit, NML=DARWIN_INTERP_PARAMS)
#endif
      ENDIF

#endif /* ALLOW_DARWIN */

      RETURN
      END

