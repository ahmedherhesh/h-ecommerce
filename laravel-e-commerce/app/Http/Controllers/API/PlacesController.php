<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\City;
use App\Models\Country;
use App\Models\Region;
use Illuminate\Http\Request;

class PlacesController extends MasterAPIController
{
    function countries(){
        $countries = Country::all()->pluck('name');
        return $this->response($countries,$countries);
    }
    function regions($country_name){
        $country_id = Country::whereName(str_replace('-',' ',$country_name))->first()->id;
        $regions = Region::whereCountryId($country_id)->get()->pluck('name');
        return $this->response($regions,$regions);
    }
    function cities($region_name){
        $region_id = Region::whereName(str_replace('-',' ',$region_name))->first()->id;
        $cities = City::whereRegionId($region_id)->get()->pluck('name');
        return $this->response($cities,$cities);
    }
}
