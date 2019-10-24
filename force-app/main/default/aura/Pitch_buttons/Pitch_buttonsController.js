({ //eslint-disable-line
  runNewPitchVisitFlow: function(component, event, helper) {
    component.set('v.isOpen', true);
    var flow = component.find('Add_Visit_to_Pitch');
    var inputVariables = [ {
      name: 'recordId',
      type: 'String',
      value: component.get('v.recordId')
    } ];
    flow.startFlow('Add_Visit_to_Pitch', inputVariables);
  },
  closeFlowModal: function(component, event, helper) {
    component.set('v.isOpen', false);
  },
  runNewPitchOppFlow: function(component, event, helper) {
    component.set('v.isOpen', true);
    var flow = component.find('Create_Opportunity_From_Pitch');
    var inputVariables = [ {
      name: 'recordId',
      type: 'String',
      value: component.get('v.recordId')
    } ];
    flow.startFlow('Create_Opportunity_From_Pitch', inputVariables);
  },
  addPitchOppFlow: function(component, event, helper) {
    component.set('v.isOpen', true);
    var flow = component.find('Add_Opportunity');
    var inputVariables = [ {
      name: 'recordId',
      type: 'String',
      value: component.get('v.recordId')
    } ];
    flow.startFlow('Add_Opportunity', inputVariables);
  },
  closeModalOnFinish: function(component, event, helper) {
    console.log('Status -> ', event.getParam('status'));
    if (event.getParam('status') === 'FINISHED') {
      component.set('v.isOpen', false);
    }
  }
});