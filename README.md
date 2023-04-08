# README

The implementation for "Open Relation Modeling: Learning to Define Relations between Entities"




## Requirements

```
fairseq==0.10.2
torch==1.7.1
numpy==1.17.2
tqdm==4.48.2
```



## Data

Data are available on the anonymous repo: https://osf.io/6udhz/?view_only=2150dbd65d2f451686cf8a77d066c06e



## Train

**Download pre-trained BART**

Download pre-trained `bart.large`

```
wget https://dl.fbaipublicfiles.com/fairseq/models/bart.large.tar.gz
```

Unzip files to `bart/bart.large/`



**Preprocess data**

```
bash preprocess.sh
```



**Train model**

```
bash train.sh
```



## Generation

Generate relation descriptions for entity pairs in test set

```
fairseq-generate input/k_path_large-bin/ --path tmp/k_path_large/checkpoint_best.pt --beam 5 --batch-size 128 --remove-bpe --no-repeat-ngram-size=5 --min-len=5 --max-len-b 100 --bpe gpt2 --gpt2-encoder-json encoder.json --gpt2-vocab-bpe vocab.bpe --scoring sacrebleu | tee output/k_path_large-epochbest-k5.out
```



## Evaluation

`output/k_path_large-epochbest-k5.out` contains the predicted relation descriptions and confidence scores

**Extract the output** (for models with reasoning path selection)

```
python extract_output_for_path_k.py
```

or (for models without reasoning path selection)

```
grep ^D <out> | cut -f3- > <sys>
grep ^T <out> | cut -f2- > <ref>
```



**Evaluation**

```
bash RM-scorer.sh output/k_path_large-epochbest-k5.out.sys output/k_path_large-epochbest-k5.out.ref
```



## Interactive

**Run interactive mode**

```
fairseq-interactive input/k_path_large-bin  --path tmp/k_path_large/checkpoint_best.pt  --bpe gpt2  --source-lang src --target-lang tgt  --no-repeat-ngram-size 5  --beam  5  --nbest 20  --gpt2-encoder-json encoder.json  --gpt2-vocab-bpe vocab.bpe
```



**Examples**

```
evaluation; unknown: machine learning
Output: In computer science, evaluation is the process of evaluating a machine learning algorithm to determine whether the algorithm is performing well.
```

```
data mining; facet of: machine learning; subclass of: artificial intelligence
Output: Data mining is a subfield of machine learning and artificial intelligence concerned with the collection, processing, and analysis of large amounts of data.
```





