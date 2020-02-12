#!/usr/bin/env bash

#train
CUDA_VISIBLE_DEVICES=0,1,2,3 python -m experiments.segmentation.train --dataset pcontext \
    --model deeplab --jpu --aux --aux-weight 0.4 --no-val \
    --backbone resnet50 --checkname deeplab_res50_pcontext

#test [single-scale]
CUDA_VISIBLE_DEVICES=0,1,2,3 python -m experiments.segmentation.test --dataset pcontext \
    --model deeplab --jpu --aux \
    --backbone resnet50 --resume {MODEL} --split val --mode testval

#test [multi-scale]
CUDA_VISIBLE_DEVICES=0,1,2,3 python -m experiments.segmentation.test --dataset pcontext \
    --model deeplab --jpu --aux \
    --backbone resnet50 --resume {MODEL} --split val --mode testval --ms

#predict [single-scale]
CUDA_VISIBLE_DEVICES=0,1,2,3 python -m experiments.segmentation.test --dataset pcontext \
    --model deeplab --jpu --aux \
    --backbone resnet50 --resume {MODEL} --split val --mode test

#predict [multi-scale]
CUDA_VISIBLE_DEVICES=0,1,2,3 python -m experiments.segmentation.test --dataset pcontext \
    --model deeplab --jpu --aux \
    --backbone resnet50 --resume {MODEL} --split val --mode test --ms

#fps
CUDA_VISIBLE_DEVICES=0 python -m experiments.segmentation.test_fps_params --dataset pcontext \
    --model deeplab --jpu --aux \
    --backbone resnet50
