import { createRouter, createWebHistory } from "vue-router";
import Auth from "../views/Auth.vue";
import Home from "../views/Home.vue";
import Post from "../views/Post.vue";
import Setting from "../views/Setting.vue";
import Search from "../views/Search.vue";

function guardMyroute(to, from, next) {
  const option = {
    method: "GET",
    headers: { "Content-Type": "application/json" },
    credentials: "include",
  };
  fetch("http://localhost:3000/api/user/isauth", option)
    .then((response) => response.json())
    .then((data) => {
      next();
      if (data.error) {
        router.push("/");
      }
    });
}

const routes = [
  {
    path: "/",
    name: "Auth",
    component: Auth,
  },
  {
    path: "/home",
    name: "Home",
    beforeEnter: guardMyroute,
    component: Home,
  },
  {
    path: "/post",
    name: "Post",
    beforeEnter: guardMyroute,
    component: Post,
  },
  {
    path: "/setting",
    name: "Setting",
    beforeEnter: guardMyroute,
    component: Setting,
  },
  {
    path: "/search",
    name: "search",
    beforeEnter: guardMyroute,
    component: Search,
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});

export default router;
