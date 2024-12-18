# Lester: Rotoscope Animation Through Video Object Segmentation and Tracking

## 1. Introduction

This repository contains the code related to the Lester project. The project aims at developing a sytem capable of  automatically synthetise retro-style 2D animations from videos. 

NOTE: The results reported in the paper can be found in a different repository, [rtous/lester](https://github.com/rtous/lester).

<!--![](/data/test1/result_dual.gif)-->

<p align="center">
  <img src="img/out.gif" width="200" />
</p>

[paper](https://www.mdpi.com/1999-4893/17/8/330)

## 2 Acknowledgements

If you find this repository useful for your research, please cite the original publication:

	@Article{a17080330,
		AUTHOR = {Tous, Ruben},
		TITLE = {Lester: Rotoscope Animation through Video Object Segmentation and Tracking},
		JOURNAL = {Algorithms},
		VOLUME = {17},
		YEAR = {2024},
		NUMBER = {8},
		ARTICLE-NUMBER = {330},
		URL = {https://www.mdpi.com/1999-4893/17/8/330},
		ISSN = {1999-4893},
		DOI = {10.3390/a17080330}
	}


## 3 Usage (Google Colab)

Demo code can be find [here](https://colab.research.google.com/drive/1Xg76Uz8h4e3-L8Z1NMzO0iQe4LxxdZXm?usp=sharing)


## 4 Usage (local)

*NOTE: It can work with CPU or GPU.* 

### 4.1 SETUP

	git clone https://github.com/rtous/lester-code.git
	cd lester-code

	python3 -m venv myvenv
	source myvenv/bin/activate

	#Install SAM
	cd sam
	pip install -e .
	cd -

	#other libraries
	pip install torch==2.3.1 torchvision==0.18.1 numpy==1.26.0 shapely==2.0.2 opencv-python==3.4.17.61 pycocotools==2.0.8 matplotlib==3.9.1 Pillow==10.4.0 scikit-image==0.24.0 setuptools gdown

	#Install GroundingDINO
	#NOTE: The code searches some config files (that are within the src dire of the the venv dir) in the repo. Thus, I've copied them to a src dir in the repo root.  
	cd GroundingDINO
	python setup.py install
	#pip install -e .
	cd -
	#Alternative
	#pip install -e git+https://github.com/IDEA-Research/GroundingDINO.git@main#egg=GroundingDINO

	#ONLY WITH GPU
	# Install Pytorch Correlation
	git clone https://github.com/ClementPinard/Pytorch-Correlation-extension.git
	rm -rf Pytorch-Correlation-extension/.git*
	cd Pytorch-Correlation-extension
	python setup.py install
	cd -

	#Download checkpoints
	mkdir ./ckpt
	bash script/download_ckpt.sh

### 4.2 TEST

	#Split the video in frames
	rm -rf ./data/scenes/test/imagesFull
	mkdir ./data/scenes/test/imagesFull
	ffmpeg -i data/scenes/test/footage.mp4 -r 25 'data/scenes/test/imagesFull/%03d.png'

	#segmentation
	python segment.py test "[\"skin\",\"hair,shoes,tshirt,shorts\"]"

	#simplification and finishing
	python lowpoly_last.py data/scenes/test 0 5

	./pngfinal2video.sh data/scenes/test

<!-- 

TODO: 
	- checkpoints (1/2)
	- package versions (1/2)

	- API: coordinate endpoint (no GroundingDINO)
	- refactoring

-->

