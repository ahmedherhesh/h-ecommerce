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
                <input ref={this.email} type="text" className='form-control' placeholder='Username' />
                <input ref={this.password} type="password" className='form-control' placeholder='Password' />
                <button className="btn btn-secondary">Login</button>
            </form>
        );
    }
}

export default Login;