#Intended to be a reproducible setup for building and running vmd in GitPod.
#Author: Jo Gao (jo@feather.systems) and Abhishek Cherath(abhi@feather.systems)
#Probably better to use Multi-stage builds, with one stage for plugins
FROM gitpod/workspace-full

# install emscripten
RUN git clone "https://github.com/emscripten-core/emsdk.git" $HOME/.emsdk \
    && cd $HOME/.emsdk \
    && ./emsdk install latest \
    && ./emsdk activate latest
    
# This adds a file to the .bashrc.d folder in GitPod,
# while holds all the files that .bashrc calls source on
RUN cd $HOME/.bashrc.d \
    && touch emsdk \
    && echo ". ~/.emsdk/emsdk_env.sh" >> emsdk

#Syncthing for poor abhishek to be able to work.
RUN sudo curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" \
    | sudo tee /etc/apt/sources.list.d/syncthing.list && \
    printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing && \
    sudo apt-get update && sudo apt-get install -y syncthing


# get latex needed for distrib step of building
# the plugins
RUN sudo apt-get install -y latex2html

# to be able to move files between repos
RUN sudo apt-get install -y magic-wormhole

# entr to rerun code
RUN sudo apt-get install -y entr
