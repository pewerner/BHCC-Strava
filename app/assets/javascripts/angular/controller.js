/**
 * Created by petewerner on 5/10/15.
 */


var bhcccApp = angular.module('bhccAPP', [], function() {

});

bhcccApp.controller('StravaData', function($scope, $http) {


    $scope.start_date = "2015-05-01";
    $scope.end_date = "2015-05-30"


    requestRiderData();

    $scope.updateDateTime= function(){

        requestRiderData()



    }

    function requestRiderData(){

        $http({method: 'GET', url: '/bhcc/testMethod.json', params: { start_date: $scope.start_date , end_date: $scope.end_date}}).success(function(data){

            $scope.mileage_data = data.sort(function(a,b){return a.Distance - b.Distance}).slice().reverse();

            $scope.elevation_data = data.sort(function(a,b){return a.Elevation - b.Elevation}).slice().reverse();

            $scope.hour_data = data.sort(function(a,b){return a.hours - b.hours}).slice().reverse();

        });

    }

    $scope.formatNumber = function(num){

        return Math.round(num);



    }




});