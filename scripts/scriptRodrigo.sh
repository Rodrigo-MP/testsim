#### Preparando el espacio de trabajo

mkdir -p ~/testsim
cd ~/testsim
pwd
mkdir -p data log out rest scripts

#### Guardamos nuestro directorio de trabajo en una variable

export WD=$(pwd)
echo $WD

#### Descargamos el genoma de E.coli

cd $WD/data
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz

#### Análisis de datos

for sid in $(<list of samples>)
do
   # place here the script with commands to analyse each sample
#### Control de calidad utilizando el software FastQC
if [ "$#" -eq 1 ]
then
    sampleid=$1
    echo "Running FastQC..."
    mkdir -p out/fastqc
    fastqc -o out/fastqc data/${sampleid}*.fastq.gz
    echo

   # this command should receive the sample ID as the only argument
done
# place here any commands that need to run after analysing the samples
