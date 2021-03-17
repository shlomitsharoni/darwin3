.. include:: ../defs.hrst

.. _Denitrification:

Denitrification
^^^^^^^^^^^^^^^

When :varlink:`DARWIN_ALLOW_DENIT` is defined in DARWIN_OPTIONS.h,
denitrification occurs, provided
:math:`{\mathrm{O}}_2<{\mathrm{O}}_2^{{\text{crit}}}`,

.. math::

     D_{\op{NH4}} &= R_{\op{DON}} + [R_{\op{PON}}]

     D_{\op{NO3}} &= R^{\mathrm{NO3}:\mathrm{P}}_{\op{denit}} \cdot \bigl(
                         R_{\op{DOP}} + [R_{\op{POP}}] \bigr)

(the particulate organic terms are not present with :varlink:`DARWIN_ALLOW_CDOM`).

The diagnostic 'Denit' is this:

.. math::

     \op{Denit} = R^{\mathrm{N}:\mathrm{P}}_{\op{denit}} \bigl(
                      R_{\op{DOP}} + [R_{\op{POP}}] \bigr)


Also, when :math:`{\mathrm{O}}_2<{\mathrm{O}}_2^{{\text{crit}}}` and
:math:`\op{NO}_3<\op{NO}_3^{{\text{crit}}}`, all remineralization,
denitrification and CDOM degradation (except bleaching) stops.

