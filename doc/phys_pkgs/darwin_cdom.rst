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

