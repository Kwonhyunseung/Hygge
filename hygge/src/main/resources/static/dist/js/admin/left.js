$(function(){
    // 메뉴 클릭시 서브메뉴 토글
    $(".menu-title").click(function(){
        const $menu = $(this).closest(".menu-item");
        const $subMenu = $(this).next(".sub-menu");
        
        // 다른 열린 메뉴 닫기
        $(".sub-menu").not($subMenu).slideUp(300);
        
        // 클릭된 메뉴 토글
        $subMenu.slideToggle(300);
    });

    // 현재 페이지 메뉴 활성화
    var url = window.location.pathname;
    $('.sub-menu a').each(function() {
        if (url.endsWith($(this).attr('href'))) {
            $(this).addClass('active');
            $(this).closest('.sub-menu').show();
        }
    });
});