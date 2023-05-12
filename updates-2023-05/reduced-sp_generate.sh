fairseq-generate input/reduced_s_path_large-bin/ --path tmp/reduced_s_path_large/checkpoint_best.pt --beam 5 --batch-size 128 --remove-bpe --no-repeat-ngram-size=5 --min-len=5 --max-len-b 100 --bpe gpt2 --gpt2-encoder-json encoder.json --gpt2-vocab-bpe vocab.bpe --scoring sacrebleu | tee output/reduced_s_path_large-epochbest-k5.out