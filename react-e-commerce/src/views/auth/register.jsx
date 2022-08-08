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
        return (
            <form onSubmit={this.handelSubmit} className="register-form">
                <h1 className='w-100 fs-5 text-center p-3 mb-3' style={{color:'var(--main-color)',borderRadius:20,borderBottom:'1px solid var(--main-color)'}}>Create account</h1>
                <div class='form-group'><input ref={this.name} id='name' type="text" className='input-style' placeholder='Full Name' /></div>
                <div class='form-group'><input ref={this.username} id='username' type="text" className='input-style' placeholder='Username' /></div>
                <div class='form-group'><input ref={this.email} type="email" className='input-style' placeholder='Email' /></div>
                <div class='form-group'><input ref={this.phone} type="tel" className='input-style' placeholder='Phone Number' /></div>
                <div class='form-group'><input ref={this.password} type="password" className='input-style' placeholder='Password' /></div>
                <div class='form-group'><input ref={this.repeatPassword} type="password" className='input-style' placeholder='Repeat Password' /></div>
                <button className="btn-style w-25">Register</button>
            </form>
        );
    }
}

export default Register;