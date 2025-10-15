function openPopup(row) {
    // 예: 첫 번째 셀 값 가져오기
    // var rowId = row.cells[0].innerText;

    // 팝업 크기 설정
    var popupWidth = 900;
    var popupHeight = 600;

    // 화면 중앙 좌표 계산
    var left = (screen.width - popupWidth) / 2;
    var top = (screen.height - popupHeight) / 2;

    // 팝업창 열기
    window.open(
        "popup",
        "popup",
        "width=" + popupWidth +
        ",height=" + popupHeight +
        ",left=" + left +
        ",top=" + top +
        ",scrollbars=yes,resizable=yes,"+
        "toolbar=no,menubar=no,location=no,status=no"
    );
}

// 사이드바 보이기/숨기기
document.querySelector(".toggle-sidebar").addEventListener("click", () => {
    document.querySelector(".sidebar").classList.toggle("hidden");
});

// 추가 조회조건 접기/펼치기
//document.querySelector(".toggle-filters").addEventListener("click", (e) => {
//    const extra = document.querySelector(".extra-filters");
//    extra.style.display = extra.style.display === "none" ? "block" : "none";
//    e.target.textContent = extra.style.display === "none" ? "추가 조건 ▾" : "추가 조건 ▴";
//});

// 행 더블클릭 시 팝업 열기
document.querySelectorAll(".popup-col").forEach(cell => {
    cell.addEventListener("dblclick", () => {
        openPopup();
    });
});

// 큰 카테고리 클릭 이벤트
document.querySelectorAll(".menu-item > .title").forEach(title => {
    title.addEventListener("click", () => {
        document.querySelectorAll(".menu-item > .title").forEach(t => t.classList.remove("active"));
        title.classList.add("active");
    });
});

// 세부 카테고리 클릭 이벤트
document.querySelectorAll(".submenu div").forEach(item => {
    item.addEventListener("click", () => {
        document.querySelectorAll(".submenu div").forEach(i => i.classList.remove("active"));
        item.classList.add("active");
    });
});