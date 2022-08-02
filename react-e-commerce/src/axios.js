import axios from "axios";

let http = axios.create({
    baseURL : 'http://127.0.0.1:8000/api/v1',
    headers : {
        'X-Requested-With' : 'XMLHttpRequest',
    },
    withCredentials:true
});
export default http;
