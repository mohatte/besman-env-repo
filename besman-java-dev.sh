#!/bin/bash

function __besman_install_java-dev
{
    if [[ -z $JAVA_ENV_ROOT ]]; then
        export JAVA_ENV_ROOT=$HOME/java-dev
    fi
    local choice
    if [[ -z $(which javac) ]]; then
        __besman_echo_white "Installing java in your local system..."
        sudo apt update
        sudo apt install default-jdk -y
        sudo apt install default-jre -y
        mkdir -p $JAVA_ENV_ROOT
        read -p "Do you wish to install Eclipse IDE for your java dev(y/n):" choice
        if [[ $choice == "y" ]]; then
            install_eclipse
        fi
        create_sample_program >> $JAVA_ENV_ROOT/HelloWorld.java
        mkdir -p $JAVA_ENV_ROOT/test
        wget -q https://raw.githubusercontent.com/$BESMAN_NAMESPACE/besman-env-repo/master/test-besman-java-dev.sh
        mv $HOME/test-besman-java-dev.sh $JAVA_ENV_ROOT/test
        # __besman_echo_yellow "Test script and sample code available at $JAVA_ENV_ROOT"
        __besman_echo_green "Dev environment for java has been installed successfully at $JAVA_ENV_ROOT"

    else
        __besman_echo_white "Java is already present in your system"
    fi

    unset choice

}

function create_sample_program()
{
    cat <<EOF
    /* This is a simple Java program. 
   FileName : "HelloWorld.java". */
    class HelloWorld 
    { 
        // Your program begins with a call to main(). 
        // Prints "Hello, World" to the terminal window. 
        public static void main(String args[]) 
        { 
            System.out.println("Hello, World"); 
        } 
    } 
EOF
}
function install_eclipse
{
    __besman_echo_no_colour "Installing Eclipse IDE"
    if [[ -z $(which snap) ]]; then
        sudo apt install snapd
    fi
    sudo snap install --classic eclipse
    __besman_echo_green "Eclipse IDE has been installed successfully."
    __besman_echo_white "Run the following command to launch Eclipse IDE"
    __besman_echo_no_colour ""
    __besman_echo_yellow "$ eclipse"
    __besman_echo_no_colour ""

}

function __besman_uninstall_java-dev
{
    
    if [[ -n $(which eclipse) ]]; then
        uninstall_eclipse
    fi
    __besman_echo_white "Uninstalling Java "
    sudo update-alternatives --display java
    sudo apt-get remove --auto-remove openjdk* -y
    # sudo update-alternatives --config java
    [[ -d $JAVA_ENV_ROOT ]] && rm -rf $JAVA_ENV_ROOT
    __besman_echo_white "Uninstalled Java"
}

function uninstall_eclipse
{
    __besman_echo_white " Uninstalling Eclipse IDE"
    sudo snap remove eclipse
}

function __besman_validate_java-dev
{
    if [[ ! -d $JAVA_ENV_ROOT ]]; then
        __besman_echo_red "Could not find folder $JAVA_ENV_ROOT"
        return 1
    fi

    if [[ ! -f $JAVA_ENV_ROOT/HelloWorld.java ]]; then
        __besman_echo_red "Could not find sample program"
        return 1
    fi


}


#function __besman_update_java(){}
#function __besman_update_eclipse(){}

#function __besman_upgrade_java(){}
#function __besman_upgrade_eclipse(){}

#function __besman_validate_java(){}
#function __besman_validate_eclipse(){}

#function __besman_start_java(){}
#function __besman_start_eclipse(){}

##function __besman_stop_java(){}
##function __besman_stop_eclipse(){}
