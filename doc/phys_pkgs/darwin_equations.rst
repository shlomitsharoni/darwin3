.. include:: ../defs.hrst

Model equations
^^^^^^^^^^^^^^^

The basic model equations are (omitting transport terms handled by the
ptracers package):

.. math::

   \partial_t\op{DIC}   &= -\sum_j U^{\op{DIC}}_j \cdot (1 + R^{\text{PIC:POC}}_j)
                           + R_{\op{DOC}} + [R_{\op{POC}}]
                           + \kappa^{{\text{diss}}}_{\mathrm{C}}\op{PIC}
                           + R^{\mathrm{C}}_j \\
   \partial_t\op{PO}_4  &= -\sum_j U^{\op{PO4}}_j + R_{\op{DOP}} + [R_{\op{POP}}] \\
   \partial_t\op{NH}_4  &= -\sum_j U^{\op{NH4}}_j + R_{\op{DON}} + [R_{\op{PON}}] - P_{\op{NO2}}
                                      - D_{\op{NH4}} \\
   \partial_t\op{NO}_2  &= -\sum_j U^{\op{NO2}}_j + P_{\op{NO2}} - P_{\op{NO3}} \\
   \partial_t\op{NO}_3  &= -\sum_j U^{\op{NO3}}_j + P_{\op{NO3}} - D_{\op{NO3}} \\
   \partial_t\op{SiO}_2 &= -\sum_j U^{\op{SiO2}}_j + R_{\op{POSi}} \\
   \partial_t\op{FeT}   &= -\sum_j U^{\op{Fe}}_j + R_{\op{DOFe}} + [R_{\op{POFe}}] + S_{\op{Fe}} \\[-1ex]
   \partial_t c_j       &= U^{\op{DIC}}_j - M_j - R^{\mathrm{C}}_j - G_j + g_j^{\mathrm{C}}\\
   \partial_t p_j       &= U^{\op{PO4}}_j - M_j Q^{\mathrm{P}}_j - G_j Q^{\mathrm{P}}_j + g_j^{\mathrm{P}}\\
   \partial_t n_j       &= U^{{\op{N}}}_j \;\;\; - M_j Q^{\mathrm{N}}_j - G_j Q^{\mathrm{N}}_j + g_j^{\mathrm{N}}\\
   \partial_t\op{si}_j  &= U^{\op{SiO2}}_j - M_j Q^{\op{Si}}_j - G_j Q^{\op{Si}}_j \\
   \partial_t\op{fe}_j  &= U^{\op{Fe}}_j \;\; - M_j Q^{\op{Fe}}_j - G_j Q^{\op{Fe}}_j + g_j^{\op{Fe}} \\
   \partial_t\op{Chl}_j &= S^{\op{Chl}}_j \; - M_j \cdot \op{Chl\text{:}C}_j - G_j \cdot \op{Chl\text{:}C}_j \\
   \partial_t\op{DOC}   &= \sum_j M_j^{\op{DOM}} \;\;\;\;\;    + (1 - f_{\op{CDOM}}) g^{\op{DOC}} + S^{\op{DOP}}_{\op{CDOM}} - R_{\op{DOC}} \\
   \partial_t\op{DOP}   &= \sum_j M_j^{\op{DOM}} Q_j^{{\mathrm{P}}}  + (1 - f_{\op{CDOM}}) g^{\op{DOP}} + S^{\op{DOC}}_{\op{CDOM}} - R_{\op{DOP}} \\
   \partial_t\op{DON}   &= \sum_j M_j^{\op{DOM}} Q_j^{{\mathrm{N}}}  + (1 - f_{\op{CDOM}}) g^{\op{DON}} + S^{\op{DON}}_{\op{CDOM}} - R_{\op{DON}} \\
   \partial_t\op{DOFe}  &= \sum_j M_j^{\op{DOM}} Q_j^{\op{Fe}} + (1 - f_{\op{CDOM}}) g^{\op{DOFe}} + S^{\op{DOFe}}_{\op{CDOM}}- R_{\op{DOFe}} \\
   \partial_t\op{PIC}   &= \sum_j M_j     R_j^{\text{PIC:POC}} + g^{\op{PIC}} - \kappa^{{\text{diss}}}_{\mathrm{C}}\op{PIC}\\
   \partial_t\op{POC}   &= \sum_j M_j^{\op{POM}} \;\;\;\;\;    + g^{\op{POC}}  - R_{\op{POC}} \\
   \partial_t\op{POP}   &= \sum_j M_j^{\op{POM}} Q_j^{{\mathrm{P}}}  + g^{\op{POP}}  - R_{\op{POP}} \\
   \partial_t\op{PON}   &= \sum_j M_j^{\op{POM}} Q_j^{{\mathrm{N}}}  + g^{\op{PON}}  - R_{\op{PON}} \\
   \partial_t\op{POSi}  &= \sum_j M_j Q_j^{\op{Si}} \;\;\;\;\; + g^{\op{POSi}} - R_{\op{POSi}} \\
   \partial_t\op{POFe}  &= \sum_j M_j^{\op{POM}} Q_j^{\op{Fe}} + g^{\op{POFe}} - R_{\op{POFe}} \\
   \partial_t\op{CDOM}  &= S^{\op{CDOM}}


The following abbreviated source terms are described in sections below:

- :math:`U`: uptake, see :ref:`Uptake`, :ref:`Growth`, :ref:`Light` and :ref:`Spectral`
- :math:`M`, :math:`R^{\mathrm{C}}`: :ref:`Mortality`
- :math:`P`: nitrification and :math:`R`, see :ref:`Remineralization`
- :math:`D`: denitrification, see :ref:`Denitrification`
- :math:`G`: grazing losses, see :ref:`Grazing`
- :math:`g`: grazing gains, see :ref:`Grazing`
- :math:`S`: synthesis/other sources, see :ref:`Synthesis` and :ref:`Iron`
- :math:`S^{\op{CDOM}}`: see :ref:`CDOM`.
  With :varlink:`DARWIN_ALLOW_CDOM`, all particulate remineralization terms
  (in square brackets [...]) except Si are absent.
  Without :varlink:`DARWIN_ALLOW_CDOM`, :math:`f_{\op{CDOM}}=0` and there is no CDOM tracer.

For alkalinity, oxygen and CDOM also see the sections below: :ref:`CarbonChemistry` and :ref:`CDOM`.


.. csv-table:: General parameters
   :delim: &
   :widths: auto
   :class: longtable
   :header: Trait, Param, Symbol, Default, Units, Description

                       & :varlink:`Kdissc`     & :math:`\kappa^{\op{diss}}` & 1/(300 days) & 1/s                            & dissolution rate for PIC
   :varlink:`R_PICPOC` & :varlink:`a_R_PICPOC` & :math:`R^{\op{PICPOC}}_j`  & 0.8          & mmol PIC (mmol POC)\ :sup:`-1` & inorganic-organic carbon ratio

