# TT-MDL
MATLAB code of SPL2020-Tensor Denoising Using Low-Rank Tensor Train Decomposition.
MATLAB codes to reproduce the experiments in the paper.
----------------------------------------------------------------------------------------------
# Folder structure
```shell
Demo_face_desparse.m          : Facial Image Denoising (salt-and-pepper noise).
EBM_RPCA.m                    : the main function of the proposed Empirical Bayes Method for tensor RPCA
Parset.m                      : the tuned parameters
data\
├────CAVE_feathers.mat              : a test HSI
lib\                                : a directory including MATLAB codes for the proposed algorithm and some toolboxes.
├───quality_assess\         
├───TT-MDL\   
├───TT-Toolbox\         
```

You can try each demonstration by typing just 'Demo_synthetic' or 'Demo_HSI' on your command line.
----------------------------------------------------------------------------------------------
# Citation
X. Gong, W. Chen, J. Chen and B. Ai, "Tensor Denoising Using Low-Rank Tensor Train Decomposition," in IEEE Signal Processing Letters, vol. 27, pp. 1685-1689, 2020, doi: 10.1109/LSP.2020.3025038.

We would like to thank those researchers for making their codes and datasets publicly available. If you have any question, please feel free to contact me via: xiaogong@bjtu.edu.cn
