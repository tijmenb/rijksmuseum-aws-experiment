# Rijks x AWS

Attempt at using AWS facial recognition to find look-a-likes in the Rijksmuseum's art collection.

## Step 1: create a database of objects

Download all the images to a folder by `bundle rake download_individual_json`

After that, `bundle rake combine_json` will generate a single `combined.json` with the
object IDs and image URLs. The database is checked in

## Step 2: download images

Start a EC2 instance. I chose a `t2.micro`. SSH into the machine and run:

```
git clone https://github.com/tijmenb/rijksmuseum-aws-experiment.git
cd rijksmuseum-aws-experiment
ruby download-images.rb
```

This will take a lot of time.

## Step 3: move images to S3
