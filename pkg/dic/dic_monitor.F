#include "DIC_OPTIONS.h"

C---+----1----+----2----+----3----+----4----+----5----+----6----+----7-|--+----|
CBOP
C     !ROUTINE: DIC_MONITOR

C     !INTERFACE:
      SUBROUTINE DIC_MONITOR(
     I               myTime, myIter, myThid )

C     !DESCRIPTION:
C     Print some statistics about input forcing fields.

C     !USES:
      IMPLICIT NONE
#include "SIZE.h"
#include "EEPARAMS.h"
#include "PARAMS.h"
#include "GRID.h"
#ifdef ALLOW_MONITOR
# include "MONITOR.h"
#endif
#ifdef ALLOW_MNC
# include "MNC_PARAMS.h"
#endif
#include "DIC_VARS.h"

C     !INPUT PARAMETERS:
      _RL myTime
      INTEGER myIter
      INTEGER myThid
CEOP

#ifdef ALLOW_MONITOR

C     === Functions ====
      LOGICAL  DIFFERENT_MULTIPLE
      EXTERNAL DIFFERENT_MULTIPLE
      LOGICAL  MASTER_CPU_IO
      EXTERNAL MASTER_CPU_IO

C     == Local variables ==
      _RL dummyRL(6)
      CHARACTER*(MAX_LEN_MBUF) msgBuf
      CHARACTER*(MAX_LEN_MBUF) suff
      INTEGER l,bi,bj
#ifdef ALLOW_MNC
      INTEGER k
#endif
      LOGICAL computed

#ifdef ALLOW_BULKFORMULAE
      computed = .TRUE.
#else
      computed = .FALSE.
#endif

      IF ( DIFFERENT_MULTIPLE(monitorFreq,myTime,deltaTClock)
     &   ) THEN

        IF ( MASTER_CPU_IO(myThid) ) THEN
C--   only the master thread is allowed to switch On/Off mon_write_stdout
C     & mon_write_mnc (since it is the only thread that uses those flags):

          IF (monitor_stdio) THEN
            mon_write_stdout = .TRUE.
          ELSE
            mon_write_stdout = .FALSE.
          ENDIF
          mon_write_mnc = .FALSE.
#ifdef ALLOW_MNC
          IF (useMNC .AND. monitor_mnc) THEN
            DO k = 1,MAX_LEN_MBUF
              mon_fname(k:k) = ' '
            ENDDO
            mon_fname(1:11) = 'monitor_dic'
            CALL MNC_CW_APPEND_VNAME(
     &           'T', '-_-_--__-__t', 0,0, myThid)
            CALL MNC_CW_SET_UDIM(mon_fname, -1, myThid)
            CALL MNC_CW_RL_W_S(
     &          'D',mon_fname,1,1,'T', myTime, myThid)
            CALL MNC_CW_SET_UDIM(mon_fname, 0, myThid)
            mon_write_mnc = .TRUE.
          ENDIF
#endif /* ALLOW_MNC */

          IF ( mon_write_stdout ) THEN
            WRITE(msgBuf,'(2A)') '// ===========================',
     &           '============================'
            CALL PRINT_MESSAGE(msgBuf, mon_ioUnit, SQUEEZE_RIGHT, 1)
            WRITE(msgBuf,'(A)') '// Begin MONITOR DIC statistics'
            CALL PRINT_MESSAGE(msgBuf, mon_ioUnit, SQUEEZE_RIGHT, 1)
            WRITE(msgBuf,'(2A)') '// ===========================',
     &           '============================'
            CALL PRINT_MESSAGE(msgBuf, mon_ioUnit, SQUEEZE_RIGHT, 1)
          ENDIF

C--   endif master cpu io
        ENDIF

        CALL MON_SET_PREF('dic_',myThid)
        CALL MON_OUT_I ('tsnumber', myIter,mon_string_none,myThid)
        CALL MON_OUT_RL('time_sec', myTime,mon_string_none,myThid)

C       Print some statistics about input forcing fields

        CALL MON_WRITESTATS_RL( 1, wind, 'wind',
     &           maskInC, maskInC, rA , drF, dummyRL, myThid )

        CALL MON_WRITESTATS_RL( 1, FIce, 'FIce',
     &           maskInC, maskInC, rA , drF, dummyRL, myThid )

        CALL MON_WRITESTATS_RL( 1, pH, 'pHsurf',
     &           maskInC, maskInC, rA , drF, dummyRL, myThid )

        CALL MON_WRITESTATS_RL( 1, pCO2, 'pCO2surf',
     &           maskInC, maskInC, rA , drF, dummyRL, myThid )

        CALL MON_WRITESTATS_RL( 1, atmospCO2, 'atmospCO2',
     &           maskInC, maskInC, rA , drF, dummyRL, myThid )

        CALL MON_WRITESTATS_RL( 1, atmosP, 'atmosP',
     &           maskInC, maskInC, rA , drF, dummyRL, myThid )

        CALL MON_WRITESTATS_RL( 1, fluxCO2, 'fluxCO2',
     &           maskInC, maskInC, rA , drF, dummyRL, myThid )

        CALL MON_WRITESTATS_RL( 1, Kwexch_Pre, 'Kwexch0',
     &           maskInC, maskInC, rA , drF, dummyRL, myThid )

#ifdef DIC_ALLOW_3D_PH
        CALL MON_WRITESTATS_RL( Nr, pHC, 'pHC',
     &           hFacC, maskInC, rA , drF, dummyRL, myThid )
#endif

        IF ( MASTER_CPU_IO(myThid) ) THEN
C--   only the master thread is allowed to switch On/Off mon_write_stdout
C     & mon_write_mnc (since it is the only thread that uses those flags):

          IF ( mon_write_stdout ) THEN
            WRITE(msgBuf,'(2A)') '// ===========================',
     &           '============================'
            CALL PRINT_MESSAGE(msgBuf, mon_ioUnit, SQUEEZE_RIGHT, 1)
            WRITE(msgBuf,'(A)') '// End MONITOR DIC statistics'
            CALL PRINT_MESSAGE(msgBuf, mon_ioUnit, SQUEEZE_RIGHT, 1)
            WRITE(msgBuf,'(2A)') '// ===========================',
     &           '============================'
            CALL PRINT_MESSAGE(msgBuf, mon_ioUnit, SQUEEZE_RIGHT, 1)
          ENDIF

          mon_write_stdout = .FALSE.
          mon_write_mnc    = .FALSE.

C--   endif master cpu io
        ENDIF

C     endif different multiple
      ENDIF

#endif /* ALLOW_MONITOR */

      RETURN
      END
