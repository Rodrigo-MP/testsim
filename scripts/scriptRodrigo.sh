#### Preparando el espacio de trabajo
#### Hemos vinculado el github a atom
mkdir -p ~/testsim
cd ~/testsim
pwd
mkdir -p data log out rest scripts

#### Guardamos nuestro directorio de trabajo en una variable

export WD=$(pwd)
echo $WD

#### Descargamos el genoma de E.coli

cd $WD
mkdir -p res/genome
cd $_
wget -O ecoli.fasta.gz ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
gunzip -k ecoli.fasta.gz

#### Creamos el índice del genoma

echo "Running STAR index..."
    mkdir -p res/genome/star_index
    STAR --runThreadN 4 --runMode genomeGenerate --genomeDir res/genome/star_index/ --genomeFastaFiles res/genome/ecoli.fasta --genomeSAindexNbases 9
    echo

#### Loop de Análisis de datos

for sid in $(ls data/*.fastq.gz | cut -d "_" -f1 | sed 's:data/::' | sort | uniq)
do
#### Script que analiza las muestras
bash /home/rodrigo/github/testsim/scripts/analyse_sample.sh

done

echo

# place here any commands that need to run after analysing the samples

#### Report del pipeline con multiqc

cd $WD
multiqc -o out/multiqc $WD

echo "Fin, reza a Linus"
