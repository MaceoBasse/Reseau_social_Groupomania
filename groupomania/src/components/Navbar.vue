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
        class="
          fixed
          bottom-0
          bg-blue-200
          sm:static sm:bg-transparent
          w-full
          z-10
        "
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
              <img
                v-if="this.notification_length !== 0"
                src="../assets/notification.png"
                class="w-7"
                @click="showNotif = !showNotif"
              />
              <i
                v-else
                class="fas fa-bell fa-lg h-5 w-6"
                @click="showNotif = !showNotif"
              ></i>
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
      <main class="px-5 py-3 relative z-1">
        <div
          v-show="showNotif"
          v-for="(notification, i) in this.notifications"
          :key="i"
        >
          <div v-for="(notif, i) in notification" :key="i">
            <div class="mb-4">
              <div
                class="
                  flex
                  max-w-sm
                  w-full
                  bg-white
                  shadow-md
                  rounded-lg
                  overflow-hidden
                  mx-auto
                "
              >
                <div class="w-2 bg-green-600"></div>
                <div class="w-full flex justify-between items-start px-2 py-2">
                  <div class="flex flex-col ml-2">
                    <label
                      class="text-gray-800"
                      v-if="notif.type == 'reaction'"
                    >
                      {{ notif.initiator }} a réagit votre post</label
                    >
                    <label class="text-gray-800" v-if="notif.type == 'comment'">
                      {{ notif.initiator }} a commenté votre post</label
                    >
                    <label class="text-gray-800" v-if="notif.type == 'answer'">
                      {{ notif.initiator }} a répondu votre commentaire</label
                    >
                  </div>

                  <a @click="deleteNotif(notif.id)">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-6 w-6 text-gray-500"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M6 18L18 6M6 6l12 12"
                      />
                    </svg>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
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
      showNotif: false,
      user: [],
      search: "",
      notifications: [],
      notification_length: "",
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
          this.data = data
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
        });
    },
    searchUser() {
      this.$router.push(`/search?user=${this.search}`);
    },

    getNotif() {
      const option = {
        method: "GET",
        credentials: "include",
      };
      fetch("http://localhost:3000/api/notif", option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          this.notifications = data;
          let keys = Object.keys(data);
          for (let i = 0; i < keys.length; i++) {
            let val = data[keys[i]];
            this.notification_length = val.length;
          }
        });
    },
    deleteNotif(notifId) {
      const option = {
        method: "DELETE",
        credentials: "include",
      };
      fetch(`http://localhost:3000/api/notif/${notifId}`, option)
        .then((response) => response.json())
        .catch((error) => {
          console.error("There was an error!", error);
        })
        .then((data) => {
          this.data = data
          this.getNotif();
        });
    },
  },
  beforeMount() {
    this.getCurrentUser();
    this.getNotif();
  },
};
</script>

<style></style>
