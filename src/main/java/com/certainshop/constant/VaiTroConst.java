package com.certainshop.constant;

/**
 * Hằng số vai trò người dùng
 */
public final class VaiTroConst {
    private VaiTroConst() {}

    public static final String SUPER_ADMIN = "SUPER_ADMIN";
    public static final String ADMIN = "ADMIN";
    public static final String NHAN_VIEN = "NHAN_VIEN";
    public static final String KHACH_HANG = "KHACH_HANG";

    public static final String QUYEN_SUPER_ADMIN = "ALL_PRIVILEGES";
    public static final String QUYEN_ADMIN = "MANAGE_USERS, MANAGE_PRODUCTS";
    public static final String QUYEN_NHAN_VIEN = "BAN_HANG";
    public static final String QUYEN_KHACH_HANG = "MUA_HANG";
}
