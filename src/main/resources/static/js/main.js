/**
 * CERTAIN SHOP - Main JavaScript
 * Tiện ích dùng chung cho giao diện khách hàng
 */

// ========================
// Tiện ích chung
// ========================

/**
 * Lấy CSRF token từ meta tag hoặc cookie
 */
function getCsrfToken() {
    const meta = document.querySelector('meta[name="_csrf"]');
    if (meta) return meta.content;
    // Fallback từ cookie
    const cookies = document.cookie.split('; ');
    const xsrf = cookies.find(c => c.startsWith('XSRF-TOKEN='));
    return xsrf ? decodeURIComponent(xsrf.split('=')[1]) : '';
}

/**
 * Hiển thị Toast thông báo
 * @param {string} noiDung - Nội dung thông báo
 * @param {string} loai - 'success' | 'danger' | 'warning' | 'info'
 */
function hienThiThongBao(noiDung, loai = 'success') {
    const icon = { success: 'bi-check-circle', danger: 'bi-x-circle', warning: 'bi-exclamation-triangle', info: 'bi-info-circle' }[loai] || 'bi-info-circle';
    const div = document.createElement('div');
    div.className = 'toast-container position-fixed bottom-0 end-0 p-3';
    div.style.zIndex = '9999';
    div.innerHTML = `
        <div class="toast show align-items-center text-bg-${loai} border-0 shadow" role="alert">
            <div class="d-flex">
                <div class="toast-body d-flex align-items-center gap-2">
                    <i class="bi ${icon}"></i> ${noiDung}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" onclick="this.closest('.toast-container').remove()"></button>
            </div>
        </div>`;
    document.body.appendChild(div);
    setTimeout(() => div.remove(), 4000);
}

/**
 * Định dạng số tiền
 */
function dinhDangTien(so) {
    return Math.round(so).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + 'đ';
}

// ========================
// Giỏ hàng
// ========================

/**
 * Thêm sản phẩm vào giỏ hàng
 */
async function themVaoGioHang(bienTheId, soLuong = 1) {
    try {
        const res = await fetch('/gio-hang/them', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-CSRF-TOKEN': getCsrfToken()
            },
            body: `bienTheId=${bienTheId}&soLuong=${soLuong}`
        });
        const data = await res.json();
        if (data.thanhCong) {
            capNhatSoLuongGioHang(data.soSanPhamTrongGio);
            hienThiThongBao(data.thongBao || 'Đã thêm vào giỏ hàng', 'success');
        } else {
            hienThiThongBao(data.thongBao || 'Không thể thêm vào giỏ', 'danger');
        }
    } catch (e) {
        hienThiThongBao('Lỗi kết nối server', 'danger');
    }
}

/**
 * Cập nhật số lượng hiển thị trên icon giỏ hàng
 */
function capNhatSoLuongGioHang(soLuong) {
    const badge = document.getElementById('gio-hang-badge');
    if (badge) {
        badge.textContent = soLuong;
        badge.style.display = soLuong > 0 ? 'flex' : 'none';
    }
}

// ========================
// Fade in khi scroll
// ========================
(function () {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(e => {
            if (e.isIntersecting) {
                e.target.classList.add('visible');
                observer.unobserve(e.target);
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.fade-in').forEach(el => observer.observe(el));
})();

// ========================
// Xem trước ảnh upload
// ========================
function xemTruocAnh(input, imgId) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = (e) => {
            const img = document.getElementById(imgId);
            if (img) {
                img.src = e.target.result;
                img.style.display = 'block';
            }
        };
        reader.readAsDataURL(input.files[0]);
    }
}

// ========================
// Tự động đóng flash messages
// ========================
document.addEventListener('DOMContentLoaded', function () {
    // Auto-close alerts after 5s
    document.querySelectorAll('.alert-dismissible').forEach(alert => {
        setTimeout(() => {
            const btn = alert.querySelector('.btn-close');
            if (btn) btn.click();
        }, 5000);
    });

    // Tooltip Bootstrap
    const tooltips = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    tooltips.forEach(el => new bootstrap.Tooltip(el));
});
