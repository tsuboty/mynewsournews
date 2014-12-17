var app = angular.module('news',[]);

app.controller('searchCtrl',function(){

	
	this.badgeState = function(rt){
		
		if(rt == 100){
			return "alert-danger";
		}else if(rt>=60 && rt<100){
			return "alertalert-info";
		}else if(rt>=20 && rt<60){
			return "alert-success";
		}else if(rt>=1 && rt< 20){
				return "alert-warning";
		}else{
			return "";
		}
	}
});

app.controller("mapController",function($scope){
	address = $scope.address;
	

	var map;

    initMap = function() {
      var latlng = new google.maps.LatLng(35.709984,139.810703);
      var opts = {
        zoom: 15,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      map = new google.maps.Map(document.getElementById("map_canvas"), opts);
    };
    
    set = function(){
    	var oosaka = new google.maps.LatLng(34.686272,135.519649);
    	map.setCenter(oosaka);
    };

    get = function(){
    	getGeo = map.getCenter();
    	alert(getGeo);
    };

    geocoder = new google.maps.Geocoder();
	getAddressName = function(){
		geocoder.getLatLng("東京都千代田区", moveTo);
	};

	moveTo = function(latlng){
	  if (latlng){
	    map.setCenter(latlng, 15);
	  }else{
	    alert("住所から緯度経度に変換できません");
	  }
	};


});
