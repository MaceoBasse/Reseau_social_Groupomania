<template>
  <div class="login-wrap bg-gray-100">
    <div class="login-html">
      <input id="tab-1" type="radio" name="tab" class="sign-in" checked /><label
        for="tab-1"
        class="tab"
        >Connexion</label
      >
      <input id="tab-2" type="radio" name="tab" class="sign-up" /><label
        for="tab-2"
        class="tab"
        >S'inscrire</label
      >
      <div class="login-form">
        <form @submit.prevent="submit">
          <div class="sign-in-htm">
            <div class="group">
              <label for="user" class="label">Email</label>
              <input
                id="user-sign-in"
                type="text"
                class="input"
                v-model="email"
              />
              <p v-if="email_error" class="text-red-500">{{ email_error }}</p>
            </div>
            <div class="group">
              <label for="pass" class="label">Password</label>
              <input
                id="pass"
                type="password"
                class="input"
                data-type="password"
                v-model="pass"
              />
              <p v-if="pass_error" class="text-red-500">{{ pass_error }}</p>
            </div>
            <div class="group">
              <input type="submit" class="button" value="Connexion" />
            </div>
          </div>
        </form>
        <form @submit.prevent="sign_up">
          <div class="sign-up-htm">
            <div class="group">
              <label for="user" class="label">Username</label>
              <input
                id="user-sign-up"
                type="text"
                class="input"
                v-model="user"
              />
              <p v-if="user_error" class="text-red-500">{{ user_error }}</p>
            </div>
            <div class="group">
              <label for="pass" class="label">Password</label>
              <input
                id="pass-signup"
                type="password"
                class="input"
                data-type="password"
                v-model="password"
              />
              <p v-if="password_error" class="text-red-500">
                {{ password_error }}
              </p>
            </div>
            <div class="group">
              <label for="pass" class="label">Repeat Password</label>
              <input
                id="pass-repeat"
                type="password"
                class="input"
                data-type="password"
                v-model="password_repeat"
              />
              <p v-if="password_repeat_error" class="text-red-500">
                {{ password_repeat_error }}
              </p>
            </div>
            <div class="group">
              <label for="pass" class="label">Email</label>
              <input
                id="email"
                type="text"
                class="input"
                v-model="email_signup"
              />
              <p v-if="email_signup_error" class="text-red-500">
                {{ email_signup_error }}
              </p>
            </div>
            <div class="group">
              <input type="submit" class="button" value="Inscription" />
            </div>
            <div class="hr"></div>
            <div class="foot-lnk">
              <label for="tab-1">Déjà membre ?</label>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import validator from "validator";
export default {
  // name: "App",
  data() {
    return {
      //login
      email: "",
      pass: "",
      //login error
      email_error: "",
      pass_error: "",

      //sign up
      user: "",
      password: "",
      password_repeat: "",
      email_signup: "",
      //signup error
      user_error: "",
      password_error: "",
      password_repeat_error: "",
      email_signup_error: "",
    };
  },
  methods: {
    signInValidate() {
      this.email_error = "";
      this.pass_error = "";
      const { email, pass } = this;
      if (!validator.isEmail(email)) {
        console.log("Email n'est pas valide");
        this.email_error = "L'email n'est pas valide";
        this.email = "";
        return false;
      }
      if (!validator.isStrongPassword(pass)) {
        console.log("Le password n'est pas valide");
        this.pass_error = "Le password n'est pas valide";
        this.pass = "";
        return false;
      }
      return true;
    },
    signUpValidate() {
      this.user_error = "";
      this.password_error = "";
      this.password_repeat_error = "";
      this.email_signup_error = "";
      const { user, password, password_repeat, email_signup } = this;
      if (validator.isEmpty(user)) {
        this.user_error = "Il faut ecrire un nom utilisateur";
        this.user = "";
        return false;
      }
      if (!validator.isStrongPassword(password)) {
        this.password_error = "Password n'est pas valide";
        this.password = "";
        return false;
      }
      if (password !== password_repeat) {
        this.password_repeat_error = "Le second password n'est pas valide";
        this.password_repeat = "";
        return false;
      }
      if (!validator.isEmail(email_signup)) {
        this.email_signup_error = "L'email n'est pas valide";
        this.email_signup = "";
        return false;
      }

      return true;
    },

    submit() {
      if (!this.signInValidate()) {
        return;
      }
      console.log(this.email);
      console.log(this.pass);
      const option = {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: this.email, password: this.pass }),
        credentials: "include",
      };
      fetch("http://localhost:3000/api/user/login", option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          console.log(data);
          this.$router.push("home");

          if (data.error) {
            this.pass_error = data.error;
          }
        });
    },
    sign_up() {
      if (!this.signUpValidate()) {
        return;
      }
      console.log("signup");
      const option = {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: this.user,
          email: this.email_signup,
          password: this.password,
        }),
        credentials: "include",
      };
      fetch("http://localhost:3000/api/user/new", option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          console.log(data);
          const options = {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              email: this.email_signup,
              password: this.password,
            }),
            credentials: "include",
          };
          fetch("http://localhost:3000/api/user/login", options)
            .then((response) => response.json())
            .catch((error) => {
              console.error("There was an error!", error);
            })
            .then((data) => {
              console.log(data);
              this.$router.push("home");

              if (data.error) {
                console.log(data.error);
              }
            });

          if (data.error) {
            this.email_signup_error = data.error;
          }
        });
    },
    guardMyroute() {
      const option = {
        method: "GET",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
      };
      fetch("http://localhost:3000/api/user/isauth", option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          this.$router.push("home");
          if (data.error) {
            console.log(data.error);
            this.$router.push("/");
          }
        });
    },
  },
  beforeMount() {
    this.guardMyroute();
  },
};
</script>

<style scoped>
body {
  margin: 0;
  color: #6a6f8c;
  background: #c8c8c8;
  font: 600 16px/18px "Open Sans", sans-serif;
}
*,
:after,
:before {
  box-sizing: border-box;
}
.clearfix:after,
.clearfix:before {
  content: "";
  display: table;
}
.clearfix:after {
  clear: both;
  display: block;
}
a {
  color: inherit;
  text-decoration: none;
}

.login-wrap {
  width: 100%;
  margin: auto;
  max-width: 525px;
  min-height: 670px;
  position: relative;
  background: url(https://raw.githubusercontent.com/khadkamhn/day-01-login-form/master/img/bg.jpg)
    no-repeat center;
  box-shadow: 0 12px 15px 0 rgba(0, 0, 0, 0.24),
    0 17px 50px 0 rgba(0, 0, 0, 0.19);
}
.login-html {
  width: 100%;
  height: 100%;
  position: absolute;
  padding: 90px 70px 50px 70px;
  background: rgba(40, 57, 101, 0.9);
}
.login-html .sign-in-htm,
.login-html .sign-up-htm {
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  position: absolute;
  transform: rotateY(180deg);
  backface-visibility: hidden;
  transition: all 0.4s linear;
}
.login-html .sign-in,
.login-html .sign-up,
.login-form .group .check {
  display: none;
}
.login-html .tab,
.login-form .group .label,
.login-form .group .button {
  text-transform: uppercase;
}
.login-html .tab {
  font-size: 22px;
  margin-right: 15px;
  padding-bottom: 5px;
  margin: 0 15px 10px 0;
  display: inline-block;
  border-bottom: 2px solid transparent;
}
.login-html .sign-in:checked + .tab,
.login-html .sign-up:checked + .tab {
  color: #fff;
  border-color: #1161ee;
}
.login-form {
  min-height: 345px;
  position: relative;
  perspective: 1000px;
  transform-style: preserve-3d;
}
.login-form .group {
  margin-bottom: 15px;
}
.login-form .group .label,
.login-form .group .input,
.login-form .group .button {
  width: 100%;
  color: #fff;
  display: block;
}
.login-form .group .input,
.login-form .group .button {
  border: none;
  padding: 15px 20px;
  border-radius: 25px;
  background: rgba(255, 255, 255, 0.1);
}
.login-form .group input[data-type="password"] {
  -webkit-text-security: circle;
}
.login-form .group .label {
  color: #aaa;
  font-size: 12px;
}
.login-form .group .button {
  background: #1161ee;
}
.login-html
  .sign-in:checked
  + .tab
  + .sign-up
  + .tab
  + .login-form
  .sign-in-htm {
  transform: rotate(0);
}
.login-html .sign-up:checked + .tab + .login-form .sign-up-htm {
  transform: rotate(0);
}

.hr {
  height: 2px;
  margin: 60px 0 50px 0;
  background: rgba(255, 255, 255, 0.2);
}
.foot-lnk {
  text-align: center;
}
</style>
