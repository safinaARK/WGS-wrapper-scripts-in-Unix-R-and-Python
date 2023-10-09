# WGS-wrapper-scripts-in-Unix-R-and-Python
Salmonella typhi and Paratyphi scripts
## -------------Download large Number of Fastq Files-------------
**1. Choose the Desired Bacterial Project**<br>
**2. Retrieve the Project Number from NCBI**
**3. Obtain the Project's TSV File from ENA Browser to Access SRA Fastq HTML Links**<br>
**4. Aggregate All Links into a Shell Script (Save as "download.sh")**<br>
**5. The Shell Script Should Resemble This Format:**<br>
```
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR220/007/ERR2204597/ERR2204597_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR220/007/ERR2204597/ERR2204597_2.fastq.gz
```
**6. Note that the following steps are intended for handling a large number of SRA IDs. If you only need to download a single file, you can do 
so directly from the web page or by using the `wget` command without creating a bash script.**

## -------------Extract Meta-Data-------------
**1. We utilized Entrez Direct to retrieve metadata for our SRA identifiers.**<br>
**2. Execute the following command in a Unix terminal window for installation.**
```
sh -c "$(curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh)"
```
>Command Description:

- curl -fsSL https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh: This part of the command uses curl to download the installation script (install-edirect.sh) from the NCBI FTP server.<br> 
- The -fsSL flags are used to specify that curl should follow redirects (-L), be silent during the download (-s), and show progress information (-S).
sh -c "$(...)": This command part runs the downloaded script using the shell. The (...)syntax is used to execute the curl command output as a script.
```
echo "export PATH=\$HOME/edirect:\$PATH" >> $HOME/.bash_profile
```
>Command Description:

- "export PATH=\$HOME/edirect:\$PATH": This is the text that will be printed. It sets the PATH environment variable to include the directory $HOME/edirect followed by a colon (:) and then the existing PATH.<br>
- The $HOME variable represents your home directory.$HOME/.bash_profile: This part of the command appends the printed text to the end of your ~/.bash_profile file.

```
export PATH=${HOME}/edirect:${PATH}
```
>Command Description:

- To configure the `PATH` for the current terminal session.

**3. Commands to extract metadata, It consists of two steps: <br>**
**Step 1:** primarily involves identifying sample IDs by executing the following command:

```
epost -db sra -input sra_ids.txt -format acc |
efetch -format runinfo -mode xml |
xtract -pattern Row -element  Run BioProject BioSample ScientificName LibraryStrategy LibrarySelection LibrarySource LibraryLayout Platform Model Sample > output_file.csv
```
The `sra_ids.txt` contains the SRA IDs.<br>
**Step 2:** entails retrieving all the metadata for the provided sample IDs. Assuming you have a file named `sample_ids.txt` containing the sample IDs, you can use the following command:

```
# Use E-utilities to search the "biosample" database using a list of accession numbers from "sra.txt"
epost -db biosample -input sample_ids.txt -format acc |
# Retrieve metadata in XML format for each BioSample accession
efetch -format runinfo -mode xml |
# Extract specific information from the XML output
xtract -pattern BioSample -NAME "(NA)" -block Id -if Id@db_label -equals "Sample name" -NAME Id \
       -block Ids -element "&NAME" -CFSAN "(NA)" -block Id -if Id@db -equals "CFSAN" -CFSAN Id \
       -block Ids -element "&CFSAN" -SRA "(NA)" -block Id -if Id@db -equals "SRA" -SRA Id \
       -block Ids -first Id -element "&SRA" -STRAIN "(NA)" -block Attribute -if Attribute@attribute_name -equals "strain" -STRAIN Attribute \
       -block Attributes -element "&STRAIN" -ISOLATE "(NA)" -block Attribute -if Attribute@attribute_name -equals "isolate" -ISOLATE Attribute \
       -block Attributes -element "&ISOLATE" -ALIAS "(NA)" -block Attribute -if Attribute@attribute_name -equals "isolate_name_alias" -ALIAS Attribute \
       -block Attributes -element "&ALIAS" -SEROVAR "(NA)" -block Attribute -if Attribute@attribute_name -equals "serovar" -SEROVAR Attribute \
       -block Attributes -element "&SEROVAR" -SEROTYPE "(NA)" -block Attribute -if Attribute@attribute_name -equals "serotype" -SEROTYPE Attribute \
       -block Attributes -element "&SEROTYPE" -DATE "(NA)" -block Attribute -if Attribute@attribute_name -equals "collection_date" -DATE Attribute \
       -block Attributes -element "&DATE" -LATLON "(NA)" -block Attribute -if Attribute@attribute_name -equals "lat_lon" -LATLON Attribute \
       -block Attributes -element "&LATLON" -LOC "(NA)" -block Attribute -if Attribute@attribute_name -equals "geo_loc_name" -LOC Attribute \
       -block Attributes -element "&LOC" -HOST "(NA)" -block Attribute -if Attribute@attribute_name -equals "host" -HOST Attribute \
       -block Attributes -element "&HOST" -SOURCE "(NA)" -block Attribute -if Attribute@attribute_name -equals "isolation_source" -SOURCE Attribute \
       -block Attributes -element "&SOURCE" -PACKAGE "(NA)" -block Attribute -if Attribute@attribute_name -equals "attribute_package" -PACKAGE Attribute \
       -block Attributes -element "&PACKAGE" -IFSAC "(NA)" -block Attribute -if Attribute@attribute_name -equals "IFSAC+ Category" -IFSAC Attribute \
       -block Attributes -element "&IFSAC" -FOOD "(NA)" -block Attribute -if Attribute@attribute_name -equals "FoodOn Ontology Term" -FOOD Attribute \
       -block Attributes -element "&FOOD" -LAB "(NA)" -block Attribute -if Attribute@attribute_name -equals "collected_by" -LAB Attribute \
       -block Attributes -element "&LAB" > output_file.csv

```
**5. Now that you have both the Fastq files and metadata, you are ready to initiate your bioinformatics analysis.**
## -------------Bioinformatics Analysis-------------
* Install Miniconda
[Miniconda3 Linux 64-bit](https://github.com/NU-CPGME/aku_genomics_workshop_2022/blob/master/part_1/1D_software.md)

All the necessary installation instructions for Miniconda can be found in the links above.
After installation add the following channels
```
conda config --add channels conda-forge
conda config --add channels bioconda
conda config --add channels daler
conda config --add channels defaults
```
**Before executing the script we need to add executive rights because we have a large number of files with different extensions. So,**
```
chmod +x *.{py,sh,pl}
```
# 1. Create Environment 
```
conda env create -f WGS_environment.yaml
```
It creates a Conda environment named 'WGS_Analysis' and installs all the necessary packages.

# 2. Install packages Manually 
```
pip install -r python_pakages.txt
```
It installs those packages which is not previously installed 

# 3. Quality check 
**Evaluate the quality of your NGS data using FastQC**
```
./qc.sh
```
# 4. Read Trimming 
**Removes low-quality portions while retaining the longest high-quality part of an NGS read from raw sequencing data**
```
./trim_fastq.sh
```
# 5. 

