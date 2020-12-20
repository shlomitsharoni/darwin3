#ifdef ALLOW_DARWIN

CBOP
C     !ROUTINE: DARWIN_FIELDS.h
C     !INTERFACE:
C #include DARWIN_FIELDS.h

C     !DESCRIPTION:
C Contains fields for darwin package
C
C Requires: SIZE.h
C

#ifndef DARWIN_ALLOW_CHLQUOTA
      COMMON /DARWIN_CHL_STORE/ chlPrev
#ifdef ALLOW_RADTRANS
      _RL chlPrev(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr,nSx,nSy,nPhoto)
#else
      _RL chlPrev(1-OLx:sNx+OLx,1-OLy:sNy+OLy,Nr,nSx,nSy)
#endif
#endif


#ifdef DARWIN_ALLOW_CONS
      COMMON /DARWIN_CHECK_CONS/
     &      DAR_cons_C_unit,
     &      DAR_cons_P_unit,
     &      DAR_cons_N_unit,
     &      DAR_cons_Fe_unit,
     &      DAR_cons_Si_unit,
     &      DAR_cons_A_unit,
     &      DAR_cons_O_unit
      INTEGER DAR_cons_C_unit
      INTEGER DAR_cons_P_unit
      INTEGER DAR_cons_N_unit
      INTEGER DAR_cons_Fe_unit
      INTEGER DAR_cons_Si_unit
      INTEGER DAR_cons_A_unit
      INTEGER DAR_cons_O_unit

      COMMON /DARWIN_CONS_3D/ DARWIN_Nfix, DARWIN_Ndenit
      _RL DARWIN_Nfix(sNx,sNy,Nr,nSx,nSy)
      _RL DARWIN_Ndenit(sNx,sNy,Nr,nSx,nSy)
#endif

CEOP
#endif /* ALLOW_DARWIN */
