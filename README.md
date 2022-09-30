# TT-MDL
MATLAB codes to reproduce the experiments in the paper.
----------------------------------------------------------------------------------------------
# Folder structure
```shell
Demo_synthetic.m : Reproduce the Figure 1. Compare the denoising performance of TT and Tucker on synthetic data.
Demo_HSI.m : Compare the denoising performance of TT and Tucker on a CAVE HSI.
data\
├────CAVE_feathers.mat              : a test HSI
lib\                                : a directory including MATLAB codes for the proposed algorithm and some toolboxes.
├───quality_assess\         
├───TT-MDL\   
├───TT-Toolbox\         
```
----------------------------------------------------------------------------------------------
# Citation
X. Gong, W. Chen, J. Chen and B. Ai, "Tensor Denoising Using Low-Rank Tensor Train Decomposition," in IEEE Signal Processing Letters, vol. 27, pp. 1685-1689, 2020, doi: 10.1109/LSP.2020.3025038.

You can try each demonstration by typing 'Demo_synthetic' or 'Demo_HSI'.

We would like to thank those researchers for making their codes and datasets publicly available. If you have any question, please feel free to contact me via: xiaogong@bjtu.edu.cn
