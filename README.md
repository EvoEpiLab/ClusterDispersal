# Community Assembly Simulation

This repository contains MATLAB code to simulate **microbial community assembly** using a Gillespie algorithm and to compute the **bimodality coefficient (BC)** and **mean relative abundance (xA)** of abundance fluctuation distributions (AFDs).  
The resulting figures correspond to **Figures 3A, 3B, 4A, and 4B** of the following paper:

> **L. Marrec & S. Lehtinen**, *Cluster dispersal shapes microbial diversity during community assembly*, *PLOS Computational Biology*, in revision (2025).  
> BioRxiv preprint: [doi:10.1101/2025.04.17.649399](https://doi.org/10.1101/2025.04.17.649399)

If you find this code useful, **please cite the paper above**.

---

## Repository Structure

| File | Type | Description |
|------|------|-------------|
| `Assembly.m` | Function | Implements the **Gillespie algorithm** to simulate the assembly of microbial communities given a set of parameters. |
| `bimodality_coefficient.m` | Function | Computes the **bimodality coefficient (BC)** of simulated abundance fluctuation distributions (AFDs). |
| `simulate_data.m` | Script (main) | Main script that **sets parameter values**, runs simulations, computes BC and xA, and **plots results**. Produces figures corresponding to the paper. |

---

## Requirements

- **MATLAB R2020a or newer** (older versions may also work, but not guaranteed)
- No additional toolboxes are strictly required, but:
  - *Statistics and Machine Learning Toolbox* is recommended for certain analysis features.

---

## Getting Started

### 1. Clone or download the repository
```bash
git clone https://github.com/yourusername/ClusterDispersal.git
```

### 2. Open MATLAB and set the folder path
```matlab 
cd 'path_to_downloaded_folder'
```

### 3. Run the main script
```matlab 
simulate_data
```
