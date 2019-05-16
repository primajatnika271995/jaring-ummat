const BASE_API_URL = 'http://192.168.1.35:9091';

//const BASE_API_URL = 'http://139.162.15.91/jaring-ummat';

// BASE REGISTER AND LOGIN_URL
const REGISTRATION_URL = BASE_API_URL + '/api/user/';
const LOGIN_URL = BASE_API_URL + '/oauth/token';

// BASE USER DETAILS
const USER_DETAILS_URL = BASE_API_URL + '/api/user/desc';
const CHECK_REGISTRATION_EMAIL = BASE_API_URL + '/api/user/checkout';

// BASE NEWS CONTENT
const NEWS_GET_LIST = BASE_API_URL + '/api/news/list';
const NEWS_CREATE = BASE_API_URL + '/api/news/';

const USER_STORY_LIST = 'https://api.myjson.com/bins/1fbge0';

// For Service Program Amal API
const PROGRAM_AMAL_SAVE_URL = BASE_API_URL + '/api/program-amal/';
const PROGRAM_AMAL_LIST_ALL_URL = BASE_API_URL + '/api/program-amal/list';
const PROGRAM_AMAL_FINDBYID_URL = BASE_API_URL + '/api/program-amal/';

// For Service LikeZone API
const SAVE_LIKE_URL = BASE_API_URL + '/api/like/';
const LIST_ALL_LIKE_URL = BASE_API_URL + '/api/like/list';
const FINDBYID_LIKE_URL = BASE_API_URL + '/api/like/';

// URL for service CommentZone
const SAVE_COMMENT_URL = BASE_API_URL + '/api/comment/';
const LIST_ALL_COMMENT_URL = BASE_API_URL + '/api/comment/list';
const FINDBYID_COMMENT_URL = BASE_API_URL + '/api/comment/';
