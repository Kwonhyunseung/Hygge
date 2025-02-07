<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.tab-buttons {
    display: flex;
    gap: 10px;
}

.tab-button {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: #fff;
    border-radius: 4px;
    cursor: pointer;
}

.tab-button.active {
    background: #34495e;
    color: white;
    border-color: #34495e;
}

.tab-button:hover {
    background-color: #2ecc71;
}
</style>
<meta charset="UTF-8">
<title>중고게시판 관리</title>
<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<link rel="stylesheet" href="/dist/css/admin/usedBoard/usedList.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <header>
        <jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
    </header>

    <div class="admin-container">
        <jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>
        
        <div class="main-content">
        
            <div class="content-header">
                <h2>중고게시판 관리</h2>
                <span class="total-count">총 150개의 게시글</span>
	            <div class="tab-buttons">
	                <button class="tab-button" data-tab="reported">신고 누적</button>
	            </div>            
            </div>
            
            <div class="content-body">
                <div class="search-bar">
                    <select name="searchType">
                        <option value="title">제목</option>
                        <option value="writer">작성자</option>
                        <option value="content">내용</option>
                    </select>
                    <div class="search-wrapper">
                        <input type="text" placeholder="검색어를 입력하세요">
                        <button type="button">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>

			<div class="board-container">
			    <table>
			        <thead>
			            <tr>
			                <th><input type="checkbox" id="checkAll"></th>
			                <th>번호</th>
			                <th>제목</th>
			                <th>작성자</th>
			                <th>상태</th>
			                <th>등록일</th>
			                <th>조회수</th>
			                <th>관리</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="1"></td>
			                <td>15</td>
			                <td>아이폰 14 Pro 팝니다 (상태 A급)</td>
			                <td>애플매니아</td>
			                <td><span class="status-badge status-selling">판매중</span></td>
			                <td>2024-02-07</td>
			                <td>245</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="2"></td>
			                <td>14</td>
			                <td>갤럭시 S23 Ultra 판매합니다 (풀박)</td>
			                <td>폰마스터</td>
			                <td><span class="status-badge status-reserved">예약중</span></td>
			                <td>2024-02-07</td>
			                <td>188</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="3"></td>
			                <td>13</td>
			                <td>맥북 프로 M2 팝니다 (애케플 포함)</td>
			                <td>맥러버</td>
			                <td><span class="status-badge status-completed">판매완료</span></td>
			                <td>2024-02-06</td>
			                <td>324</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="4"></td>
			                <td>12</td>
			                <td>아이패드 프로 5세대 (M2) + 매직키보드</td>
			                <td>태블릿매니아</td>
			                <td><span class="status-badge status-selling">판매중</span></td>
			                <td>2024-02-06</td>
			                <td>156</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="5"></td>
			                <td>11</td>
			                <td>에어팟 프로 2세대 (미개봉)</td>
			                <td>사운드러버</td>
			                <td><span class="status-badge status-reserved">예약중</span></td>
			                <td>2024-02-06</td>
			                <td>142</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="6"></td>
			                <td>10</td>
			                <td>갤럭시 워치 6 클래식 (실버)</td>
			                <td>시계매니아</td>
			                <td><span class="status-badge status-completed">판매완료</span></td>
			                <td>2024-02-05</td>
			                <td>98</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="7"></td>
			                <td>9</td>
			                <td>레노버 게이밍 노트북 (RTX 4060)</td>
			                <td>게이머킹</td>
			                <td><span class="status-badge status-selling">판매중</span></td>
			                <td>2024-02-05</td>
			                <td>267</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="8"></td>
			                <td>8</td>
			                <td>삼성 게이밍 모니터 오디세이 G7</td>
			                <td>모니터장인</td>
			                <td><span class="status-badge status-selling">판매중</span></td>
			                <td>2024-02-05</td>
			                <td>178</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="9"></td>
			                <td>7</td>
			                <td>LG 그램 2024년형 신제품</td>
			                <td>노트북매니아</td>
			                <td><span class="status-badge status-completed">판매완료</span></td>
			                <td>2024-02-04</td>
			                <td>412</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			            <tr>
			                <td><input type="checkbox" name="selectedItems" value="10"></td>
			                <td>6</td>
			                <td>소니 WH-1000XM5 헤드폰</td>
			                <td>음질장인</td>
			                <td><span class="status-badge status-selling">판매중</span></td>
			                <td>2024-02-04</td>
			                <td>167</td>
			                <td class="action-buttons">
			                    <button type="button"><i class="fas fa-eye"></i></button>
			                    <button type="button"><i class="fas fa-edit"></i></button>
			                    <button type="button"><i class="fas fa-trash"></i></button>
			                </td>
			            </tr>
			        </tbody>
			    </table>
			</div>

				<div class="content-footer">
				    <div class="button-group">
				        <button type="button">선택 삭제</button>
				        <button type="button">선택 숨김</button>
				    </div>
				    <div class="pagination">
				        <a href="#" class="prev">&lt;</a>
				        <a href="#" class="active">1</a>
				        <a href="#">2</a>
				        <a href="#">3</a>
				        <a href="#">4</a>
				        <a href="#">5</a>
				        <a href="#" class="next">&gt;</a>
				    </div>
				</div>
            </div>
        </div>
    </div>
</body>
</html>