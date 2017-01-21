/*! gumshoe v3.3.2 | (c) 2016 Chris Ferdinandi | MIT License | http://github.com/cferdinandi/gumshoe */
!(function(e,t){"function"==typeof define&&define.amd?define([],t(e)):"object"==typeof exports?module.exports=t(e):e.gumshoe=t(e)})("undefined"!=typeof global?global:this.window||this.global,(function(e){"use strict";var t,n,o,r,a,c,i={},l="querySelector"in document&&"addEventListener"in e&&"classList"in document.createElement("_"),s=[],u={selector:"[data-gumshoe] a",selectorHeader:"[data-gumshoe-header]",container:e,offset:0,activeClass:"active",callback:function(){}},f=function(e,t,n){if("[object Object]"===Object.prototype.toString.call(e))for(var o in e)Object.prototype.hasOwnProperty.call(e,o)&&t.call(n,e[o],o,e);else for(var r=0,a=e.length;r<a;r++)t.call(n,e[r],r,e)},d=function(){var e={},t=!1,n=0,o=arguments.length;"[object Boolean]"===Object.prototype.toString.call(arguments[0])&&(t=arguments[0],n++);for(var r=function(n){for(var o in n)Object.prototype.hasOwnProperty.call(n,o)&&(t&&"[object Object]"===Object.prototype.toString.call(n[o])?e[o]=d(!0,e[o],n[o]):e[o]=n[o])};n<o;n++){var a=arguments[n];r(a)}return e},v=function(e){return Math.max(e.scrollHeight,e.offsetHeight,e.clientHeight)},m=function(){return Math.max(document.body.scrollHeight,document.documentElement.scrollHeight,document.body.offsetHeight,document.documentElement.offsetHeight,document.body.clientHeight,document.documentElement.clientHeight)},g=function(e){var n=0;if(e.offsetParent){do n+=e.offsetTop,e=e.offsetParent;while(e)}else n=e.offsetTop;return n=n-a-t.offset,n>=0?n:0},h=function(t){var n=t.getBoundingClientRect();return n.top>=0&&n.left>=0&&n.bottom<=(e.innerHeight||document.documentElement.clientHeight)&&n.right<=(e.innerWidth||document.documentElement.clientWidth)},p=function(){s.sort((function(e,t){return e.distance>t.distance?-1:e.distance<t.distance?1:0}))};i.setDistances=function(){o=m(),a=r?v(r)+g(r):0,f(s,(function(e){e.distance=g(e.target)})),p()};var b=function(){var e=document.querySelectorAll(t.selector);f(e,(function(e){if(e.hash){var t=document.querySelector(e.hash);t&&s.push({nav:e,target:t,parent:"li"===e.parentNode.tagName.toLowerCase()?e.parentNode:null,distance:0})}}))},y=function(){c&&(c.nav.classList.remove(t.activeClass),c.parent&&c.parent.classList.remove(t.activeClass))},H=function(e){y(),e.nav.classList.add(t.activeClass),e.parent&&e.parent.classList.add(t.activeClass),t.callback(e),c={nav:e.nav,parent:e.parent}};i.getCurrentNav=function(){var n=e.pageYOffset;if(e.innerHeight+n>=o&&h(s[0].target))return H(s[0]),s[0];for(var r=0,a=s.length;r<a;r++){var c=s[r];if(c.distance<=n)return H(c),c}y(),t.callback()};var C=function(){f(s,(function(e){e.nav.classList.contains(t.activeClass)&&(c={nav:e.nav,parent:e.parent})}))};i.destroy=function(){t&&(t.container.removeEventListener("resize",L,!1),t.container.removeEventListener("scroll",L,!1),s=[],t=null,n=null,o=null,r=null,a=null,c=null)};var L=function(e){n||(n=setTimeout((function(){n=null,"scroll"===e.type&&i.getCurrentNav(),"resize"===e.type&&(i.setDistances(),i.getCurrentNav())}),66))};return i.init=function(e){l&&(i.destroy(),t=d(u,e||{}),r=document.querySelector(t.selectorHeader),b(),0!==s.length&&(C(),i.setDistances(),i.getCurrentNav(),t.container.addEventListener("resize",L,!1),t.container.addEventListener("scroll",L,!1)))},i}));