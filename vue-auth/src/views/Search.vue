<template>
  <div>
    <Navbar />
    <div class="sm:mt-0 mt-20">
      <h1 class="text-center text-xl mb-5">Recherche</h1>

      <div>
        <div v-for="(user, index) in users" :key="index">
          <div v-if="user.length == 0">
            <p class="text-center">Nous n'avons pas trouvé d'utilisateurs</p>
          </div>
          <div
            @click="GetPostUser(users.id)"
            v-for="(users, index) in user"
            :key="index"
          >
            <div
              class="
                each
                flex
                rounded
                shadow
                w-max
                text-gray-600
                mb-5
                bg-white
                container
                mx-auto
                hover:bg-grey-400
              "
            >
              <div class="sec self-center p-2 pr-1">
                <img
                  v-if="users.pictureurl !== null"
                  :src="users.pictureurl"
                  alt="Img"
                  class="
                    h-8
                    w-8
                    object-cover
                    rounded-full
                    box-content
                    border-2 border-gray-400
                  "
                />
                <i v-else class="fas fa-2x fa-user-circle"></i>
              </div>
              <div class="sec self-center p-2 w-64">
                <div class="flex">
                  <div class="name text-sm">{{ users.name }}</div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Navbar from "../components/Navbar.vue";
import { ref } from "vue";
export default {
  data() {
    return {
      showUserMenu: false,
      showSideBar: false,
      showSearch: false,
      users: ref([]),
    };
  },
  components: {
    Navbar,
  },
  methods: {
    Search() {
      var str = document.URL;
      var url = new URL(str);
      var search_params = new URLSearchParams(url.search);
      if (search_params.has("user")) {
        const option = {
          method: "GET",
          credentials: "include",
        };
        fetch(
          `http://localhost:3000/api/user/search?name=${search_params.get(
            "user"
          )}`,
          option
        )
          .then((response) => response.json())
          .catch((error) => {
            console.error("There was an error!", error);
          })
          .then((data) => {
            this.users = data;
            console.log(this.users);
            if (data.error) {
              console.log(data.error);
            }
          });
      }
    },
    GetPostUser(userId) {
      console.log(userId);
      const option = {
        method: "GET",
        credentials: "include",
      };
      fetch(`http://localhost:3000/api/user/${userId}/posts`, option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          console.log(data);
          if (data.error) {
            console.log(data.error);
          }
        });
    },
  },
  beforeMount() {
    this.Search();
  },
};
</script>

<style></style>
