({ //eslint-disable-line
  saveForm: function(component, event, helper) {
    helper.newPitch(component, event);
    var showErrors = component.get('v.showError');
    if (showErrors === false) {
      var actionClicked = event.getSource().getLocalId();
      var navigate = component.get('v.navigateFlow');
      navigate(actionClicked);
    }
  },

  cancelar: function(component, event, helper) {
    $A.get('e.force:closeQuickAction').fire();
  },

});
