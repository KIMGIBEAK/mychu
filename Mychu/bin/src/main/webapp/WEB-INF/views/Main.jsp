<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>홈</title>
    <link rel="stylesheet" href="resources/css/default.css">
    <link rel="stylesheet" href="resources/css/font.css">
    <link rel="stylesheet" href="resources/css/main.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body>
    <div id="home_wrap">
        <div>
            <a href="#" id="go_top"> <img src="resources/img/top_icon.png" alt="top icon"></a>
        </div>

        <div id="home">
        
<div id="sort_buttons">
    <button onclick="sortPosts('views')">인기순</button>
    <button onclick="sortPosts('latest')">최신순</button>
    <button onclick="sortPosts('popular')">좋아요순</button>
    <button onclick="showAllPosts()">전체 보기</button>
</div>

            <div class="con_wrap">
                <c:forEach items="${posts}" var="post" varStatus="i">
                    <!-- 게시글 -->
                    <div class="container"  data-ott="${post.postOtt}" data-title="${post.movieIdx.movieTitleKr}">
                        <!-- 게시글 작성자 프로필 -->
                        <div class="user_section">
                           <c:if test="${loginInfo.userIdx eq post.userIdx.userIdx}">
                     <a href="gomy_Page">
                     <img id="pp" src="resources/profile/${empty post.userIdx.profile ? 'test_img.jpg' : post.userIdx.profile}" alt="글 작성자 프로필">
                     </a>
                     </c:if>
                     
                     <c:if test="${loginInfo.userIdx ne post.userIdx.userIdx}">
                     <a href="goYourPage?idx=${post.userIdx.userIdx}">
                     <img id="pp" src="resources/profile/${empty post.userIdx.profile ? 'test_img.jpg' : post.userIdx.profile}" alt="글 작성자 프로필">
                     </a>
                     </c:if>
                            <!-- 게시글 작성자 정보 -->
                            <div class="user_info">
                            
                                <c:if test="${not empty loginInfo}">
                      				<a href="postDetail?idx=${post.postIdx}">
                      			</c:if>
                        <div class="info">${post.userIdx.userName}</div>
                        <div class="created_at">
                           <fmt:formatDate value="${post.createdAt}"
                              pattern="yyyy-MM-dd HH:mm:ss" />
                        </div>
                        
                        <c:if test="${not empty loginInfo}">
                        </a>
                        </c:if>
                            </div>
                        </div>

                        <!-- 게시글 제목 -->
                        <div class="content_section">${post.postContent}</div>

                        <!-- 장르, 게시글 수정, 게시글 삭제 -->
                        <div class="n_box">
                           <button onclick="filterPosts('${post.postOtt}')" class="tag ott_tag"># ${post.postOtt}</button>
                           <button onclick="filterPostsMovie('${post.movieIdx.movieTitleKr}')" class="tag">${post.movieIdx.movieTitleKr}</button>
                        </div>

                        <!-- 게시글 좋아요, 댓글 -->
                        <div class="con_section">
                            <span>좋아요</span> <img class="icon_like n_like" onclick="toggleLike(${post.postIdx}, this)"
                                src="resources/img/like_icon.png" alt="좋아요" id="n_liked_${post.postIdx}">
                            <span class="like_count" id="like_count_${post.postIdx}">${post.likeCount}</span>
                            <c:forEach items="${postLikes}" var="postLikes">
                                <c:if
                                    test="${loginInfo.userIdx eq postLikes.userIdx.userIdx && post.postIdx eq postLikes.postIdx.postIdx}">
                                    <img class="icon_like n_like" onclick="toggleLike(${post.postIdx}, this)"
                                        src="resources/img/like_ck_icon.png" alt="싫어요" id="n_liked_${post.postIdx}">
                                    <span class="like_count">${post.likeCount}</span>
                                    <c:set var="hideLike" value="true" />
                                    <c:if test="${hideLike eq 'true'}">
                                        <script>
                                            document
                                                .getElementById('n_liked_${post.postIdx}').style.display = 'none';

                                            document
                                                .getElementById('like_count_${post.postIdx}').style.display = 'none';
                                        </script>
                                    </c:if>

                                </c:if>
                            </c:forEach>
                            <div class="view">
							 <span>Views &emsp;</span><span class="post_views">${post.postViews}</span>
							 </div>
                        </div>

                    </div>
                </c:forEach>
            </div>
        </div>
        
        <!-- 고정 메뉴-->
        <div id="nav_box">
            <a href="goMain">
                <div class="navcon"><img src="resources/img/home_icon.png" alt="홈">
                    <div class="menu_bt"><span>홈</span></div>
                </div>
            </a>
            
                        <c:if test="${empty loginInfo}">
                <!-- 로그인 전 -->
                <a href="#" class="nav_link" data-href="goLogin">
                    <div class="navcon">
                        <img src="resources/img/bookmark_icon.png" alt="나만의 컨텐츠">
                        <div class="menu_bt">
                            <span>나만의 컨텐츠</span>
                        </div>
                    </div>
                </a>
                <a href="#" class="nav_link" data-href="goLogin">
                    <div class="navcon">
                        <img src="resources/img/edit_icon.png" alt="게시글 작성">
                        <div class="menu_bt">
                            <span>게시글 작성</span>
                        </div>
                    </div>
                </a>
                <a href="#" class="nav_link" data-href="goLogin">
                    <div class="navcon">
                        <img src="resources/img/profile_icon.png" alt="로그인/회원가입">
                        <div class="menu_bt">
                            <span>로그인 / 회원가입</span>
                        </div>
                    </div>
                </a>
            </c:if>

            <c:if test="${not empty loginInfo}">
                <!-- 로그인 후 -->
                <a href="goContents">
                    <div class="navcon"><img src="resources/img/bookmark_icon.png" alt="나만의 컨텐츠">
                        <div class="menu_bt"><span>나만의 컨텐츠</span></div>
                    </div>
                </a>

                <a href="goWrite">
                    <div class="navcon"><img src="resources/img/edit_icon.png" alt="게시글 작성">
                        <div class="menu_bt"><span>게시글 작성</span></div>
                    </div>
                </a>

                <a href="gomy_Page">
                    <div class="navcon"><img src="resources/img/profile_icon.png" alt="프로필">
                        <div class="menu_bt"><span>마이페이지</span></div>
                    </div>
                </a>
                <a href="userLogout">
                    <div class="navcon"><img src="resources/img/logout_icon.png" alt="로그아웃">
                        <div class="menu_bt"><span>로그아웃</span></div>
                    </div>
                </a>
            </c:if>

             <div class="logo_pc"><img src="resources/img/r_logo.png"></div>
        </div>
    </div>
        
    </div>
    
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
    function mouseover(element) {
        element.setAttribute("src", "resources/img/like_ck_icon.png");
    }

    function mouseleave(element) {
        element.setAttribute("src", "resources/img/like_icon.png");
    }

	const Toast = Swal.mixin({
	    toast: true,
	    position: 'center-center',
	    showConfirmButton: false,
	    timer: 700,
	    timerProgressBar: false
	});
	
    function toggleLike(postIdx, element) {
        $.ajax({
            url: './toggleLike',
            type: 'GET',
            data: {
                postIdx: postIdx
            },
            success: function (response) {
                if (response.success) {
                    let likeCountElement = $(element).next(".like_count");
                    let currentLikeCount = parseInt(likeCountElement.text(), 10);

                    if (response.liked) {
                        $(element).attr("src", "resources/img/like_ck_icon.png");
                        likeCountElement.text(currentLikeCount + 1);
                    } else {
                        likeCountElement.text(currentLikeCount - 1);
                        $(element).attr("src", "resources/img/like_icon.png");
                    }
                } else {
                	Toast.fire({
                        icon: 'info',
                        title: '로그인 이후 가능합니다!'
                    });
                }
            },
            error: function (xhr, status, error) {
                console.error('AJAX 요청 실패:', status, error);
            }
        });
    }

    $(document).ready(function () {
        // 스크롤 이벤트 감지
        $(window).scroll(function () {
            if ($(this).scrollTop() > 300) { // 300px 이상 스크롤 시 버튼 표시
                $('#go_top').fadeIn();
            } else {
                $('#go_top').fadeOut();
            }
        });

        // 위로 가기 버튼 클릭 시 애니메이션
        $("#go_top").click(function () {
            $("html, body").animate({
                scrollTop: 0
            }, "slow");
            return false;
        });
    });

    $(document).ready(function () {
        $(".nav_link").click(function (e) {
            e.preventDefault(); // 기본 링크 동작 방지
            const targetUrl = $(this).data("href");

            Toast.fire({
            	icon: 'info',
                title: '로그인 페이지로 이동',
                timerProgressBar: true,
                didClose: () => {
                    window.location.href = targetUrl; // 페이지 이동
                }
            });
        });
    });
</script>

<script>
    function sortPosts(sortType) {
        let posts = document.querySelectorAll('.container'); // 모든 포스트를 선택

        // 포스트들을 배열로 변환하여 정렬
        let sortedPosts = Array.from(posts).sort((a, b) => {
            if (sortType === 'popular') {
                return parseInt(b.querySelector('.like_count').textContent) - parseInt(a.querySelector('.like_count').textContent);
            } else if (sortType === 'views') {
                return parseInt(b.querySelector('.post_views').textContent) - parseInt(a.querySelector('.post_views').textContent);
            } else {
                // 최신순 정렬
                let dateA = new Date(a.querySelector('.created_at').textContent);
                let dateB = new Date(b.querySelector('.created_at').textContent);
                return dateB - dateA;
            }
        });

        // 기존 포스트를 정렬된 순서로 다시 추가
        let container = document.querySelector('.con_wrap');
        container.innerHTML = ''; // 기존 내용을 지우고

        // 정렬된 포스트를 다시 추가
        sortedPosts.forEach(post => {
            container.appendChild(post);
        });
    }
</script>
<script>
function filterPosts(ottType) {
    console.log(`Selected OTT: ${ottType}`);
    
    // 선택한 ottType과 일치하는 포스트만 보이게 하기
    const posts = document.querySelectorAll('.container');
    
    posts.forEach(post => {
        if (post.getAttribute('data-ott') === ottType) {
            post.style.display = 'block'; // 일치하는 포스트는 보이기
        } else {
            post.style.display = 'none';  // 일치하지 않는 포스트는 숨기기
        }
    });
}

function filterPostsMovie(movietitle) {
    console.log(`Selected movietitle: ${movietitle}`);
    
    // 선택한 영화 제목과 일치하는 포스트만 보이게 하기
    const posts = document.querySelectorAll('.container');
    
    posts.forEach(post => {
        if (post.getAttribute('data-title') === movietitle) {
            post.style.display = 'block'; // 일치하는 포스트는 보이기
        } else {
            post.style.display = 'none';  // 일치하지 않는 포스트는 숨기기
        }
    });
}

function showAllPosts() {
    console.log("모든 포스트 보기");
    const posts = document.querySelectorAll('.container');
    
    posts.forEach(post => {
        post.style.display = 'block';  // 모든 포스트를 다시 보이기
    });
}
</script>
</body>

</html>