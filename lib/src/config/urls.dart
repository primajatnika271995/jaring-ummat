//const BASE_API_URL = 'http://139.162.15.91/jaring-ummat';

//const BASE_API_URL = 'http://192.168.1.7:9091';
//const BASE_API_UPLOADER_URL = 'http://192.168.1.7:8080';

const BASE_API_URL = 'http://192.168.1.50:9091';
const BASE_API_UPLOADER_URL = 'http://192.168.1.50:9095';

const UPLOADER_MEDIA_IMAGE = BASE_API_UPLOADER_URL + '/api/media/upload/image';

// BASE REGISTER AND LOGIN_URL
const REGISTRATION_URL = BASE_API_URL + '/api/user/';
const LOGIN_URL = BASE_API_URL + '/oauth/token';

const USER_BY_ID_URL = BASE_API_URL + '/api/user/';

// BASE USER DETAILS
const USER_DETAILS_URL = BASE_API_URL + '/api/user/findByEmail';
const CHECK_REGISTRATION_EMAIL = BASE_API_URL + '/api/user/checkout';

// BASE NEWS CONTENT
const NEWS_GET_LIST = BASE_API_URL + '/api/berita/list';
const NEWS_CREATE = BASE_API_URL + '/api/berita/';

// BASE STORY
const ALL_STORY_URL = BASE_API_URL + '/api/stories/list';

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
const LIST_ALL_COMMENT_NEWS_URL = BASE_API_URL + '/api/comment/news/';
const LIST_ALL_COMMENT_PROGRAM_AMAL_URL = BASE_API_URL + '/api/comment/program/';
