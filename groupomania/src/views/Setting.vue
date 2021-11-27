<template>
  <div>
    <Navbar />
    <main class="px-5 py-3 sm:mt-0 mt-20">
      <div class="container mx-auto">
        <div
          class="
            flex flex-col
            items-center
            justify-center
            bg-white
            p-4
            shadow
            rounded-lg
          "
        >
          <div
            class="
              inline-flex
              shadow-lg
              border border-gray-200
              rounded-full
              overflow-hidden
              h-40
              w-40
            "
          >
            <img
              v-if="user_info.pictureurl !== null"
              :src="user_info.pictureurl"
              alt="Photo de profil"
              class="h-full w-full"
            />
            <i v-else class="fas fa-10x fa-user-circle text-gray-500"></i>
          </div>

          <h2 class="mt-4 font-bold text-xl">{{ user_info.name }}</h2>
          <h6 class="mt-2 text-sm font-medium" v-if="user_info.isadmin == 1">
            Admin
          </h6>
          <p class="text-gray-500 text-center mt-3">{{ user_info.email }}</p>
          <p class="text-xs text-gray-500 text-center mt-3">
            {{ user_info.outline }}
          </p>
        </div>
      </div>

      <div class="max-w-2xl bg-white py-10 px-5 m-auto w-full mt-10">
        <div class="text-xl mb-6 text-center">Modifier la description</div>

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
                h-20
              "
              placeholder="Message"
              v-model="outline"
            ></textarea>
          </div>

          <div class="col-span-2 text-right">
            <button
              class="py-3 px-6 bg-green-500 text-white font-bold w-full sm:w-32"
              @click="changeOutline(user.userId)"
            >
              Modifier
            </button>
          </div>
        </div>
      </div>

      <div
        class="
          max-w-md
          mx-auto
          bg-white
          rounded-lg
          overflow-hidden
          md:max-w-lg
          mt-5
          mb-5
        "
      >
        <div class="md:flex">
          <div class="w-full">
            <div class="p-4 border-b-2">
              <span class="text-lg font-bold text-gray-600"
                >Modifier la photo de profil</span
              >
            </div>
            <div class="p-3 z-0">
              <div class="mb-2">
                <span>Image</span>
                <div
                  class="
                    relative
                    h-40
                    rounded-lg
                    border-dashed border-2 border-gray-200
                    bg-white
                    flex
                    justify-center
                    items-center
                    hover:cursor-pointer
                  "
                >
                  <div class="absolute">
                    <div class="flex flex-col items-center" v-if="image == ''">
                      <i
                        class="fas fa-cloud-upload-alt fa-3x text-gray-200"
                      ></i>
                      <span class="block text-gray-400 font-normal"
                        >Déposer vos fichier ici</span
                      >
                      <span class="block text-gray-400 font-normal">ou</span>
                      <span class="block text-blue-400 font-normal"
                        >Parcourir les fichiers</span
                      >
                    </div>

                    <div class="flex flex-col items-center" v-else>
                      <i
                        class="fas fa-cloud-upload-alt fa-3x text-gray-200"
                      ></i>
                      <span class="block text-gray-400 font-normal">
                        {{ image.name }}
                      </span>
                    </div>
                  </div>
                  <input
                    type="file"
                    class="h-full w-full opacity-0"
                    name=""
                    @change="onChangeFile"
                  />
                </div>
                <div class="flex justify-between items-center text-gray-400">
                  <span
                    >Type de fichier accepté : .png .jpg .gif uniquement</span
                  >
                  <span class="flex items-center"
                    ><i class="fa fa-lock mr-1"></i> sécurisé</span
                  >
                </div>
              </div>
              <div class="mt-3 text-center pb-3">
                <button
                  @click="changePicture(user.userId)"
                  class="
                    w-full
                    h-12
                    text-lg
                    w-32
                    bg-blue-600
                    rounded
                    text-white
                    hover:bg-blue-700
                  "
                >
                  Modifier
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="flex items-center justify-center">
        <div class="w-full max-w-md">
          <form
            @submit.prevent="changePassword"
            class="bg-white shadow-lg rounded px-12 pt-6 pb-8 mb-4"
          >
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
              <p v-if="newPass_error" class="text-red-500">
                {{ newPass_error }}
              </p>
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
import validator from "validator";
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
      newPass_error: "",
      user_info: "",
    };
  },
  components: {
    Navbar,
  },
  methods: {
    changeOutline(userId) {
      const option = {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ outline: this.outline }),
        credentials: "include",
      };
      fetch(`http://localhost:3000/api/user/${userId}/outline`, option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          this.outline = "";
          this.getCurrentUser();
          if (data.error) {
            this.outline = "";
          }
        });
    },
    onChangeFile(event) {
      this.$emit("update:modelValue", event.target.files[0]);
      this.image = event.target.files[0];
    },
    changePicture(userId) {
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
          this.sucess = true;
          this.image = "";
          this.getCurrentUser();
          if (data.error) {
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
          fetch(`http://localhost:3000/api/user/${this.user.userId}`, option)
            .then((response) => response.json())
            .catch((error) => {
              console.error("There was an error!", error);
            })
            .then((data) => {
              this.user_info = data;
            });
        });
    },
    passwordValidate() {
      this.newPass_error = "";
      const { newPass } = this;
      if (!validator.isStrongPassword(newPass)) {
        this.newPass_error =
          "Le mot de passe doit contenir 8 caractères, 1 majuscule,1 minuscule et 1 caracatére spéciale";
        this.newPass = "";
        return false;
      }
      return true;
    },
    changePassword() {
      if (!this.passwordValidate()) {
        return;
      }
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
          this.oldPass = "";
          this.newPass = "";
          if (data.error) {
            this.newPass_error = data.error;
          } else {
            alert("Le mot de passe a été modfier");
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
