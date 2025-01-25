var $flowchart = $('#flowchartworkspace');
var defaultFlowchartData = {
    operators: {
        operator1: {
            top: 5,
            left: 330,
            properties: {
                title: '/START - Operator 1',
                body:'Inicio da Automação',
                inputs: {},
                outputs: {
                    output_1: {
                        label: '',
                    }
                }
            }
        },
        operator2: {
            top: 100,
            left: 330,
            width: 250,
            properties: {
                title: 'Boas Vindas - Operator 2',
                body:'Bem vindo(a)! Projeto nome ...',
                operatorTypes:'welcome',
                inputs: {
                    input_1: {
                        label: '',
                    }
                },
                outputs: {
                    output_1: {
                        label: '',
                    }
                }
            }
        },
        operator3: {
            top: 205,
            left: 330,
            properties: {
                title: 'Termo - Operator 3',
                body:'Termo de Uso...',
                inputs: {
                    input_1: {
                        label: '',
                    }
                },
                outputs: {
                    output_1: {
                        label: '',
                    }
                }
            }
        },
        operator4: {
            top: 310,
            left: 330,
            properties: {
                title: 'Cadastro - Operator 4',
                inputs: {
                    input_1: {
                        label: '',
                    }
                },
                outputs: {
                    output_1: {
                        label: 'SIM',
                    },
                    output_2: {
                        label: 'NÃO',
                    }
                }
            }
        },
        operator5: {
            top: 480,
            left: 330,
            width: 250,
            properties: {
                body:'<i class="fas fa-plus" id="plus-operator-3"></i></a>',
                operatorTypes:'welcome',
                inputs: {
                    input_1: {
                        label: '',
                    }
                },
                outputs: {
                    output_1: {
                        label: '',
                    }
                }
            }
        },
        operator6: {
            top: 580,
            left: 330,
            properties: {
                title: 'Assinatura Recorrente - Operator 6',
                inputs: {
                    input_1: {
                        label: '',
                    }
                },
                outputs: {
                    output_1: {
                        label: 'SIM',
                    },
                    output_2: {
                        label: 'NÃO',
                    }
                }
            }
        },
    },
    links: {
        link_1: {
            fromOperator: 'operator1',
            fromConnector: 'output_1',
            toOperator: 'operator2',
            toConnector: 'input_1',
        },
        link_2: {
            fromOperator: 'operator2',
            fromConnector: 'output_1',
            toOperator: 'operator3',
            toConnector: 'input_1',
        },
        link_3: {
            fromOperator: 'operator3',
            fromConnector: 'output_1',
            toOperator: 'operator4',
            toConnector: 'input_1',
        },
        link_4: {
            fromOperator: 'operator4',
            fromConnector: 'output_1',
            toOperator: 'operator5',
            toConnector: 'input_1',
        },
        link_5: {
            fromOperator: 'operator5',
            fromConnector: 'output_1',
            toOperator: 'operator6',
            toConnector: 'input_1',
        },
    }
};

$(document).ready(function() {
    var $container = $flowchart.parent();
    el = $flowchart.children[1];
    addEditOptionToNode(el.children[1], "welcome");
    addEditOptionToNode(el.children[2], "term");
    // Apply the plugin on a standard, empty div...
    $flowchart.flowchart({
        verticalConnection: true,
        data: defaultFlowchartData,
        defaultSelectedLinkColor: '#000055',
        grid: 10,
        multipleLinksOnInput: true,
        multipleLinksOnOutput: true
    });

    function getOperatorData($element) {
        var nbInputs = parseInt($element.data('nb-inputs'), 10);
        var nbOutputs = parseInt($element.data('nb-outputs'), 10);
        var data = {
            properties: {
                title: $element.text(),
                inputs: {},
                outputs: {}
            }
        };

        var i = 0;
        for (i = 0; i < nbInputs; i++) {
            data.properties.inputs['input_' + i] = {
                label: 'Entrada'
            };
        }
        for (i = 0; i < nbOutputs; i++) {
            data.properties.outputs['output_' + i] = {
                label: 'Saída'
            };
        }

        return data;
    }

    var $operatorProperties = $('#operator_properties');
    $operatorProperties.hide();
    var $linkProperties = $('#link_properties');
    $linkProperties.hide();
    var $operatorTitle = $('#operator_title');
    var $linkColor = $('#link_color');

    $flowchart.flowchart({
        onOperatorSelect: function(operatorId) {
            $operatorProperties.show();
            $operatorTitle.val($flowchart.flowchart('getOperatorTitle', operatorId));
            if (operatorId == 'operator5') {
                $('#optModal').modal('show');

            }
            return true;
        }
    });

         


    $('#addNodeSignupEmail').click(function(){
        el = el.children[1];
        var operatorId = el.children.length +1;
        addNode('sendEmail', 'operator5', operatorId);
    });

    $('#addNodeSignupTelegram').click(function(){
        el = el.children[1];
        var operatorI = el.children.length +1;
        addNode('sendEmail', 'operator5', operatorId);
    });

    $('#addNodeSignupWait').click(function(){
        el = el.children[1];
        var operatorI = el.children.length +1;
        addNode('sendEmail', 'operator5', operatorId);
        
    });

    // custom css of the plus button
    function customPlusOperator(){

        var plus3 = document.getElementById('plus-operator-3');
        var grandpa = plus3.parentNode.parentNode;
        grandpa.setAttribute("id", "wrapper-plus-operator-3");
        grandpa.classList.add("mouse_hover");
        grandpa.style.width = '50px';
        grandpa.style.marginLeft = '100px';
        grandpa.style.borderRadius = '50px';
        let plusChildTitle = grandpa.children[1];
        plusChildTitle.style.display = 'none';
        let plusChildDesc = grandpa.children[2];
        plusChildDesc.classList.add("mouse_hover");
        plusChildDesc.style.textAlign = 'center';

    };
    // add edit options to Customizable Nodes
    function addEditOptionToNode(preAttribute, attributeIdName,){
        preAttribute.setAttribute("id", attributeIdName);
        _attribute = preAttribute.children[2];
        var wrapper = document.createElement("span");
        wrapper.classList.add('svg-icon'); 
        wrapper.classList.add('svg-icon-md');
        wrapper.innerHTML =`<a href="" class="navi-link" data-toggle="modal" data-target="#automationWelcomeModal"><i class="fas fa-edit"></i></a>`;
        _attribute.appendChild(wrapper);
    }


    function addNode(type, operatorName, totalOperators){        
        var operatorId = 'operator'+totalOperators;
        var operatorData = formatOperatorData(type, operatorName, totalOperators);
        $flowchart.flowchart('createOperator', operatorId, operatorData);

        let toLinks = $flowchart.flowchart('getLinksTo', operatorName);
        createLinks(operatorId, 'output_1', operatorName, 'input_1');
        createLinks(toLinks[0]['fromOperator'], 'output_1', operatorId, 'input_1');
        deleteLinks(toLinks[0]);
        moveToDownOperators(operatorName);
        customPlusOperator();
    };

    function createLinks(fromOperator, fromConnector, toOperator, toConnector){
        var linkData = {
            fromOperator: fromOperator,
            fromConnector: fromConnector,
            toOperator: toOperator,
            toConnector: toConnector,
        }
        $flowchart.flowchart('addLink', linkData);
    }

    function deleteLinks(deleteLink){
        let dataAll = $flowchart.flowchart('getData');
        let links = new Map(Object.entries(dataAll.links));
        for (var [key, value] of links) {
            if(deleteLink['fromOperator'] == value['fromOperator'] && deleteLink['toOperator'] == value['toOperator']){
                $flowchart.flowchart('deleteLink', key);
            }
            
        }
    }

    function formatOperatorData(type, operatorName, totalOperators){
        const [title, body] = formatOperatorTitleBody(type);
        let operatorAdd = $flowchart.flowchart('getOperatorData', operatorName);
        var operatorData = {
            top: operatorAdd.top,
            left: operatorAdd.left,
            properties: {
                title: title + ' - Operator ' + totalOperators,
                body: body,
                inputs: {
                    input_1: {
                        label: '',
                    }
                },
                outputs: {
                    output_1: {
                        label: '',
                    }
                }
            }
        };
        return operatorData;
    }

    function formatOperatorTitleBody(type){
        var title, body = '';
        if (type == "sendEmail") {
            title = "Email";
            body = '<a href="" class="navi-link" data-toggle="modal" data-target="#automationEmailSignupModal"><i class="fas fa-edit"></i></a>'
        } else if(type == "telegramSignup") {
            title = "sendTelegram";
            body = '<a href="" class="navi-link" data-toggle="modal" data-target="#automationTelegramSignupModal"><i class="fas fa-edit"></i></a>'
        } else if(type == "waitSignup") {
            title = "Aguardar";
            body = '<a href="" class="navi-link" data-toggle="modal" data-target="#automationWaitSignupModal"><i class="fas fa-edit"></i></a>'
        }
        return [title, body]; 
    }
    // recursivelly move operator to down
    function moveToDownOperators(operatorName){
        let fromLinks = $flowchart.flowchart('getLinksFrom', operatorName);
        let operatorAdd = $flowchart.flowchart('getOperatorData', operatorName);
        operatorAdd.top = operatorAdd.top + 100;
        $flowchart.flowchart('setOperatorData', operatorName, operatorAdd);
        if(fromLinks.length < 1){
            return;
        }
        moveToDownOperators(fromLinks[0]['toOperator']);
    }
});