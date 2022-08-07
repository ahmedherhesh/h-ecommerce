import React, { Component } from 'react';
import http from '../../axios';
import validator from '../../validator';
class Register extends Component {
    state = {}
    vars = ['name', 'username', 'email', 'phone', 'password', 'repeatPassword'];
    name            = React.createRef();
    username        = React.createRef();
    email           = React.createRef();
    phone           = React.createRef();
    password        = React.createRef();
    repeatPassword  = React.createRef();

    handelSubmit = e => {
        e.preventDefault();
        let data = {};
        let validator_fields = {};
        this.vars.map(v => {
            data[v] = this[v].current.value;
            validator_fields[v] = this[v].current
        });
        http.post('register', data).then(r => r.status === 200 ? window.location.href = '/' : 0).catch(r => {
            let res = r.response;
            if (res.status === 422 ){
                validator(res.data,validator_fields);
            }
        });
    }

    render() {
        // let {id} = useParams();
        return (
            <form onSubmit={this.handelSubmit} className="register-form">
                <h1 className='w-100 fs-3' style={{color:'rgb(105, 101, 101)'}}>Create Account :</h1>
                <input ref={this.name} id='name' type="text" className='input-style' placeholder='Full Name' />
                <input ref={this.username} id='username' type="text" className='input-style' placeholder='Username' />
                <input ref={this.email} type="email" className='input-style' placeholder='Email' />
                <input ref={this.phone} type="tel" className='input-style' placeholder='Phone Number' />
                <input ref={this.password} type="password" className='input-style' placeholder='Password' />
                <input ref={this.repeatPassword} type="password" className='input-style' placeholder='Repeat Password' />
                <button className="btn btn-secondary w-50 p-3">Register</button>
            </form>
        );
    }
}

export default Register;