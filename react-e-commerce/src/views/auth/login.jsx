import React, { Component} from 'react';
import http from '../../axios';
import validator from '../../validator';

class Login extends Component {

    state = {};
    errors = {};
    email = React.createRef();
    password = React.createRef();


    handelSubmit = e => {
        e.preventDefault();
        let data = {
            email: this.email.current.value,
            password: this.password.current.value,
        };
        http.post('login', data).then(r => console.log(r)).catch(r => {
            let res = r.response;
            if (res.status === 422) {
                validator(res.data,{
                    email: this.email.current,
                    password: this.password.current
                });
            }
        });
    }
    render() {
        return (
            <form onSubmit={this.handelSubmit} className="login-form">
                <h1 className='w-100 fs-5 text-center p-3 mb-3' style={{color:'var(--main-color)',borderRadius:20,borderBottom:'1px solid var(--main-color)'}}>Login</h1>
                <input ref={this.email} type="text" className='input-style' placeholder='Username' />
                <input ref={this.password} type="password" className='input-style' placeholder='Password' />
                <button className="w-50 btn-style">Login</button>
            </form>
        );
    }
}

export default Login;