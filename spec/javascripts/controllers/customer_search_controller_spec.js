describe("CustomerSearchController", function() {
  describe("Initialization", function() {
    var scope = null,
        controller = null;
    beforeEach(module("customers"));
    beforeEach(inject(function ($controller, $rootScope) {
      scope = $rootScope.$new();
      controller = $controller("CustomerSearchController", {
        $scope: scope
      });
    }));

  });
});
