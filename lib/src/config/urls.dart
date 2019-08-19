const BASE_API_URL = 'http://tabeldata.ip-dynamic.com/jaring-ummat';
const BASE_API_UPLOADER_URL = 'http://tabeldata.ip-dynamic.com/uploader';

// const BASE_API_URL = 'http://139.162.15.91/jaring-ummat';
// const BASE_API_UPLOADER_URL = 'http://139.162.15.91/uploader';

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
const STORY_BY_ID_URL = BASE_API_URL + '/api/stories/list/';

// For Service Program Amal API
const PROGRAM_AMAL_SAVE_URL = BASE_API_URL + '/api/program-amal/';
const PROGRAM_AMAL_LIST_ALL_URL = BASE_API_URL + '/api/program-amal/list/all';
const PROGRAM_AMAL_LIST_BY_CATEGORY_URL = BASE_API_URL + '/api/program-amal/list/category';
const PROGRAM_AMAL_FINDBYID_URL = BASE_API_URL + '/api/program-amal/';

const BERITA_LIST_ALL_URL =  BASE_API_URL + '/api/berita/list';

// For Service LikeZone API
const SAVE_LIKE_URL = BASE_API_URL + '/api/like/';
const LIST_ALL_LIKE_URL = BASE_API_URL + '/api/like/list';
const LIST_USER_LIKE_PROGRAM = BASE_API_URL + '/api/like/program/list/user';
const LIST_USER_LIKE_BERITA = BASE_API_URL + '/api/like/berita/list/user';
const FINDBYID_LIKE_URL = BASE_API_URL + '/api/like/';
const UNLIKE_PROGRAM_URL = BASE_API_URL + '/api/like/unlikeProgramAmal';
const UNLIKE_BERITA_URL = BASE_API_URL + '/api/like/unlikeNews';

// URL for service CommentZone
const SAVE_COMMENT_URL = BASE_API_URL + '/api/comment/';
const LIST_ALL_COMMENT_URL = BASE_API_URL + '/api/comment/list';
const FINDBYID_COMMENT_URL = BASE_API_URL + '/api/comment/';
const LIST_ALL_COMMENT_NEWS_URL = BASE_API_URL + '/api/comment/news/';
const LIST_ALL_COMMENT_PROGRAM_AMAL_URL = BASE_API_URL + '/api/comment/program/';

// URL List Lembaga Amal
const LIST_ALL_LEMBAGA_AMAL = BASE_API_URL + '/api/lembaga-amal/list/popular';
