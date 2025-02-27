// 이용약관
document.addEventListener("DOMContentLoaded", function () {
    const agreeAll = document.getElementById("agreeAll");
    const checkboxes = document.querySelectorAll(".terms input[type='checkbox']");
    const requiredCheckboxes = document.querySelectorAll(".terms input[type='checkbox'][required]");
    const accountBtn = document.getElementById("accountBtn");

    // 전체 동의 체크박스 클릭 시
    agreeAll.addEventListener("change", function () {
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;  // 전체 동의 시 모든 체크박스 선택/해제
        });
        updateAcountBtn();  // 가입 버튼 상태 업데이트
    });

    // 개별 체크박스 변경 시
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener("change", function () {
            updateAgreeAll();  // '전체 동의' 체크박스 상태 업데이트
            updateAcountBtn();
        });
    });

    // 전체 동의 체크박스 상태 업데이트
    function updateAgreeAll() {
        const allChecked = [...checkboxes].every(cb => cb.checked);  // 모든 체크박스가 체크되었는지 확인
        agreeAll.checked = allChecked;
    }

    // 필수 항목 체크 여부 확인하여 가입 버튼 활성화
    function updateAcountBtn() {
        const requiredChecked = [...requiredCheckboxes].every(cb => cb.checked);  // 필수 항목 체크 확인
        accountBtn.disabled = !requiredChecked;  // 필수 항목만 체크해도 가입 버튼 활성화
    }

    updateAcountBtn();  // 초기 상태 확인
});