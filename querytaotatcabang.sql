USE QuanLyTiemChungAnhPham;
GO 


-- Xóa tất cả các khóa ngoại trong cơ sở dữ liệu hiện tại
DECLARE @sql NVARCHAR(MAX) = N'';

-- Tạo script để xóa các khóa ngoại
SELECT @sql += 'ALTER TABLE [' + OBJECT_SCHEMA_NAME(parent_object_id) + '].[' + OBJECT_NAME(parent_object_id) + '] DROP CONSTRAINT [' + name + '];' + CHAR(13)
FROM sys.foreign_keys;

-- Thực thi script
EXEC sp_executesql @sql;

-- Xóa bảng nếu tồn tại trước khi tạo mới
DROP TABLE IF EXISTS CHI_TIET_LICH_HEN, CHI_TIET_LO_VACCINE, CHI_TIET_LAN_TIEM, PHIEU_KHAM, LAN_TIEM,  PHAN_UNG_SAU_TIEM, CAN_BO_CO_SO, LICH_HEN,  HO_SO_TIEM_CHUNG, LO_VACCINE, VACCINE, CO_SO, CAN_BO_Y_TE, BENH_NHAN;


-- Bảng BỆNH NHÂN
CREATE TABLE BENH_NHAN (
    Ma_Benh_Nhan VARCHAR(15) PRIMARY KEY NOT NULL,      -- Ví dụ: BN000001, BN000002
    Ho_Ten NVARCHAR(100) NOT NULL,             -- Ví dụ: Nguyễn Văn A
    Ngay_Sinh DATE NOT NULL,                   -- Ví dụ: 1990-05-15
    Gioi_Tinh BIT NULL,           -- Ví dụ: Nam, Nữ, Liên giới tính
    Dia_Chi NVARCHAR(255) NOT NULL,                     -- Ví dụ: 123 Lê Lợi, Q.1, TP.HCM
    So_Dien_Thoai VARCHAR(15) NOT NULL,                 -- Ví dụ: 0901234567
    Email VARCHAR(100) NOT NULL,                        -- Ví dụ: nguyenvana@gmail.com
    CCCD CHAR(12) NULL,            
    Nguoi_Giam_Ho BIT ,
    Trang_Thai BIT NOT NULL,               -- Ví dụ: 079202000001
                  -- Ví dụ: 0/1
                  
);

CREATE UNIQUE INDEX UQ_BENH_NHAN_CCCD 
ON BENH_NHAN(CCCD) 
WHERE CCCD IS NOT NULL;

-- Bảng CÁN BỘ Y TẾ
CREATE TABLE CAN_BO_Y_TE (
    Ma_Can_Bo VARCHAR(15) PRIMARY KEY NOT NULL,         -- Ví dụ: CB000001, CB000002
    Ho_Ten NVARCHAR(100) NOT NULL,             -- Ví dụ: Trần Thị B
    So_Dien_Thoai VARCHAR(15) NOT NULL,        -- Ví dụ: 0909876543
    Email VARCHAR(100) NOT NULL,                        -- Ví dụ: tranthib@gmail.com
    Bang_Cap NVARCHAR(100),                     -- Ví dụ: Bác sĩ chuyên khoa 1
    Trang_Thai BIT NOT NULL               -- Ví dụ: 079202000001
);

-- Bảng CƠ SỞ
CREATE TABLE CO_SO (
    Ma_Co_So VARCHAR(15) PRIMARY KEY NOT NULL,          -- Ví dụ: CS000001, CS000002
    Ten_Co_So NVARCHAR(100) NOT NULL,          -- Ví dụ: Trung tâm Y tế quận 1
    Dia_Chi NVARCHAR(255) NOT NULL,            -- Ví dụ: 123 Nguyễn Huệ, Q.1, TP.HCM
    So_Dien_Thoai VARCHAR(15) NOT NULL,        -- Ví dụ: 0283123456
    Email VARCHAR(100),                        -- Ví dụ: ttytq1@gmail.com
    Cap_Co_So CHAR(1) NOT NULL            -- Ví dụ: 1,2,3
);

-- Bảng CÁN BỘ - CƠ SỞ
CREATE TABLE CAN_BO_CO_SO (    -- Ví dụ: PC000001, PC000002
    Ma_Co_So VARCHAR(15) NOT NULL,             -- Ví dụ: CS000001
    Ma_Can_Bo VARCHAR(15) NOT NULL,            -- Ví dụ: CB000001
    Chuc_Vu NVARCHAR(100) NOT NULL,            -- Ví dụ: Trưởng khoa, Bác sĩ, Y tá
    Ngay_Bat_Dau DATE NOT NULL,                -- Ví dụ: 2023-01-01
    Ngay_Ket_Thuc DATE, 
    
    PRIMARY KEY (Ma_Can_Bo, Ma_Co_So),                     -- Ví dụ: 2023-12-31
    FOREIGN KEY (Ma_Co_So) REFERENCES CO_SO(Ma_Co_So),
    FOREIGN KEY (Ma_Can_Bo) REFERENCES CAN_BO_Y_TE(Ma_Can_Bo)
);


-- Bảng HỒ SƠ TIÊM CHỦNG
CREATE TABLE HO_SO_TIEM_CHUNG (
    Ma_Ho_So VARCHAR(15) PRIMARY KEY NOT NULL,          -- Ví dụ: HS000001, HS000002
    Ma_Tiem_Chung CHAR(15) UNIQUE NOT NULL,        -- Ví dụ: 349349333000001
    Ma_Benh_Nhan VARCHAR(15) UNIQUE NOT NULL,         -- Ví dụ: BN000001
    Ngay_Tao DATETIME NOT NULL,                    -- Ví dụ: 2023-10-01 08:00:00
    Trang_Thai BIT NOT NULL,
    FOREIGN KEY (Ma_Benh_Nhan) REFERENCES BENH_NHAN(Ma_Benh_Nhan)
);
-- Bảng PHIẾU KHÁM
CREATE TABLE PHIEU_KHAM (
    Ma_Phieu_Kham VARCHAR(15) PRIMARY KEY NOT NULL,     -- Ví dụ: PK000001, PK000002
    Ma_Ho_So VARCHAR(15) NOT NULL, 
    Ma_Can_Bo VARCHAR(15) NOT NULL,
    Ma_Co_So VARCHAR(15) NOT NULL,          -- Ví dụ: CB000001
    Ngay_Kham DATE NOT NULL,                   -- Ví dụ: 2023-10-05
    Noi_Dung NVARCHAR(MAX),   
    Chi_Dinh NVARCHAR (30) CHECK (Chi_Dinh IN (N'Đủ điều kiện tiêm', N'Hủy bỏ',N'Không đủ điều kiện')) NOT NULL,
    
    FOREIGN KEY (Ma_Ho_So) REFERENCES HO_SO_TIEM_CHUNG(Ma_Ho_So),
    FOREIGN KEY (Ma_Can_Bo, Ma_Co_So) REFERENCES CAN_BO_CO_SO(Ma_Can_Bo, Ma_Co_So)
);
-- Bảng VACCINE
CREATE TABLE VACCINE (
    Ma_Vaccine VARCHAR(15) PRIMARY KEY NOT NULL,        -- Ví dụ: VC000001, VC000002
    Ten_Vaccine NVARCHAR(255) NOT NULL,        -- Ví dụ: Pfizer COVID-19
    Loai_Khang_Nguyen NVARCHAR(255) NOT NULL,  -- Ví dụ: mRNA
    Hang_San_Xuat NVARCHAR(255) NOT NULL,      -- Ví dụ: Pfizer-BioNTech
    So_Lieu_Tiem INT NOT NULL,                 -- Ví dụ: 2 (số liều cần tiêm)
    Trang_Thai BIT NOT NULL
);

-- Duplicate CREATE TABLE VACCINE statement removed.

-- Bảng LÔ VACCINE
CREATE TABLE LO_VACCINE (
    Ma_Lo VARCHAR(20) PRIMARY KEY NOT NULL,             -- Ví dụ: LOT2023001, LOT2023002
    Ma_Vaccine VARCHAR(15) NOT NULL,           -- Ví dụ: VC000001
    So_Lieu_Vaccine_Ban_Dau INT NOT NULL,      -- Ví dụ: 1000
    Ngay_San_Xuat DATE NOT NULL,
    Han_Su_Dung DATE NOT NULL,                 -- Ví dụ: 2024-05-31
    Xuat_Xu NVARCHAR(255) NOT NULL,            -- Ví dụ: Hoa Kỳ   -- Ví dụ: 2023-05-01
    Tinh_Trang NVARCHAR(255) CHECK (Tinh_Trang IN (N'Đang lưu kho', N'Đang phân phối', N'Sẵn sàng sử dụng',  
    N'Đã sử dụng một phần', N'Đã sử dụng hết', N'Hết hạn', N'Hủy bỏ')) NOT NULL,         -- Ví dụ: Còn hàng, Hết hàng
    FOREIGN KEY (Ma_Vaccine) REFERENCES VACCINE(Ma_Vaccine)
);

-- Bảng LẦN TIÊM
CREATE TABLE LAN_TIEM (
        Ma_Lan_Tiem VARCHAR(15) PRIMARY KEY NOT NULL,       -- Ví dụ: LT000001, LT000002
        Ma_Ho_So  VARCHAR(15) NOT NULL,        -- Ví dụ: TC000001
        Ma_Can_Bo VARCHAR(15) NOT NULL,
        Ma_Co_So VARCHAR(15) NOT NULL,         -- Ví dụ: CB000001        -- Ví dụ: TC000001
        Ngay_Tiem DATE NOT NULL,                   -- Ví dụ: 2023-10-10
        Ket_Qua_Tiem NVARCHAR(100) CHECK (Ket_Qua_Tiem IN (N'Thành công', N'Xảy ra phản ứng', N'Hoãn tiêm', N'Đình chỉ vĩnh viễn', N'Không thành công')) NOT NULL,          
                       -- Ví dụ: Đã tiêm thành công
        
        FOREIGN KEY (Ma_Ho_So) REFERENCES HO_SO_TIEM_CHUNG(Ma_Ho_So),
        FOREIGN KEY (Ma_Can_Bo, Ma_Co_So) REFERENCES CAN_BO_CO_SO(Ma_Can_Bo, Ma_Co_So)
);


-- Bảng CHI TIẾT LẦN TIÊM
CREATE TABLE CHI_TIET_LAN_TIEM (
    Ma_Lan_Tiem VARCHAR(15) NOT NULL,          -- Ví dụ: LT000001
    Ma_Vaccine VARCHAR(15) NOT NULL,           -- Ví dụ: VC000001
    PRIMARY KEY (Ma_Lan_Tiem, Ma_Vaccine),                                        -- Ví dụ: 0.5 (đơn vị ml)
    FOREIGN KEY (Ma_Lan_Tiem) REFERENCES LAN_TIEM(Ma_Lan_Tiem),
    FOREIGN KEY (Ma_Vaccine) REFERENCES VACCINE(Ma_Vaccine)
);
-- Bảng PHẢN ỨNG SAU TIÊM
CREATE TABLE PHAN_UNG_SAU_TIEM (
    Ma_Phan_Ung VARCHAR(15) PRIMARY KEY NOT NULL,       -- Ví dụ: PU000001, PU000002
    Ma_Lan_Tiem VARCHAR(15) NOT NULL,          -- Ví dụ: LT000001
    Ten_Phan_Ung NVARCHAR(100) NOT NULL,       -- Ví dụ: Sốt nhẹ
    Muc_Do_Phan_Ung NVARCHAR(20) CHECK (Muc_Do_Phan_Ung IN (N'Nhẹ', N'Trung bình', N'Nặng')) NOT NULL,     -- Ví dụ: Nhẹ, Trung bình, Nặng
    Thoi_Diem_Xay_Ra DATETIME NOT NULL,        -- Ví dụ: 2023-10-10 15:30:00
    Thoi_Diem_Ket_Thuc DATETIME NULL,               -- Ví dụ: 2023-10-10 18:45:00
    Ghi_Chu NVARCHAR(500) NULL,                     -- Ví dụ: Đã sử dụng thuốc hạ sốt
    FOREIGN KEY (Ma_Lan_Tiem) REFERENCES LAN_TIEM(Ma_Lan_Tiem)
);
-- Bảng LỊCH HẸN
CREATE TABLE LICH_HEN (
    Ma_Lich_Hen VARCHAR(15) PRIMARY KEY NOT NULL,       -- Ví dụ: LH000001, LH000002
    Ma_Co_So VARCHAR(15) NOT NULL,           -- Ví dụ: CS000001
    Ma_Benh_Nhan VARCHAR(15) NOT NULL,   
    Ngay_Dat_Lich DATETIME NOT NULL,      -- Ví dụ: BN000001
    Ngay_Hen DATETIME NOT NULL,                    -- Ví dụ: 2023-11-01
    Ghi_Chu NVARCHAR(255) NULL,                     -- Ví dụ: Tiêm mũi 2 vắc-xin COVID-19
    Tinh_Trang_Lich NVARCHAR(50) CHECK (Tinh_Trang_Lich IN (N'Đã xác nhận', N'Đã gửi mail', N'Đã hủy', N'Đang chờ')) NOT NULL,     -- Ví dụ: Đã xác nhận, Chưa xác nhận, Đã hủy
    FOREIGN KEY (Ma_Benh_Nhan) REFERENCES BENH_NHAN(Ma_Benh_Nhan),
    FOREIGN KEY (Ma_Co_So) REFERENCES CO_SO(Ma_Co_So)
);



-- Bảng CHI TIẾT LÔ VACCINE
CREATE TABLE CHI_TIET_LO_VACCINE (    -- Ví dụ: CL000001, CL000002
    Ma_Lo VARCHAR(20) NOT NULL,                -- Ví dụ: LOT2023001
    Ma_Co_So VARCHAR(15) NOT NULL,             -- Ví dụ: CS000001
    So_Lieu_Da_Su_Dung INT NOT NULL DEFAULT 0, -- Ví dụ: 250
    So_Lieu_Ton_Kho INT NOT NULL,              -- Ví dụ: 750
    Ngay_Nhap DATE NOT NULL,                   -- Ví dụ: 2023-06-01
    Ngay_Xuat DATE,                            -- Ví dụ: 2023-06-15
    PRIMARY KEY (Ma_Lo, Ma_Co_So),
    FOREIGN KEY (Ma_Lo) REFERENCES LO_VACCINE(Ma_Lo),
    FOREIGN KEY (Ma_Co_So) REFERENCES CO_SO(Ma_Co_So)
);
-- Bảng CHI TIẾT LỊCH HẸN
CREATE TABLE CHI_TIET_LICH_HEN (  -- Ví dụ: CL000001, CL000002
    Ma_Lich_Hen VARCHAR(15) NOT NULL,          -- Ví dụ: LH000001
    Ma_Vaccine VARCHAR(15) NOT NULL,           -- Ví dụ: VC000001           -- Ví dụ: CS000001
    PRIMARY KEY (Ma_Lich_Hen, Ma_Vaccine),                 
    FOREIGN KEY (Ma_Lich_Hen) REFERENCES LICH_HEN(Ma_Lich_Hen),
    FOREIGN KEY (Ma_Vaccine) REFERENCES VACCINE(Ma_Vaccine)
);
