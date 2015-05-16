/**
 * Created by petewerner on 5/10/15.
 */


var bhcccApp = angular.module('bhccAPP', [], function() {

});

bhcccApp.controller('StravaData', function($scope, $http, $document) {

    $document.ready(function(){


        alert("loaded")



    })

    //-- Set the Default dates for Start and end date to the first and last day of the current month

    var date = new Date();
    var firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
    var lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);




    $scope.start_date = firstDay.toISOString().substring(0, 10);
    $scope.end_date = lastDay.toISOString().substring(0, 10);


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