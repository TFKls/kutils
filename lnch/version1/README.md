## Lnch v1
*Updated and easier to use Lnchv0*

#### Installation
By default the installation script lnch-init.sh can be used for installing the lnch utility.
It installs the lnchfiles in the directory/lnchfiles.
It can be easily changed in the lnch.cfg file.  

It also adds the lnch aliases to ~/.bash_aliases.

I will probably add more installation options later.
NOTE : it has to be in the same directory as the rest of lnch utils as well as `helpLnch` file.
#### Usage
The `lnch-create` program is used for creating and deleting Launchfiles. It also deletes dependencies etc.
It accepts the following arguments :  
- `lnch-create -n name` - creates a script file and leaves it alone  
- `lnch-create -r name` - deletes a script file  
- `lnch-create` - creates a script and let's the user decide what to do with it  
I suggest using `lnch-create` all the time, since it also automatically backups deletions, and will be used for adding dynamic bash completion.

Launchfiles are in reality bash scripts sourced by the lnch script.  

`lnch name` executes (sources) the launchfile located at 
```bash
$installDir/$name/Launchfile
```
Simple as that.
#### TODO
- Dynamic completion
- More advanced install script