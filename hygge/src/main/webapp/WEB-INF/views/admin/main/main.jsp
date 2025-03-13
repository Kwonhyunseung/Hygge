<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지</title>

<jsp:include page="/WEB-INF/views/admin/layout/headerResources.jsp"/>
<!-- Chart.js 라이브러리 추가 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
<!-- Font Awesome 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
<style>
  /* 메인 컨텐츠 영역 조정 */
  .main-content {
    margin-left: 250px; /* 사이드바 너비만큼 여백 */
    padding: 80px 30px 30px; /* 패딩 증가 */
    background-color: #f5f7fa;
    min-height: 100vh;
    max-width: calc(100% - 250px); /* 사이드바를 제외한 전체 너비 */
    box-sizing: border-box; /* 패딩을 너비에 포함 */
  }

  /* 컨테이너 스타일 수정 */
  .container {
    display: flex;
    width: 100%;
    max-width: 100%;
  }
  
  .main-content h2 {
    margin-top: 0;
    margin-bottom: 20px;
    color: #2c3e50;
    font-size: 1.8rem;
  }
  
  .chart-container {
    width: 100%;
    margin-bottom: 30px;
  }
  
  .chart-row {
    display: flex;
    flex-wrap: nowrap; /* 가로로 펼쳐지도록 변경 */
    gap: 20px;
    margin-bottom: 30px;
    width: 100%;
    overflow-x: auto; /* 필요시 가로 스크롤 제공 */
  }
  
  .chart-box {
    flex: 1 0 450px; /* 더 넓은 기본 너비 설정, 0은 축소 불가능 */
    max-width: 50%; /* 최대 너비 제한 */
    min-height: 350px; /* 최소 높이 설정 */
    height: 350px; /* 고정 높이 설정 */
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    padding: 20px;
    border-top: 3px solid #3498db; /* 상단 액센트 컬러 */
    position: relative; /* 포지션 상대값 설정 */
    overflow: hidden; /* 내용이 넘치면 숨김 */
  }
  
  .chart-box h3 {
    margin-top: 0;
    margin-bottom: 15px;
    color: #2c3e50;
    font-size: 1.2rem;
    font-weight: 600;
  }
  
  .stat-cards {
    display: flex;
    flex-wrap: nowrap; /* 가로로 펼치기 */
    gap: 15px;
    margin-bottom: 30px;
    width: 100%;
    overflow-x: auto; /* 필요시 스크롤 */
  }
  
  .stat-card {
    flex: 1;
    min-width: 200px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    padding: 20px;
    text-align: center;
    border-left: 4px solid #3498db; /* 왼쪽 액센트 컬러 */
    transition: transform 0.2s ease;
  }
  
  .stat-card:hover {
    transform: translateY(-5px);
  }
  
  .stat-card:nth-child(1) {
    border-left-color: #3498db; /* 파란색 */
  }
  
  .stat-card:nth-child(2) {
    border-left-color: #2ecc71; /* 녹색 */
  }
  
  .stat-card:nth-child(3) {
    border-left-color: #f39c12; /* 주황색 */
  }
  
  .stat-card:nth-child(4) {
    border-left-color: #9b59b6; /* 보라색 */
  }
  
  .stat-card h3 {
    margin-top: 0;
    color: #7f8c8d;
    font-size: 0.95rem;
    font-weight: 500;
  }
  
  .stat-card .value {
    font-size: 2rem;
    font-weight: bold;
    color: #2c3e50;
    margin: 10px 0;
  }
  
  .stat-card .change {
    font-size: 0.9rem;
    color: #2ecc71;
    background-color: rgba(46, 204, 113, 0.1);
    padding: 3px 8px;
    border-radius: 12px;
    display: inline-block;
  }
  
  .stat-card .change.negative {
    color: #e74c3c;
    background-color: rgba(231, 76, 60, 0.1);
  }
  
  /* 모바일 반응형 조정 */
  @media (max-width: 768px) {
    .main-content {
      margin-left: 0;
      padding-top: 70px;
    }
    
    .stat-card {
      min-width: 100%;
    }
    
    .chart-box {
      min-width: 100%;
    }
  }
</style>
</head>
<body>

<header>
<jsp:include page="/WEB-INF/views/admin/layout/header.jsp"/>
</header>

<div class="container">
<jsp:include page="/WEB-INF/views/admin/layout/left.jsp"/>

<div class="main-content">
  <!-- 대시보드 메인 컨텐츠 -->
  <h2><i class="fas fa-chart-line" style="margin-right: 10px;"></i>펀딩 대시보드</h2>
  
  <!-- 주요 통계 카드 -->
  <div class="stat-cards">
    <div class="stat-card">
      <h3><i class="fas fa-won-sign"></i> 오늘 매출</h3>
      <div class="value">₩278900</div>
      <div class="change"><i class="fas fa-arrow-up"></i> +12.5% 어제 대비</div>
    </div>
    <div class="stat-card">
      <h3><i class="fas fa-calendar-alt"></i> 이번 달 총 매출</h3>
      <div class="value">₩1700000</div>
      <div class="change"><i class="fas fa-arrow-up"></i> +8.3% 전월 대비</div>
    </div>
    <div class="stat-card">
      <h3><i class="fas fa-users"></i> 오늘 방문자</h3>
      <div class="value">21</div>
      <div class="change negative"><i class="fas fa-arrow-down"></i> -3.2% 어제 대비</div>
    </div>
    <div class="stat-card">
      <h3><i class="fas fa-project-diagram"></i> 신규 프로젝트</h3>
      <div class="value">12</div>
      <div class="change"><i class="fas fa-plus"></i> +4 이번 주</div>
    </div>
  </div>
  
  <!-- 첫 번째 차트 행 -->
  <div class="chart-row">
    <div class="chart-box">
      <h3><i class="fas fa-chart-line"></i> 일일 매출 (최근 7일)</h3>
      <canvas id="dailySalesChart"></canvas>
    </div>
    <div class="chart-box">
      <h3><i class="fas fa-chart-bar"></i> 월간 매출 (최근 6개월)</h3>
      <canvas id="monthlySalesChart"></canvas>
    </div>
  </div>
  
  <!-- 두 번째 차트 행 -->
  <div class="chart-row">
    <div class="chart-box">
      <h3><i class="fas fa-user-clock"></i> 일일 방문자 수 (최근 7일)</h3>
      <canvas id="dailyVisitorsChart"></canvas>
    </div>
    <div class="chart-box">
      <h3><i class="fas fa-chart-pie"></i> 카테고리별 펀딩 비율</h3>
      <canvas id="categorySalesChart"></canvas>
    </div>
  </div>
  
  <!-- 세 번째 차트 행 -->
  <div class="chart-row">
    <div class="chart-box">
      <h3><i class="fas fa-trophy"></i> 목표 달성률 상위 프로젝트</h3>
      <canvas id="topProjectsChart"></canvas>
    </div>
    <div class="chart-box">
      <h3><i class="fas fa-user-plus"></i> 일일 신규 사용자 등록</h3>
      <canvas id="newUsersChart"></canvas>
    </div>
  </div>
</div>
</div>

<footer>
<jsp:include page="/WEB-INF/views/admin/layout/footer.jsp"/>
</footer>

<script>
  // 차트 데이터 및 옵션 설정
  document.addEventListener('DOMContentLoaded', function() {
    // 차트 캔버스 크기 조정을 위한 함수
    function adjustChartCanvas() {
      const chartBoxes = document.querySelectorAll('.chart-box');
      chartBoxes.forEach(box => {
        const canvas = box.querySelector('canvas');
        if (canvas) {
          // 모든 차트의 캔버스 높이를 통일
          canvas.style.height = '250px';
          canvas.style.maxHeight = '250px';
          canvas.style.width = '100%';
        }
      });
    }
    
    // 페이지 로드 시 차트 캔버스 크기 조정
    adjustChartCanvas();
    
    // 창 크기 변경 시 차트 캔버스 크기 재조정
    window.addEventListener('resize', adjustChartCanvas);
    
    // 모든 차트에 공통 설정 적용
    const chartOptions = {
      // 모든 차트에 적용할 공통 옵션
      responsive: true,
      maintainAspectRatio: true,
      aspectRatio: 2.5,
      plugins: {
        legend: {
          display: false
        },
        tooltip: {
          backgroundColor: 'rgba(44, 62, 80, 0.9)',
          titleColor: '#ecf0f1',
          bodyColor: '#ecf0f1',
          borderColor: '#34495e',
          borderWidth: 1,
          padding: 10
        }
      },
      scales: {
        y: {
          grid: {
            color: 'rgba(0, 0, 0, 0.05)',
            drawBorder: false
          },
          ticks: {
            font: {
              size: 11
            }
          }
        },
        x: {
          grid: {
            display: false
          },
          ticks: {
            font: {
              size: 11
            }
          }
        }
      }
    };
    let resizeTimeout;
    const handleResize = () => {
      clearTimeout(resizeTimeout);
      resizeTimeout = setTimeout(() => {
        document.querySelectorAll('.chart-box canvas').forEach(canvas => {
          const chart = Chart.getChart(canvas);
          if (chart) {
            chart.resize();
          }
        });
      }, 100);
    };
    
    // 윈도우 리사이즈 이벤트에 핸들러 연결
    window.addEventListener('resize', handleResize);
    
    // 초기 차트 조정 (한 번만 실행)
    setTimeout(() => {
      adjustChartCanvas();
    }, 500);
    // 일일 매출 차트
    const dailySalesCtx = document.getElementById('dailySalesChart').getContext('2d');
    const dailySalesChart = new Chart(dailySalesCtx, {
      type: 'line',
      data: {
        labels: ['6일 전', '5일 전', '4일 전', '3일 전', '2일 전', '어제', '오늘'],
        datasets: [{
          label: '일일 매출 (원)',
          data: [980000, 1150000, 920000, 1050000, 1120000, 1105000, 1245000],
          borderColor: '#4e73df',
          backgroundColor: 'rgba(78, 115, 223, 0.05)',
          tension: 0.3,
          fill: true,
          pointRadius: 4,
          pointBackgroundColor: '#4e73df'
        }]
      },
      options: {
        ...chartOptions, // 공통 옵션 적용
        scales: {
          ...chartOptions.scales,
          y: {
            ...chartOptions.scales.y,
            beginAtZero: false,
            ticks: {
              ...chartOptions.scales.y.ticks,
              callback: function(value) {
                return '₩' + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
              },
              color: '#7f8c8d',
              maxTicksLimit: 5
            }
          }
        }
      }
    });
    
    // 월간 매출 차트
    const monthlySalesCtx = document.getElementById('monthlySalesChart').getContext('2d');
    const monthlySalesChart = new Chart(monthlySalesCtx, {
      type: 'bar',
      data: {
        labels: ['10월', '11월', '12월', '1월', '2월', '3월'],
        datasets: [{
          label: '월별 매출 (원)',
          data: [24500000, 27800000, 30200000, 26500000, 29800000, 32450000],
          backgroundColor: '#36b9cc',
          borderRadius: 5
        }]
      },
      options: {
        ...chartOptions, // 공통 옵션 적용
        scales: {
          ...chartOptions.scales,
          y: {
            ...chartOptions.scales.y,
            beginAtZero: false,
            ticks: {
              ...chartOptions.scales.y.ticks,
              callback: function(value) {
                return '₩' + (value/1000000).toFixed(1) + 'M';
              },
              color: '#7f8c8d'
            }
          }
        }
      }
    });
    
    // 일일 방문자 차트
    const dailyVisitorsCtx = document.getElementById('dailyVisitorsChart').getContext('2d');
    const dailyVisitorsChart = new Chart(dailyVisitorsCtx, {
      type: 'line',
      data: {
        labels: ['6일 전', '5일 전', '4일 전', '3일 전', '2일 전', '어제', '오늘'],
        datasets: [{
          label: '방문자 수',
          data: [1645, 1820, 1750, 1930, 2050, 1940, 1876],
          borderColor: '#1cc88a',
          backgroundColor: 'rgba(28, 200, 138, 0.05)',
          tension: 0.3,
          fill: true
        }]
      },
      options: {
        ...chartOptions // 공통 옵션 적용
      }
    });
    
    // 카테고리 차트
    const categorySalesCtx = document.getElementById('categorySalesChart').getContext('2d');
    const categorySalesChart = new Chart(categorySalesCtx, {
      type: 'doughnut',
      data: {
        labels: ['테크/가전', '패션/의류', '푸드', '공연/전시', '게임', '기타'],
        datasets: [{
          data: [35, 25, 20, 10, 5, 5],
          backgroundColor: [
            '#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b', '#858796'
          ]
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: true,
        plugins: {
          legend: {
            position: 'right',
            labels: {
              boxWidth: 12,
              padding: 15,
              font: {
                size: 11
              }
            }
          },
          tooltip: chartOptions.plugins.tooltip
        },
        cutout: '70%'
      }
    });
    
    // 상위 프로젝트 차트
    const topProjectsCtx = document.getElementById('topProjectsChart').getContext('2d');
    const topProjectsChart = new Chart(topProjectsCtx, {
      type: 'bar',
      data: {
        labels: ['스마트 홈 시스템', '친환경 백팩', '수제 초콜릿 세트', 'VR 게임', '디자인 램프'],
        datasets: [{
          axis: 'y',
          label: '목표 달성률 (%)',
          data: [245, 187, 176, 165, 152],
          backgroundColor: [
            '#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#e74a3b'
          ],
          borderRadius: 5
        }]
      },
      options: {
        ...chartOptions,
        indexAxis: 'y',
        scales: {
          ...chartOptions.scales,
          x: {
            ...chartOptions.scales.x,
            beginAtZero: true,
            max: 300
          }
        }
      }
    });
    
    // 신규 사용자 등록 차트
    const newUsersCtx = document.getElementById('newUsersChart').getContext('2d');
    const newUsersChart = new Chart(newUsersCtx, {
      type: 'line',
      data: {
        labels: ['6일 전', '5일 전', '4일 전', '3일 전', '2일 전', '어제', '오늘'],
        datasets: [{
          label: '신규 사용자',
          data: [58, 65, 72, 68, 74, 82, 76],
          borderColor: '#e74a3b',
          backgroundColor: 'rgba(231, 74, 59, 0.05)',
          tension: 0.3,
          fill: true
        }]
      },
      options: {
        ...chartOptions
      }
    });
  });
</script>

</body>
</html>