#ifdef ALLOW_DARWIN

CBOP
C     !ROUTINE: DARWIN_EXF_FIELDS_FIELDS.h
C     !INTERFACE:
C #include DARWIN_EXF_FIELDS_FIELDS.h

C     !DESCRIPTION:
C Contains fields for darwin package read through exf
C
C Requires: SIZE.h

      COMMON /darwin_fields_c/
     &    PARfile,
     &    ironfile,
     &    icefile

      CHARACTER*128 PARfile
      CHARACTER*128 ironfile
      CHARACTER*128 icefile

      COMMON /darwin_fields_r/
     &    PAR0, PAR1, surfPAR,
     &    iron0, iron1, inputFe,
     &    ice0, ice1, iceFrac


      _RL PAR0(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL PAR1(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL surfPAR(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)

      _RL iron0(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL iron1(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL inputFe(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)

      _RL ice0(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL ice1(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
      _RL iceFrac(1-OLx:sNx+OLx,1-OLy:sNy+OLy,nSx,nSy)
CEOP

#endif /* ALLOW_DARWIN */

