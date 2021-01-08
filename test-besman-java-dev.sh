#!/bin/bash

function __test_bes_init
{
	if [[ ! -d $BESMAN_DIR ]]; then
        echo "bes not found"
        echo "Please install BeSman and try again"
        echo "Exiting!"
        exit 1
    else
    	source $BESMAN_DIR/bin/besman-init.sh
    	source $BESMAN_DIR/src/besman-utils.sh
        
    fi

    if [[ -z $(which java) ]]; then
        echo "java packages not found"
        exit 1
    fi
    
}

##function __test_bes_execute

function __test_bes_validate
{
    __besman_validate_java-dev
    local ret_value=$?
    if [[ $ret_value == "1" ]]; then
        test_status="failed"
        return 1
    fi
    unset ret_value
}

function __test_bes_run
{
    test_status="success"
    __test_bes_init
    # __test_bes_execute
    __test_bes_validate
    # __test_bes_cleanup
    if [[ $test_status == "success" ]]; then
        __besman_echo_green "test-bes-java-dev success"
    else
        __besman_echo_red "test-bes-java-dev failed"
    fi
}

__test_bes_run