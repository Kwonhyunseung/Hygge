<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>프로젝트 관리 모달</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f8f9fa;
    }
    
    .modal-xl {
      max-width: 1140px;
    }
    
    .nav-tabs .nav-link.active {
      font-weight: 600;
      border-bottom: 2px solid #0d6efd;
    }
    
    .reward-card {
      border: 1px solid #dee2e6;
      border-radius: 5px;
      padding: 15px;
      margin-bottom: 15px;
    }
    
    .reward-actions {
      display: flex;
      gap: 10px;
    }
    
    .btn-circle {
      width: 30px;
      height: 30px;
      padding: 0;
      border-radius: 15px;
      text-align: center;
      font-size: 12px;
      line-height: 1.42857;
    }
    
    .add-reward-btn {
      cursor: pointer;
      border: 1px dashed #dee2e6;
      border-radius: 5px;
      padding: 15px;
      margin-bottom: 15px;
      text-align: center;
      background-color: #f8f9fa;
    }
    
    .add-reward-btn:hover {
      background-color: #e9ecef;
    }
    
    .form-label {
      font-weight: 500;
    }
    
    .form-group {
      margin-bottom: 1rem;
    }
    
    .business-info {
      background-color: #f8f9fa;
      padding: 15px;
      border-radius: 5px;
      margin-bottom: 15px;
    }
    
    #saveChanges {
      min-width: 120px;
    }
  </style>
</head>
<body>
<!-- 모달 시작 -->
<div class="modal fade" id="projectManagementModal" tabindex="-1" aria-labelledby="projectManagementModalLabel">    <div class="modal-dialog modal-xl modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header bg-light">
          <h5 class="modal-title" id="projectManagementModalLabel">프로젝트 관리</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <ul class="nav nav-tabs mb-4" id="projectTab" role="tablist">
            <li class="nav-item" role="presentation">
              <button class="nav-link active" id="basic-tab" data-bs-toggle="tab" data-bs-target="#basic" type="button" role="tab" aria-controls="basic" aria-selected="true">기본 정보</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="reward-tab" data-bs-toggle="tab" data-bs-target="#reward" type="button" role="tab" aria-controls="reward" aria-selected="false">리워드 관리</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="business-tab" data-bs-toggle="tab" data-bs-target="#business" type="button" role="tab" aria-controls="business" aria-selected="false">사업자 정보</button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="shipping-tab" data-bs-toggle="tab" data-bs-target="#shipping" type="button" role="tab" aria-controls="shipping" aria-selected="false">배송 정보</button>
            </li>
          </ul>
          
          <%-- 탭 컨텐츠 삭제하면 보임 tab-content --%>
          <div class="" id="projectTabContent">
            <!-- 기본 정보 탭 -->
            <div class="tab-pane fade show active" id="basic" role="tabpanel" aria-labelledby="basic-tab">
              <form id="basicInfoForm">
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label for="projectTitle" class="form-label">프로젝트 제목</label>
                      <input type="text" class="form-control" id="projectTitle" value="스마트 LED 조명: 취향에 맞게 색상과 밝기 조절이 가능한 홈 인테리어 조명">
                    </div>
                    
                    <div class="form-group mb-3">
                      <label for="projectSummary" class="form-label">프로젝트 요약</label>
                      <textarea class="form-control" id="projectSummary" rows="3">당신의 공간에 분위기를 더해주는 스마트 LED 조명입니다. 앱을 통해 색상, 밝기를 조절할 수 있으며 다양한 모드를 지원합니다.</textarea>
                    </div>
                  </div>
                  
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label for="fundingGoal" class="form-label">펀딩 목표액</label>
                      <div class="input-group">
                        <input type="number" class="form-control" id="fundingGoal" value="5000000">
                        <span class="input-group-text">원</span>
                      </div>
                    </div>
                    
                    <div class="form-group mb-3">
                      <label for="fundingPeriod" class="form-label">펀딩 기간</label>
                      <div class="row">
                        <div class="col">
                          <input type="date" class="form-control" id="fundingStartDate" value="2024-03-01">
                        </div>
                        <div class="col-auto">
                          <span class="pt-2">~</span>
                        </div>
                        <div class="col">
                          <input type="date" class="form-control" id="fundingEndDate" value="2024-04-30">
                        </div>
                      </div>
                    </div>
                    
                    <div class="form-group mb-3">
                      <label for="fundingDays" class="form-label">펀딩 일수</label>
                      <div class="input-group">
                        <input type="number" class="form-control" id="fundingDays" value="60">
                        <span class="input-group-text">일</span>
                      </div>
                    </div>
                  </div>
                </div>
              </form>
            </div>
            
            <!-- 리워드 관리 탭 -->
            <div class="tab-pane fade" id="reward" role="tabpanel" aria-labelledby="reward-tab">
              <div id="rewardList">
                <!-- 리워드 1 -->
                <div class="reward-card" data-reward-id="1">
                  <div class="row">
                    <div class="col-md-8">
                      <div class="form-group mb-3">
                        <label class="form-label">리워드 제목</label>
                        <input type="text" class="form-control" value="[얼리버드] 스마트 LED 조명 1개">
                      </div>
                      <div class="form-group mb-3">
                        <label class="form-label">리워드 설명</label>
                        <textarea class="form-control" rows="2">정가 59,000원 → 35% 할인된 가격으로 스마트 LED 조명 1개를 제공합니다. 색상 선택 가능합니다.</textarea>
                      </div>
                    </div>
                    <div class="col-md-3">
                      <div class="form-group mb-3">
                        <label class="form-label">가격</label>
                        <div class="input-group">
                          <input type="number" class="form-control" value="38000">
                          <span class="input-group-text">원</span>
                        </div>
                      </div>
                      <div class="form-group mb-3">
                        <label class="form-label">제한 수량</label>
                        <div class="input-group">
                          <input type="number" class="form-control" value="100">
                          <span class="input-group-text">개</span>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-1 d-flex align-items-center justify-content-center">
                      <button class="btn btn-danger btn-circle deleteReward"><i class="fas fa-times">X</i></button>
                    </div>
                  </div>
                </div>
                
                <!-- 리워드 2 -->
                <div class="reward-card" data-reward-id="2">
                  <div class="row">
                    <div class="col-md-8">
                      <div class="form-group mb-3">
                        <label class="form-label">리워드 제목</label>
                        <input type="text" class="form-control" value="[일반] 스마트 LED 조명 1개">
                      </div>
                      <div class="form-group mb-3">
                        <label class="form-label">리워드 설명</label>
                        <textarea class="form-control" rows="2">정가 59,000원 → 20% 할인된 가격으로 스마트 LED 조명 1개를 제공합니다. 색상 선택 가능합니다.</textarea>
                      </div>
                    </div>
                    <div class="col-md-3">
                      <div class="form-group mb-3">
                        <label class="form-label">가격</label>
                        <div class="input-group">
                          <input type="number" class="form-control" value="47000">
                          <span class="input-group-text">원</span>
                        </div>
                      </div>
                      <div class="form-group mb-3">
                        <label class="form-label">제한 수량</label>
                        <div class="input-group">
                          <input type="number" class="form-control" value="200">
                          <span class="input-group-text">개</span>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-1 d-flex align-items-center justify-content-center">
                      <button class="btn btn-danger btn-circle deleteReward"><i class="fas fa-times">X</i></button>
                    </div>
                  </div>
                </div>
                
                <!-- 리워드 3 -->
                <div class="reward-card" data-reward-id="3">
                  <div class="row">
                    <div class="col-md-8">
                      <div class="form-group mb-3">
                        <label class="form-label">리워드 제목</label>
                        <input type="text" class="form-control" value="[패밀리] 스마트 LED 조명 3개 세트">
                      </div>
                      <div class="form-group mb-3">
                        <label class="form-label">리워드 설명</label>
                        <textarea class="form-control" rows="2">정가 177,000원 → 30% 할인된 가격으로 스마트 LED 조명 3개를 제공합니다. 각각 다른 색상 선택 가능합니다.</textarea>
                      </div>
                    </div>
                    <div class="col-md-3">
                      <div class="form-group mb-3">
                        <label class="form-label">가격</label>
                        <div class="input-group">
                          <input type="number" class="form-control" value="123900">
                          <span class="input-group-text">원</span>
                        </div>
                      </div>
                      <div class="form-group mb-3">
                        <label class="form-label">제한 수량</label>
                        <div class="input-group">
                          <input type="number" class="form-control" value="50">
                          <span class="input-group-text">개</span>
                        </div>
                      </div>
                    </div>
                    <div class="col-md-1 d-flex align-items-center justify-content-center">
                      <button class="btn btn-danger btn-circle deleteReward"><i class="fas fa-times">X</i></button>
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- 리워드 추가 버튼 -->
              <div class="add-reward-btn" id="addReward">
                <i class="fas fa-plus"></i> 새 리워드 추가
              </div>
            </div>
            
            <!-- 사업자 정보 탭 -->
            <div class="tab-pane fade" id="business" role="tabpanel" aria-labelledby="business-tab">
              <div class="business-info">
                <p><strong>현재 사업자 상태:</strong> <span class="badge bg-warning">개인 판매자</span></p>
                <p>사업자 등록 정보를 추가하면 프로젝트 신뢰도가 올라갑니다.</p>
              </div>
              
              <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" id="hasBusinessLicense">
                <label class="form-check-label" for="hasBusinessLicense">
                  사업자 등록 정보가 있습니다.
                </label>
              </div>
              
              <div id="businessInfoSection" style="display: none;">
                <div class="row">
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label for="businessName" class="form-label">상호명</label>
                      <input type="text" class="form-control" id="businessName">
                    </div>
                    
                    <div class="form-group mb-3">
                      <label for="businessNumber" class="form-label">사업자 등록 번호</label>
                      <input type="text" class="form-control" id="businessNumber" placeholder="000-00-00000">
                    </div>
                  </div>
                  
                  <div class="col-md-6">
                    <div class="form-group mb-3">
                      <label for="businessAddress" class="form-label">사업장 주소</label>
                      <input type="text" class="form-control mb-2" id="businessAddress" placeholder="주소">
                      <input type="text" class="form-control" id="businessAddressDetail" placeholder="상세 주소">
                    </div>
                    
                    <div class="form-group mb-3">
                      <label for="businessLicenseFile" class="form-label">사업자 등록증 파일</label>
                      <input type="file" class="form-control" id="businessLicenseFile">
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- 배송 정보 탭 -->
            <div class="tab-pane fade" id="shipping" role="tabpanel" aria-labelledby="shipping-tab">
              <div class="row">
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label for="shippingMethod" class="form-label">배송 방법</label>
                    <select class="form-select" id="shippingMethod">
                      <option value="domestic">국내 배송</option>
                      <option value="international">국내 및 해외 배송</option>
                    </select>
                  </div>
                  
                  <div class="form-group mb-3">
                    <label for="shippingFee" class="form-label">배송비</label>
                    <div class="input-group">
                      <input type="number" class="form-control" id="shippingFee" value="3000">
                      <span class="input-group-text">원</span>
                    </div>
                  </div>
                </div>
                
                <div class="col-md-6">
                  <div class="form-group mb-3">
                    <label for="estimatedDeliveryDate" class="form-label">예상 배송 시작일</label>
                    <input type="date" class="form-control" id="estimatedDeliveryDate" value="2024-05-15">
                  </div>
                  
                  <div class="form-group mb-3 mt-4">
                    <div class="form-check">
                      <input class="form-check-input" type="checkbox" id="freeShippingOption">
                      <label class="form-check-label" for="freeShippingOption">
                        특정 금액 이상 주문 시 무료 배송 설정
                      </label>
                    </div>
                  </div>
                  
                  <div id="freeShippingSection" style="display: none;">
                    <div class="form-group mb-3">
                      <label for="freeShippingAmount" class="form-label">무료 배송 기준 금액</label>
                      <div class="input-group">
                        <input type="number" class="form-control" id="freeShippingAmount" value="50000">
                        <span class="input-group-text">원 이상</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
          <button type="button" class="btn btn-primary" id="saveChanges">저장하기</button>
        </div>
      </div>
    </div>
  </div>
  
  <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
  <script>
    // 사업자 등록 정보 표시/숨김 처리
    document.getElementById('hasBusinessLicense').addEventListener('change', function() {
      const businessInfoSection = document.getElementById('businessInfoSection');
      businessInfoSection.style.display = this.checked ? 'block' : 'none';
    });
    
    // 무료 배송 설정 표시/숨김 처리
    document.getElementById('freeShippingOption').addEventListener('change', function() {
      const freeShippingSection = document.getElementById('freeShippingSection');
      freeShippingSection.style.display = this.checked ? 'block' : 'none';
    });
    
    // 리워드 삭제 기능
    document.querySelectorAll('.deleteReward').forEach(button => {
      button.addEventListener('click', function() {
        if (confirm('이 리워드를 삭제하시겠습니까?')) {
          this.closest('.reward-card').remove();
        }
      });
    });
    
    // 리워드 추가 기능
    document.getElementById('addReward').addEventListener('click', function() {
      const rewardList = document.getElementById('rewardList');
      const newRewardId = Date.now(); // 고유 ID 생성
      
      const newRewardHTML = `
        <div class="reward-card" data-reward-id="${newRewardId}">
          <div class="row">
            <div class="col-md-8">
              <div class="form-group mb-3">
                <label class="form-label">리워드 제목</label>
                <input type="text" class="form-control" value="새 리워드">
              </div>
              <div class="form-group mb-3">
                <label class="form-label">리워드 설명</label>
                <textarea class="form-control" rows="2">리워드에 대한 설명을 입력하세요.</textarea>
              </div>
            </div>
            <div class="col-md-3">
              <div class="form-group mb-3">
                <label class="form-label">가격</label>
                <div class="input-group">
                  <input type="number" class="form-control" value="0">
                  <span class="input-group-text">원</span>
                </div>
              </div>
              <div class="form-group mb-3">
                <label class="form-label">제한 수량</label>
                <div class="input-group">
                  <input type="number" class="form-control" value="0">
                  <span class="input-group-text">개</span>
                </div>
              </div>
            </div>
            <div class="col-md-1 d-flex align-items-center justify-content-center">
              <button class="btn btn-danger btn-circle deleteReward"><i class="fas fa-times">X</i></button>
            </div>
          </div>
        </div>
      `;
      
      // 리워드 추가 버튼 위에 새 리워드 요소 삽입
      rewardList.insertAdjacentHTML('beforeend', newRewardHTML);
      
      // 새로 추가된 리워드의 삭제 버튼에 이벤트 리스너 추가
      const newRewardDeleteBtn = rewardList.querySelector(`[data-reward-id="${newRewardId}"] .deleteReward`);
      newRewardDeleteBtn.addEventListener('click', function() {
        if (confirm('이 리워드를 삭제하시겠습니까?')) {
          this.closest('.reward-card').remove();
        }
      });
    });
    
    // 저장 버튼 클릭 시 처리
    document.getElementById('saveChanges').addEventListener('click', function() {
      alert('프로젝트 정보가 성공적으로 저장되었습니다.');
      // 실제로는 여기에 AJAX 요청으로 서버에 데이터를 전송하는 코드가 들어갑니다.
    });
    
    // 펀딩 기간 변경 시 펀딩 일수 자동 계산
    function updateFundingDays() {
      const startDate = new Date(document.getElementById('fundingStartDate').value);
      const endDate = new Date(document.getElementById('fundingEndDate').value);
      
      if (!isNaN(startDate.getTime()) && !isNaN(endDate.getTime())) {
        const diffTime = Math.abs(endDate - startDate);
        const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1; // +1 to include both start and end days
        document.getElementById('fundingDays').value = diffDays;
      }
    }
    
    // 날짜 입력 필드에 이벤트 리스너 추가
    document.getElementById('fundingStartDate').addEventListener('change', updateFundingDays);
    document.getElementById('fundingEndDate').addEventListener('change', updateFundingDays);
    
    // 모달 닫기 기능
    document.querySelector('.btn-close').addEventListener('click', function() {
      document.getElementById('projectManagementModal').style.display = 'none';
    });
    
    document.querySelector('[data-bs-dismiss="modal"]').addEventListener('click', function() {
      document.getElementById('projectManagementModal').style.display = 'none';
    });
  </script>

</body>
</html>