({ //eslint-disable-line
  addvisit: function(component, event, helper) {
    component.set('v.AddVisit', true);
    var actionClicked = event.getSource().getLocalId();
    var navigate = component.get('v.navigateFlow');
    navigate(actionClicked);
  },
  newvisit: function(component, event, helper) {
    component.set('v.NewVisit', true);
    var actionClicked = event.getSource().getLocalId();
    var navigate = component.get('v.navigateFlow');
    navigate(actionClicked);
  },
});