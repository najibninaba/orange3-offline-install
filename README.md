# Orange3 Offline Installation scripts

The motivation for these scripts was to address a common customer request for an offline installation of [Orange3](https://orange.biolab.si/), the Open Source machine learning and visualization tool along with their Orange3 Text Addon and the Orange3 Time Series Addon.

In order to do this, we still require a staging environment that is connected to the internet to download all the necessary packages and dependencies (via the prepare.bat script) and copy these supporting artifacts over to the target air-gapped environment(s) and running the deploy.bat script.

<aside class="warning">
WARNING!! The PowerShell scripts are called with the Execution Policy set to Bypass. Run them at your own risk only after you have understand what the code in the scripts do.
</aside>

# Instructions

This is a two-phased deployment. For the first phase, we require a machine that has Internet access. For the second phase, the target environment does not need Internet access at all. Currently these scripts are only tested on Windows 10 x64 environments.

## Pre-requisites:

We require [Anaconda3](https://www.anaconda.com/distribution/) to be installed on both the staging environment and the target environment.

# Instructions

## On the staging machine with Internet access, run the following:
    
    git clone git@github.com:najibninaba/orange3-offline-install.git
    cd orange3-offline-install
    prepare.bat

Once the above set of commands have completed, copy the whole contents of the ```orange3-offline-install``` directory to the target environment(s). 

Alternatively, you can copy to a central network location, however this method has not been tested yet.

## On the target environment, run the following commands. Internet access is no longer required at this point:

    cd orange3-offline-install
    deploy.bat

Once the above commands have completed, there should be an Orange3 shortcut on the Windows Desktop. To validate the installation, click on the Orange3 shortcut and run the provided workflow (```2017-12-14-mas-text-sentimentanalysis-example.ows```) found in the ```Workflows``` directory. You should be able to view the Word Cloud as well as the Data Table. At this point, Orange3, the Orange3 Text Addon and Orange3 Time Series Addon are ready to be used.

# Questions, bugs or other requests?

Please file an issue in the GitHub repo: https://github.com/najibninaba/orange3-offline-install. Thank you.
