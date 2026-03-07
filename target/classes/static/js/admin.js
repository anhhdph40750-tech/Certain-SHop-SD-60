/**
 * CERTAIN SHOP - Admin JavaScript
 * Tiện ích cho giao diện quản lý
 */

// ========================
// Toast thông báo Admin
// ========================
function showToast(message, type = 'success') {
    const icon = { success: 'bi-check-circle', danger: 'bi-x-circle', warning: 'bi-exclamation-triangle', info: 'bi-info-circle' }[type] || 'bi-info-circle';
    const div = document.createElement('div');
    div.className = 'toast-container position-fixed bottom-0 end-0 p-3';
    div.style.zIndex = '9999';
    div.innerHTML = `
        <div class="toast show align-items-center text-bg-${type} border-0 shadow">
            <div class="d-flex">
                <div class="toast-body d-flex align-items-center gap-2">
                    <i class="bi ${icon}"></i> ${message}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" onclick="this.closest('.toast-container').remove()"></button>
            </div>
        </div>`;
    document.body.appendChild(div);
    setTimeout(() => div.remove(), 4000);
}

// ========================
// CSRF Token
// ========================
function getCsrf() {
    const meta = document.querySelector('meta[name="_csrf"]');
    if (meta) return meta.content;
    return document.cookie.split('; ').find(r => r.startsWith('XSRF-TOKEN='))?.split('=')[1] || '';
}

// ========================
// Định dạng tiền
// ========================
function formatSo(n) {
    return Math.round(n || 0).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// ========================
// Xác nhận xóa
// ========================
function xacNhanXoa(form, tenMuc) {
    return confirm(`Bạn có chắc muốn xóa "${tenMuc}"? Hành động này không thể hoàn tác.`);
}

// ========================
// Auto-close flash messages
// ========================
document.addEventListener('DOMContentLoaded', function () {
    // Tự đóng alerts sau 5 giây
    document.querySelectorAll('.alert-dismissible').forEach(alert => {
        setTimeout(() => {
            const btn = alert.querySelector('.btn-close');
            if (btn) btn.click();
        }, 5000);
    });

    // Active sidebar menu item dựa vào URL hiện tại
    const currentPath = window.location.pathname;
    document.querySelectorAll('.admin-sidebar .menu-item').forEach(item => {
        const href = item.getAttribute('href');
        if (href && currentPath.startsWith(href) && href !== '/') {
            item.classList.add('active');
        }
    });

    // Tooltip
    document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(el => new bootstrap.Tooltip(el));
});

// ========================
// Lazy load images trong bảng
// ========================
document.addEventListener('DOMContentLoaded', function () {
    const imgObserver = new IntersectionObserver((entries) => {
        entries.forEach(e => {
            if (e.isIntersecting) {
                const img = e.target;
                if (img.dataset.src) {
                    img.src = img.dataset.src;
                    imgObserver.unobserve(img);
                }
            }
        });
    });

    document.querySelectorAll('img[data-src]').forEach(img => imgObserver.observe(img));
});
