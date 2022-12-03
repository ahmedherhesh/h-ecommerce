import axios from "axios";

export default  axios.create({
    baseURL : 'http://192.168.1.3/h-ecommerce/laravel-e-commerce/public/api/v1/',
    headers : {
        'Authorization'    : 'Bearer ' + localStorage.getItem('token')
    },
});
