<template>
  <div>
    <Navbar />
    <main class="px-5 py-3 sm:mt-0 mt-20">
      <div class="container mx-auto">
        <h2 class="text-center text-xl">Setting</h2>
      </div>

      <div class="max-w-2xl bg-white py-10 px-5 m-auto w-full mt-10">
        <div class="text-3xl mb-6 text-center">Description</div>

        <div class="grid grid-cols-2 gap-4 max-w-xl m-auto">
          <div class="col-span-2">
            <textarea
              cols="30"
              rows="8"
              class="
                border-solid border-gray-400 border-2
                p-3
                md:text-xl
                w-full
              "
              placeholder="Message"
              v-model="outline"
            ></textarea>
          </div>

          <div class="col-span-2 text-right">
            <button
              class="py-3 px-6 bg-green-500 text-white font-bold w-full sm:w-32"
              @click="changeOutline"
            >
              Modifier
            </button>
          </div>
        </div>
      </div>
      <div class="container mx-auto border-2 w-min">
        <label class="block text-sm font-medium text-gray-700"> Photo </label>
        <div class="mt-1 flex items-center">
          <input type="file" name="" @change="onChangeFile" />
          <span
            class="
              inline-block
              h-12
              w-12
              rounded-full
              overflow-hidden
              bg-gray-100
            "
          >
            <svg
              class="h-full w-full text-gray-300"
              fill="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                d="M24 20.993V24H0v-2.996A14.977 14.977 0 0112.004 15c4.904 0 9.26 2.354 11.996 5.993zM16.002 8.999a4 4 0 11-8 0 4 4 0 018 0z"
              />
            </svg>
          </span>
          <button
            type="button"
            class="
              ml-5
              bg-white
              py-2
              px-3
              border border-gray-300
              rounded-md
              shadow-sm
              text-sm
              leading-4
              font-medium
              text-gray-700
              hover:bg-gray-50
              focus:outline-none
              focus:ring-2
              focus:ring-offset-2
              focus:ring-indigo-500
            "
            @click="changePicture(user.userId)"
          >
            Change
          </button>
        </div>
      </div>

      <div class="flex items-center justify-center">
        <div class="w-full max-w-md">
          <form
            @submit.prevent="changePassword"
            class="bg-white shadow-lg rounded px-12 pt-6 pb-8 mb-4"
          >
            <!-- @csrf -->
            <div
              class="
                text-gray-800 text-2xl
                flex
                justify-center
                border-b-2
                py-2
                mb-4
              "
            >
              Modifier le mot de passe
            </div>
            <div class="mb-4">
              <label
                class="block text-gray-700 text-sm font-normal mb-2"
                for="username"
              >
                Ancien Mot de passe
              </label>
              <input
                class="
                  shadow
                  appearance-none
                  border
                  rounded
                  w-full
                  py-2
                  px-3
                  text-gray-700
                  leading-tight
                  focus:outline-none focus:shadow-outline
                "
                name="oldPass"
                v-model="oldPass"
                type="password"
                required
                autofocus
                placeholder="Ancien Mot de passe"
              />
            </div>
            <div class="mb-6">
              <label
                class="block text-gray-700 text-sm font-normal mb-2"
                for="password"
              >
                Nouveau mot de passe
              </label>
              <input
                class="
                  shadow
                  appearance-none
                  border
                  rounded
                  w-full
                  py-2
                  px-3
                  text-gray-700
                  mb-3
                  leading-tight
                  focus:outline-none focus:shadow-outline
                "
                v-model="newPass"
                type="password"
                placeholder="Nouveau mot de passe"
                name="password"
                required
                autocomplete="current-password"
              />
            </div>
            <div class="flex items-center justify-between">
              <button
                class="
                  px-4
                  py-2
                  rounded
                  text-white
                  inline-block
                  shadow-lg
                  bg-blue-500
                  hover:bg-blue-600
                  focus:bg-blue-700
                "
                type="submit"
              >
                Modifier
              </button>
            </div>
          </form>
        </div>
      </div>
      <div class="container mx-auto">
        <button
          class="
            px-4
            py-2
            rounded-md
            text-sm
            font-medium
            border-0
            focus:outline-none focus:ring
            transition
            text-white
            bg-red-500
            hover:bg-red-600
            active:bg-red-700
            focus:ring-red-300
            mb-20
            ml-40
          "
          type="submit"
          @click="deleteAccount(user.userId)"
        >
          Supprimer mon compte
        </button>
      </div>
    </main>
  </div>
</template>

<script>
import Navbar from "../components/Navbar.vue";
export default {
  data() {
    return {
      showUserMenu: false,
      showSideBar: false,
      showSearch: false,
      outline: "",
      image: "",
      oldPass: "",
      newPass: "",
    };
  },
  components: {
    Navbar,
  },
  methods: {
    changeOutline() {
      console.log(this.outline);

      const option = {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ outline: this.outline }),
        credentials: "include",
      };
      fetch("http://localhost:3000/api/user/1/outline", option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          console.log(data);
          this.outline = "";
          if (data.error) {
            console.log(data.error);
            this.outline = "";
          }
        });
    },
    onChangeFile(event) {
      this.$emit("update:modelValue", event.target.files[0]);
      this.image = event.target.files[0];
    },
    changePicture(userId) {
      console.log(this.image);
      const formData = new FormData();
      formData.append("image", this.image);

      const option = {
        method: "PUT",
        body: formData,
        credentials: "include",
      };
      fetch(`http://localhost:3000/api/user/${userId}/picture`, option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          console.log(data);
          this.sucess = true;
          this.image = "";
          if (data.error) {
            console.log(data.error);
            this.image = "";
          }
        });
    },
    deleteAccount(userId) {
      const option = {
        method: "DELETE",
        credentials: "include",
      };
      fetch(`http://localhost:3000/api/user/${userId}`, option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          console.log(data);
          this.$router.push("/");
          if (data.error) {
            console.log(data.error);
          }
        });
    },
    getCurrentUser() {
      const option = {
        method: "GET",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
      };
      fetch("http://localhost:3000/api/user/currentuser", option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          this.user = data;
          if (data.error) {
            console.log(data.error);
          }
        });
    },
    changePassword() {
      const option = {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          oldPassword: this.oldPass,
          newPassword: this.newPass,
        }),
        credentials: "include",
      };
      fetch(
        `http://localhost:3000/api/user/${this.user.userId}/password`,
        option
      )
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          console.log(data);
          this.oldPass = "";
          this.newPass = "";

          if (data.error) {
            console.log(data.error);
            this.oldPass = "";
            this.newPass = "";
          }
        });
    },
  },
  beforeMount() {
    this.getCurrentUser();
  },
};
</script>

<style></style>
