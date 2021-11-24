<template>
  <div>
    <Navbar />
    <section>
      <div
        class="
          flex
          w-full
          max-w-sm
          mx-auto
          overflow-hidden
          bg-white
          rounded-lg
          shadow-md
          dark:bg-gray-800
        "
        v-if="sucess"
      >
        <div class="flex items-center justify-center w-12 bg-green-500">
          <svg
            class="w-6 h-6 text-white fill-current"
            viewBox="0 0 40 40"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M20 3.33331C10.8 3.33331 3.33337 10.8 3.33337 20C3.33337 29.2 10.8 36.6666 20 36.6666C29.2 36.6666 36.6667 29.2 36.6667 20C36.6667 10.8 29.2 3.33331 20 3.33331ZM16.6667 28.3333L8.33337 20L10.6834 17.65L16.6667 23.6166L29.3167 10.9666L31.6667 13.3333L16.6667 28.3333Z"
            />
          </svg>
        </div>

        <div class="px-4 py-2 -mx-3">
          <div class="mx-3">
            <span class="font-semibold text-green-500 dark:text-green-400"
              >Bravo</span
            >
            <p class="text-sm text-gray-600 dark:text-gray-200">
              Votre post a été créer !
            </p>
          </div>
        </div>
      </div>
      <div class="h-screen px-2">
        <div
          class="
            max-w-md
            mx-auto
            bg-white
            rounded-lg
            overflow-hidden
            md:max-w-lg
          "
        >
          <div class="md:flex">
            <div class="w-full">
              <div class="p-4 border-b-2">
                <span class="text-lg font-bold text-gray-600"
                  >Créer un Post</span
                >
              </div>
              <div class="p-3">
                <div class="mb-2">
                  <span class="text-base">Titre</span>
                  <input
                    type="text"
                    v-model="title"
                    class="
                      h-12
                      px-3
                      w-full
                      border-gray-200 border
                      rounded
                      focus:outline-none focus:border-gray-300
                    "
                  />
                </div>
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
                      <div
                        class="flex flex-col items-center"
                        v-if="image == ''"
                      >
                        <i
                          class="fas fa-cloud-upload-alt fa-3x text-gray-200"
                        ></i>
                        <span class="block text-gray-400 font-normal"
                          >Joindre vos fichier ici</span
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
                      ><i class="fa fa-lock mr-1"></i> sécurise</span
                    >
                  </div>
                  <p v-if="post_error" class="text-red-500 text-center">
                    {{ post_error }}
                  </p>
                </div>
                <div class="mt-3 text-center pb-3">
                  <button
                    @click="createPost"
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
                    Créer
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
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
      title: "",
      image: "",
      post_error: "",
      sucess: false,
    };
  },
  components: {
    Navbar,
  },
  methods: {
    formReset() {
      (this.title = ""), (this.image = "");
    },
    onChangeFile(event) {
      this.$emit("update:modelValue", event.target.files[0]);
      this.image = event.target.files[0];
    },
    createPost() {
      this.post_error = "";
      console.log(this.image);
      const formData = new FormData();
      formData.append("content", this.title);
      formData.append("image", this.image);

      const option = {
        method: "POST",
        body: formData,
        credentials: "include",
      };
      fetch("http://localhost:3000/api/post", option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          console.log(data);
          this.formReset();
          if (data.error) {
            console.log(data.error);
            this.post_error = data.error;
          } else {
            this.sucess = true;
          }
        });
    },
  },
};
</script>

<style></style>
