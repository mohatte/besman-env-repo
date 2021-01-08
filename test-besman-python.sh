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

    python3 --version | grep -qi "python"
    if [[ "$?" != "0" ]]; then
        echo "No python package found. Test failed!"
        echo "Exiting!"
        exit 1
    fi
}

##function __test_bes_execute

function __test_bes_validate
{
    __besman_validate_python
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
        __besman_echo_green "test-bes-python-dev success"
    else
        __besman_echo_red "test-bes-python-dev failed"
    fi
}

__test_bes_run
