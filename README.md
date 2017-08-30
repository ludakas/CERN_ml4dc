# Machine Learning for Data Certification

**CERN Openlab, summer 2017**

## Abstract
The data certification of the CMS experiment data is an essential process to guarantee high quality of the data for physical analysis. Up until now, it is being done by human experts for whom it is tedious and never ending task considering the volume of the CMS data. At its essence, it is binary classification problem of good quality data which contain signal of particle collision and bad data which are corrupted and contain weak or misleading background signal. Machine learning for data certification aims to automate this process and bring attention to phenomena which might have been missed by human inspection.
This work contributes towards the main project. The calculated statistics of the 2016 CMS dataset saved in root files are converted into NumPy arrays. Visual analysis of the features is performed and similarity metric is proposed to quantify potential discriminative power of different features. 
The highly imbalanced distribution of classes in the data presents the major challenge of the problem. Experiments with a baseline neural network model showed that the majority classifier is learned almost instantly. Subsampling in order to obtain a balanced dataset show that the model performs poorly, comparable to the random classifier. The performance which was worse than random when the good data were in minority suggest that there are little to none consistent patterns in the bad data. Hence semi-supervised techniques appear to be promising option for better performance of the data certification process.

> **Source description**

> - all_data_scripts - single purpose scripts to calculate an information from the whole 2016 data (mimima, maxima, histograms, counting corrupted lumi-sections)
> - manuals - notes regarding an enviroment set up (runnig jupyter notebook from virtual machine, setting up EOS, setting up root_numpy
> - tree_to_np.py - conversion of root files to numpy arrays
> - notebooks (other) - tools and analysis of 2016 CMS data 
