import axios from "axios";

let http = axios.create({
    baseURL : 'http://192.168.1.3/h-ecommerce/laravel-e-commerce/public/api/v1',
    headers : {
        // 'X-Requested-With' : 'XMLHttpRequest',
        'Authorization'    : 'Bearer ' + localStorage.getItem('token')
    },
    // withCredentials:true
});
export default http;
