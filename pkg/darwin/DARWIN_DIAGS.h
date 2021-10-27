#ifdef ALLOW_DARWIN

CBOP
C    !ROUTINE: DARWIN_DIAGS.h
C    !INTERFACE:
C #include DARWIN_DIAGS.h

C    !DESCRIPTION:
C Contains indices into diagnostics array

      integer iPP
      integer iNfix
      integer iDenit
      integer iDenitN
      integer iPPplank
      integer iPCplank
      integer iGRplank
      integer iGrGn
      integer iConsPO4
      integer iConsSi
      integer iConsFe
      integer iConsDIN
#ifdef DARWIN_ALLOW_CSTORE
      integer iEX
      integer iGW
      integer iDN
      integer iDP
      integer iDFe
      integer iDSi
      integer iDmin
# ifdef DARWIN_ALLOW_CSTORE_DIAGS
      integer iEXplank
      integer iGWplank
      integer iDNplank
      integer iDPplank
      integer iDFplank
      integer iDSplank
      integer iDminplank
# endif
#endif
      integer darwin_nDiag
      PARAMETER(iPP=     1)
      PARAMETER(iNfix=   2)
      PARAMETER(iDenit=  3)
      PARAMETER(iDenitN= 4)
      PARAMETER(iConsPO4=5)
      PARAMETER(iConsSi= 6)
      PARAMETER(iConsFe= 7)
      PARAMETER(iConsDIN=8)
#ifdef DARWIN_ALLOW_CSTORE
      PARAMETER(iEX=  9)
      PARAMETER(iGW=  iEX+1)
      PARAMETER(iDN=  iGW+1)
      PARAMETER(iDP=  iDN+1)
      PARAMETER(iDFe= iDP+1)
      PARAMETER(iDSi= iDFe+1)
      PARAMETER(iDmin=iDSi+1)
# ifdef DARWIN_ALLOW_CSTORE_DIAGS
      PARAMETER(iEXplank=iDmin+1)
      PARAMETER(iGWplank=iEXplank+nPhoto)
      PARAMETER(iDNplank=iGWplank+nPhoto)
      PARAMETER(iDPplank=iDNplank+nPhoto)
      PARAMETER(iDFplank=iDPplank+nPhoto)
      PARAMETER(iDSplank=iDFplank+nPhoto)
      PARAMETER(iDminplank=iDSplank+nPhoto)
      PARAMETER(iPPplank=iDminplank+nPhoto)
# else
      PARAMETER(iPPplank=iDmin+1)
# endif
#else
      PARAMETER(iPPplank=9)
#endif
#ifdef DARWIN_DIAG_PERTYPE
      PARAMETER(iPCplank=iPPplank+nplank)
      PARAMETER(iGRplank=iPCplank+nplank)
      PARAMETER(iGrGn=iGRplank+nplank)
      PARAMETER(darwin_nDiag=iGrGn+nplank-1)
#else
      PARAMETER(iPCplank=iPPplank)
      PARAMETER(iGRplank=iPCplank)
      PARAMETER(iGrGn=iGRplank)
      PARAMETER(darwin_nDiag=iGrGn-1)
#endif

CEOP
#endif /* ALLOW_DARWIN */
