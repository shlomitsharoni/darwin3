.. include:: ../defs.hrst

.. _CDOM:

Dynamic CDOM
^^^^^^^^^^^^

To enable dynamic CDOM, define :varlink:`DARWIN_ALLOW_CDOM` in DARWIN_OPTIONS.h.
Remineralization of particulate organic matter to inorganic matter is then
replaced by

.. math::

     S^{\op{CDOM}} &= f_{\op{CDOM}} (R_{\op{POP}} + g^{\op{DOP}}) - D_{\op{CDOM}}

     S^{\op{DOP}}_{\op{CDOM}} &= D_{\op{CDOM}} + (1 - f_{\op{CDOM}}) R_{\op{POP}}

     S^{\op{DOC}}_{\op{CDOM}} &= R^{{\mathrm{C}}:{\mathrm{P}}}_{\op{CDOM}} (D_{\op{CDOM}} + (1 - f_{\op{CDOM}}) R_{\op{POP}}

     S^{\op{DON}}_{\op{CDOM}} &= R^{{\mathrm{N}}:{\mathrm{P}}}_{\op{CDOM}} (D_{\op{CDOM}} + (1 - f_{\op{CDOM}}) R_{\op{POP}}

     S^{\op{DOFe}}_{\op{CDOM}} &= R^{\op{Fe}:{\mathrm{P}}}_{\op{CDOM}}(D_{\op{CDOM}} + (1 - f_{\op{CDOM}}) R_{\op{POP}}

where :math:`R_{\op{POP}}` is remineralization of POP, :math:`g^{\op{DOP}}`
grazing loss to DOP and

.. math::

     D_{\op{CDOM}} = \left( r^{\op{degrad}}_{\op{CDOM}}
                     + r^{\op{bleach}}_{\op{CDOM}} \min(1, I/I_{\op{CDOM}}) \right)
                f^{{{\text{remin}}}}(T) \cdot \op{CDOM}

CDOM degradation.

Note: CDOM is in P units.  It should eventually be parameterized in term of organic carbon.


.. csv-table:: Parameters in namelist DARWIN_CDOM_PARAMS
   :delim: &
   :widths: 20,15,15,15,35
   :class: longtable
   :header: Param, Symbol, Default, Units, Description

   :varlink:`fracCDOM`   & :math:`f_{\op{CDOM}}`                          & 2/100     &                      & fraction of remineralized POP contributing to CDOM
   :varlink:`CDOMdegrd`  & :math:`r^{\op{degrad}}_{\op{CDOM}}`            & 1/200days & 1/s                  & CDOM degradation rate
   :varlink:`CDOMbleach` & :math:`r^{\op{bleach}}_{\op{CDOM}}`            & 1/15days  & 1/s                  & CDOM bleaching rate
   :varlink:`PARCDOM`    & :math:`I_{\op{CDOM}}`                          & 20        & μEin/m\ :sup:`2`/s   & PAR where CDOM bleaching becomes maximal
   :varlink:`R_NP_CDOM`  & :math:`R^{\mathrm{N}:\mathrm{P}}_{\op{CDOM}}`  & 16        & mmol N / mmol P      & CDOM N:P ratio
   :varlink:`R_FeP_CDOM` & :math:`R^{\mathrm{Fe}:\mathrm{P}}_{\op{CDOM}}` & 1D-3      & mmol Fe / mmol P     & CDOM Fe:P ratio
   :varlink:`R_CP_CDOM`  & :math:`R^{\mathrm{C}:\mathrm{P}}_{\op{CDOM}}`  & 120       & mmol C / mmol P      & CDOM C:P ratio
