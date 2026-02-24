document.addEventListener("DOMContentLoaded", function() {
    // Load header
    fetch("components/header.html")
        .then(response => response.text())
        .then(data => document.getElementById("header").innerHTML = data)
        .catch(err => console.error("Lỗi load header:", err));

    // Load footer
    fetch("components/footer.html")
        .then(response => response.text())
        .then(data => document.getElementById("footer").innerHTML = data)
        .catch(err => console.error("Lỗi load footer:", err));

    // Load sidebar (nếu trang có id="sidebar")
    if (document.getElementById("sidebar")) {
        fetch("components/sidebar.html")
            .then(response => response.text())
            .then(data => document.getElementById("sidebar").innerHTML = data)
            .catch(err => console.error("Lỗi load sidebar:", err));
    }

    // Load modal-auth
    fetch("components/modal-auth.html")
        .then(response => response.text())
        .then(data => document.getElementById("modal").innerHTML = data)
        .catch(err => console.error("Lỗi load modal:", err));
});