document.addEventListener('DOMContentLoaded', function() {
    const moreMenuBtn = document.getElementById('moreMenuBtn');
    const moreMenuContainer = document.querySelector('.more-menu-container');

    if (moreMenuBtn && moreMenuContainer) {
        // 더보기 버튼 클릭 이벤트
        moreMenuBtn.addEventListener('click', function(e) {
            e.preventDefault();  // 기본 동작 방지
            e.stopPropagation(); // 이벤트 전파 중지
            
            // 토글 전 현재 상태 확인
            const isDisplayed = moreMenuContainer.style.display === 'block';
            
            // 상태에 따라 표시/숨김 처리
            moreMenuContainer.style.display = isDisplayed ? 'none' : 'block';
        });

        // 외부 클릭시 메뉴 닫기
        document.addEventListener('click', function(e) {
            if (!moreMenuBtn.contains(e.target) && !moreMenuContainer.contains(e.target)) {
                moreMenuContainer.style.display = 'none';
            }
        });
    }
});