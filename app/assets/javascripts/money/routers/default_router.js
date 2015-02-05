M.DefaultRouter = Backbone.Router.extend({
  routes: {
    '': 'signin',
    'signin': 'signin',
    'signup': 'signup',
    'bills(/)': 'bills',
    'bills/:id': 'showBill',
    'categories(/)': 'categories',
    'payment_sources(/)': 'paymentSources',
    'payment_sources/:id': 'showPaymentSource',
    'payments(/)': 'payments',
    'payments/:id': 'showPayment',
    'tags(/)': 'tags',
    'users/:id': 'showUser'
  },

  signin: function() {
    var signinView = new M.SigninView();
    signinView.render();
  },

  signup: function() {
    var signupView = new M.SignupView({ el: '#signup-form' });
    signupView.render();
  },

  bills: function() {
    console.log('bills');
  },

  showBill: function(id) {
    console.log('showBill:', id);
  },

  categories: function() {
    console.log('categories:');
  },

  paymentSources: function() {
    console.log('paymentSources');
  },

  showPaymentSource: function(id) {
    console.log('showPaymentSource:', id);
  },

  payments: function() {
    console.log('payments');
  },

  showPayment: function(id) {
    console.log('showPayment:', id);
  },

  tags: function() {
    console.log('tags');
  },

  showUser: function(id) {
    console.log('showUser');
  }
});