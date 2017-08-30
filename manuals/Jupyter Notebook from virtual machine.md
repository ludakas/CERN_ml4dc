
# Running Jupyter Notebook from virtual machine# 

## Main resources
[1] http://jupyter-notebook.readthedocs.io/en/latest/public_server.html

[2] https://coderwall.com/p/y1rwfw/jupyter-notebook-on-remote-serverds


$ jupyter notebook --generate-config

from resource 1 follow the steps of:
-   Using SSL for encrypted communication - create keys and add them to jupyter
        $ openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mykey.key -out mycert.pem
        $ jupyter notebook --certfile=mycert.pem --keyfile mykey.key
        
-  Running a public notebook server - edit config file "jupyter_notebook_config.py"
        # remember to uncomment changed lines (remove #), 
        # Set options for certfile, ip, password, and toggle off
        # browser auto-opening
        c.NotebookApp.certfile = u'/absolute/path/to/your/certificate/mycert.pem'
        c.NotebookApp.keyfile = u'/absolute/path/to/your/certificate/mykey.key'
        # Set ip to '*' to bind on all interfaces (ips) for the public server
        c.NotebookApp.ip = '*'
        c.NotebookApp.password = u'sha1:bcd259ccf...<your hashed password here>'
                to generate password in python interpreter:
                In [1]: from notebook.auth import passwd
                In [2]: passwd()
                Enter password:
                Verify password:
                Out[2]: 'sha1:67c9e60bb8b6:9ffede0825894254b2e042ea597d771089e11aed'
        c.NotebookApp.open_browser = False
        # It is a good idea to set a known, fixed port for server access
        c.NotebookApp.port = 9999


from resource 2:
    On the local machine
    Create an ssh tunnel to the corresponding server and binding remote port XXXX to local YYYY:
    $ ssh -f [USER]@[SERVER] -L [YYYY]:localhost:[XXXX] -N
    You can now enter localhost:[YYYY] in your favorite browser to use the remote notebook!


Notes
you must access the notebook server over https://, not over plain http://