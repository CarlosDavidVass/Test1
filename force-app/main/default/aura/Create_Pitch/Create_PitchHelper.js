({ //eslint-disable-line
  newPitch: function(component, evt) {
    var nameField = component.find('nameField').get('v.value');
    var clientField = component.find('clientFields').get('v.value');
    var productFamilyField = component.find('productFamilyField').get('v.value');
    var productField = component.find('productField').get('v.value');
    var CountryVisivility = component.get('v.CountryIsVisible');
    var countryField;
    if (CountryVisivility === true) {
      countryField = component.find('countryField').get('v.value');
    } else {
      countryField = 'Spain';
    }
    var descriptionField = component.find('descriptionField').get('v.value');
    var message = '';
    component.set('v.Name', nameField);
    component.set('v.ClientName', clientField);
    component.set('v.ProductFamily', productFamilyField);
    component.set('v.Product', productField);
    component.set('v.Country', countryField);
    component.set('v.Description', descriptionField);
    message = this.logicRequired(component, message, nameField, clientField, productFamilyField, productField, countryField);
    if (message !== null && message !== undefined && message !== '') {
      message = message.slice(0, -1);
      this.setErrorValues(component, message);
    }
  },
  logicRequired: function(component, message, nameField, clientField, productFamilyField, productField, countryField) {
    message = this.checkRequiredFields(component, message, nameField, clientField, productFamilyField, productField, countryField);
    return message;
  },
  setErrorValues: function(component, mesage) {
    if (mesage === '' || mesage === undefined) {
      component.set('v.showError', false);
    } else {
      var messageAux = 'These required fields must be completed: ' + mesage;
      component.set('v.errorMessage', messageAux);
      component.set('v.showError', true);
    }
  },
  logicNotNullStyles: function(component, idDiv, classDiv, idError, classToAdd, classToRemove) {
    $A.util.removeClass(component.find(idDiv), classDiv);
    $A.util.removeClass(component.find(idError), classToRemove);
    $A.util.addClass(component.find(idError), classToAdd);
  },
  logicNullStyles: function(component, idDiv, classDiv, idError, classToAdd, classToRemove) {
    $A.util.addClass(component.find(idDiv), classDiv);
    $A.util.addClass(component.find(idError), classToAdd);
    $A.util.removeClass(component.find(idError), classToRemove);
  },
  checkRequiredFields: function(component, message, nameField, clientField, productFamilyField, productField, countryField) {
    var CountryVisivility = component.get('v.CountryIsVisible');
    if (nameField === undefined || nameField === null || nameField === '') {
      message += 'Name, ';
      this.logicNullStyles(component, 'divnames', 'slds-has-error', 'error-name', 'slds-visible', 'slds-hidden');
    } else {
      this.logicNotNullStyles(component, 'divnames', 'slds-has-error', 'error-name', 'slds-hidden', 'slds-visible');
    }
    if (clientField === undefined || clientField === null || clientField === '') {
      message += 'Client, ';
      this.logicNullStyles(component, 'divclient', 'slds-has-error', 'error-client', 'slds-visible', 'slds-hidden');
    } else {
      this.logicNotNullStyles(component, 'divclient', 'slds-has-error', 'error-client', 'slds-hidden', 'slds-visible');
    }
    if (productFamilyField === undefined || productFamilyField === null || productFamilyField === '') {
      message += 'SProduct Family, ';
      this.logicNullStyles(component, 'divproductF', 'slds-has-error', 'error-productF', '.slds-has-error .slds-form-element__help', 'slds-hidden');
    } else {
      this.logicNotNullStyles(component, 'divproductF', 'slds-has-error', 'error-productF', 'slds-hidden', 'slds-visible');
    }

    this.checkRequiredFields2(component, message, nameField, clientField, productFamilyField, productField, countryField, CountryVisivility); //eslint-disable-line
  },

  checkRequiredFields2: function(component, message, nameField, clientField, productFamilyField, productField, countryField, CountryVisivility) {
    if (productField === undefined || productField === null || productField === '') {
      message += 'Product, ';
      this.logicNullStyles(component, 'divproduct', 'slds-has-error', 'error-product', 'slds-visible', 'slds-hidden');
    } else {
      this.logicNotNullStyles(component, 'divproduct', 'slds-has-error', 'error-product', 'slds-hidden', 'slds-visible');
    }
    if (CountryVisivility === true) {
      if (countryField === undefined || countryField === null || countryField === '') {
        message += 'Country, ';
        this.logicNullStyles(component, 'divcountry', 'slds-has-error', 'error-country', 'slds-visible', 'slds-hidden');
      } else {
        this.logicNotNullStyles(component, 'divcountry', 'slds-has-error', 'error-country', 'slds-hidden', 'slds-visible');
      }
    }
    return message;
  }


});