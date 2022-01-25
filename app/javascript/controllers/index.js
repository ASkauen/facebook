// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AvatarController from "./avatar_controller.js"
application.register("avatar", AvatarController)

import FriendshipButtonController from "./friendship_button_controller.js"
application.register("friendship-button", FriendshipButtonController)

import HelloController from "./hello_controller.js"
application.register("hello", HelloController)

import LikeButtonController from "./like_button_controller.js"
application.register("like-button", LikeButtonController)

import NotificationsController from "./notifications_controller.js"
application.register("notifications", NotificationsController)

import PostController from "./post_controller.js"
application.register("post", PostController)

import RevealForController from "./reveal_for_controller.js"
application.register("reveal-for", RevealForController)

import ShowMoreController from "./show_more_controller.js"
application.register("show-more", ShowMoreController)
