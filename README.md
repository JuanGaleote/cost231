# cost231
MATLAB function for COST-231 loss calculation.

## USAGE

This function implement the Walfish-Ikegami method for COST-231 loss calculation. It has the following inputs:

    · link_type: Path type (LOS or NLOS).
  
    · city_type: City size (medium or big).
  
    ·         f: Frequency (Hz).
  
    ·         d: Path length (m).
  
    ·        ht: Transmitter height (m).
  
    ·        hr: Receiver height (m).
  
    ·     hroof: Buildings mean height (m).
  
    ·       phi: Street-ray mean angle (º).
  
    ·         w: Streets mean height (m).
  
    ·         b: Buildings mean distance (m).

When execution finish, it returns the path loss Lb in decibel.
