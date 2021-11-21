<template>
  <div
    id="app"
    class="
      flex flex-col-reverse
      antialiased
      bg-gray-100
      text-gray-500
      sm:flex-row
      h-auto
    "
  >
    <link
      rel="stylesheet"
      href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
      integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
      crossorigin="anonymous"
    />
    <aside>
      <nav
        class="fixed bottom-0 bg-blue-200 sm:static sm:bg-transparent w-full"
      >
        <ul class="flex items-center sm:flex-col sm:items-stretch">
          <li class="flex-1">
            <a
              href="/home"
              class="
                flex flex-col
                items-center
                font-semibold
                tracking-wide
                px-5
                pt-1
                hover:text-gray-800
                sm:py-3
              "
            >
              <i class="fas fa-home fa-2x md:my-3 h-8 w-6"></i>
              <span class="sm:hidden lg:block">Dashboard</span>
            </a>
          </li>
          <li class="flex-1">
            <a
              href="/setting"
              class="
                flex flex-col
                items-center
                font-semibold
                tracking-wide
                px-5
                pt-1
                hover:text-gray-800
                sm:py-3
              "
            >
              <i class="fas fa-cog fa-2x h-8 w-6"></i>
              <span class="sm:hidden lg:block">Setting</span>
            </a>
          </li>
        </ul>
      </nav>
    </aside>
    <section class="flex-auto h-1">
      <form
        v-show="showSearch"
        @submit.prevent="searchUser"
        class="mb-4 flex w-full"
      >
        <input
          type="text"
          placeholder="Search..."
          v-model="search"
          class="-mr-8 px-5 py-3 w-full shadow-sm tracking-wide font-semibold"
        />
        <button type="button" @click="showSearch = false">
          <i class="fas fa-times fa-2x h-5 w-5"></i>
        </button>
      </form>
      <header
        v-show="!showSearch"
        class="px-5 py-3 flex justify-between items-center"
      >
        <div>
          <img
            src="../assets/icon-left-font.png"
            alt="Logo Groupomania"
            class="w-60"
          />
        </div>
        <nav class="flex justify-around items-center">
          <div
            class="
              mr-2
              pr-2
              flex
              items-center
              border-r border-gray-400
              sm:mr-4 sm:pr-4
            "
          >
            <button @click="showSearch = true" class="mr-2">
              <i class="fas fa-search fa-lg h-5 w-6"></i>
            </button>
            <button>
              <a href="/post">
                <i class="fas fa-plus-circle fa-2x h-5 w-10"></i
              ></a>
            </button>
            <button class="relative">
              <i class="fas fa-bell fa-lg h-5 w-6"></i>
            </button>
          </div>
          <div class="relative">
            <button
              @click="showUserMenu = !showUserMenu"
              class="flex items-center"
            >
              <span class="mr-2 font-semibold hidden sm:block">
                {{ this.user.name }}
              </span>
              <img
                v-if="this.user.pictureUrl !== null"
                :src="this.user.pictureUrl"
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
            </button>
            <div
              v-show="showUserMenu"
              class="
                w-40
                overflow-hidden
                absolute
                right-0
                rounded-md
                shadow-md
                bg-white
              "
            >
              <a
                href="/setting"
                class="block px-4 py-2 hover:bg-gray-800 hover:text-gray-100"
                >Account Settings</a
              >
              <a
                class="block px-4 py-2 hover:bg-gray-800 hover:text-gray-100"
                @click="Logout"
                >Log out</a
              >
            </div>
          </div>
        </nav>
      </header>
      <main class="px-5 py-3"></main>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      showUserMenu: false,
      showSideBar: false,
      showSearch: false,
      user: [],
      search: "",
    };
  },
  methods: {
    Logout() {
      const option = {
        method: "GET",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
      };
      fetch("http://localhost:3000/api/user/logout", option)
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
          //   console.log(this.user);
          if (data.error) {
            console.log(data.error);
          }
        });
    },
    searchUser() {
      console.log(this.search);
      this.$router.push(`/search?user=${this.search}`);
      // window.location.reload(true);
      
    },
  },
  beforeMount() {
    this.getCurrentUser();
  },
};
</script>

<style></style>
