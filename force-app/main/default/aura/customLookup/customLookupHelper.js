({ //eslint-disable-line
  searchHelper: function(component, event, getInputkeyWord) {

    // call the apex class method
    var action = component.get('c.fetchLookUpValues');
    console.log(component.get('v.useSOSLQueryvalidations'));

    // set param to method
    action.setParams({
      'searchKeyWord': getInputkeyWord,
      'objectName': component.get('v.objectAPIName'),
      'productFamily': component.get('v.productFamily'),
      'custom': component.get('v.custom'),
      'equals': component.get('v.equals'),
      'searchField': component.get('v.searchField'),
      'ipUserFilter': component.get('v.ipUserFilter'),
      'useSOSL': component.get('v.useSOSLQuery'),
      'useSOSLValidations': component.get('v.useSOSLQueryvalidations'),
      'useSOSLApiValidations': component.get('v.useSOSLQueryWherevalidations')
    });

    // set a callBack
    action.setCallback(this, function(response) {
      $A.util.removeClass(component.find('mySpinner'), 'slds-show');
      var state = response.getState();
      if (state === 'SUCCESS') {
        var storeResponse = response.getReturnValue();

        // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
        if (storeResponse.length === 0) {
          component.set('v.Message', 'No Result Found...');
        } else {
          component.set('v.Message', '');
        }

        // set searchResult list with return value from server.
        component.set('v.listOfSearchRecords', storeResponse);
      }

    });

    // enqueue the Action
    $A.enqueueAction(action);

  },
});