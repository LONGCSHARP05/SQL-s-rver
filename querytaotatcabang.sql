USE UDCSDL
go


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
    Ma_Tiem_Chung CHAR(15) UNIQUE NOT null,        -- Ví dụ: 349349333000001
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
    Ma_Co_So VARCHAR(4) PRIMARY KEY NOT NULL,          -- Ví dụ: CS000001, CS000002
    Ten_Co_So NVARCHAR(100) NOT NULL,          -- Ví dụ: Trung tâm Y tế quận 1
    Dia_Chi NVARCHAR(255) NOT NULL,            -- Ví dụ: 123 Nguyễn Huệ, Q.1, TP.HCM
    So_Dien_Thoai VARCHAR(15) NOT NULL,        -- Ví dụ: 0283123456
    Email VARCHAR(100),                        -- Ví dụ: ttytq1@gmail.com
    Cap_Co_So CHAR(1) NOT NULL            -- Ví dụ: 1,2,3
);

-- Bảng CÁN BỘ - CƠ SỞ
CREATE TABLE CAN_BO_CO_SO (    -- Ví dụ: PC000001, PC000002
    Ma_Co_So VARCHAR(4) NOT NULL,             -- Ví dụ: CS000001
    Ma_Can_Bo VARCHAR(15) NOT NULL,            -- Ví dụ: CB000001
    Chuc_Vu NVARCHAR(100) NOT NULL,            -- Ví dụ: Trưởng khoa, Bác sĩ, Y tá
    Ngay_Bat_Dau DATE NOT NULL,                -- Ví dụ: 2023-01-01
    Ngay_Ket_Thuc DATE, 
    
    PRIMARY KEY (Ma_Can_Bo, Ma_Co_So),                     -- Ví dụ: 2023-12-31
    FOREIGN KEY (Ma_Co_So) REFERENCES CO_SO(Ma_Co_So),
    FOREIGN KEY (Ma_Can_Bo) REFERENCES CAN_BO_Y_TE(Ma_Can_Bo)
);



-- Bảng PHIẾU KHÁM
CREATE TABLE PHIEU_KHAM (
    Ma_Phieu_Kham VARCHAR(15) PRIMARY KEY NOT NULL,     -- Ví dụ: PK000001, PK000002
    Ma_Benh_Nhan VARCHAR(15) NOT NULL,        -- Ví dụ: BN000001
    Ma_Can_Bo VARCHAR(15) NOT NULL,
    Ma_Co_So VARCHAR(4) NOT NULL,          -- Ví dụ: CB000001
    Ngay_Kham DATE NOT NULL,                   -- Ví dụ: 2023-10-05
    Noi_Dung NVARCHAR(MAX),   
    Chi_Dinh NVARCHAR (30) CHECK (Chi_Dinh IN (N'Đủ điều kiện tiêm', N'Hủy bỏ',N'Không đủ điều kiện')) NOT NULL,
    
    FOREIGN KEY (Ma_Benh_Nhan) REFERENCES BENH_NHAN(Ma_Benh_Nhan),
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
        Ma_Benh_Nhan VARCHAR(15) NOT NULL,        -- Ví dụ: TC000001
        Ma_Can_Bo VARCHAR(15) NOT NULL,
        Ma_Co_So VARCHAR(4) NOT NULL,         -- Ví dụ: CB000001        -- Ví dụ: TC000001
        Ngay_Tiem DATE NOT NULL,                   -- Ví dụ: 2023-10-10
        Ket_Qua_Tiem NVARCHAR(100) CHECK (Ket_Qua_Tiem IN (N'Thành công', N'Xảy ra phản ứng', N'Hoãn tiêm', N'Đình chỉ vĩnh viễn', N'Không thành công')) NOT NULL,          
                       -- Ví dụ: Đã tiêm thành công
        
        FOREIGN KEY (Ma_Benh_Nhan) REFERENCES BENH_NHAN(Ma_Benh_Nhan),
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
    Ma_Co_So VARCHAR(4) NOT NULL,           -- Ví dụ: CS000001
    Ma_Benh_Nhan VARCHAR(15) NOT NULL,   
    Ngay_Dat_Lich DATE NOT NULL,      -- Ví dụ: BN000001
    Ngay_Hen DATE NOT NULL,                    -- Ví dụ: 2023-11-01
    Ghi_Chu NVARCHAR(255) NULL,                     -- Ví dụ: Tiêm mũi 2 vắc-xin COVID-19
    Tinh_Trang_Lich NVARCHAR(50) CHECK (Tinh_Trang_Lich IN (N'Đã xác nhận', N'Đã gửi mail', N'Đã hủy', N'Đang chờ')) NOT NULL,     -- Ví dụ: Đã xác nhận, Chưa xác nhận, Đã hủy
    FOREIGN KEY (Ma_Benh_Nhan) REFERENCES BENH_NHAN(Ma_Benh_Nhan),
    FOREIGN KEY (Ma_Co_So) REFERENCES CO_SO(Ma_Co_So)
);



-- Bảng CHI TIẾT LÔ VACCINE
CREATE TABLE CHI_TIET_LO_VACCINE (    -- Ví dụ: CL000001, CL000002
    Ma_Lo VARCHAR(20) NOT NULL,                -- Ví dụ: LOT2023001
    Ma_Co_So VARCHAR(4) NOT NULL,             -- Ví dụ: CS000001
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

-- USE QuanLyTiemChungAnhPham;
-- GO

--Nhập liệu cho bảng bệnh nhân

-- Mã bệnh nhân (Hà Nội, sinh 1999, STT 1234)
-- Nam (1: Nam, 0: Nữ, NULL: Không xác định)
-- Số CCCD (có thể NULL)
-- Không có người giám hộ (1: Có, 0: Không)
-- Trạng thái hoạt động (1: Hoạt động, 0: Không hoạt động)


INSERT INTO BENH_NHAN (Ma_Benh_Nhan, Ma_Tiem_Chung, Ho_Ten, Ngay_Sinh, Gioi_Tinh, Dia_Chi, So_Dien_Thoai, Email, CCCD, Nguoi_Giam_Ho, Trang_Thai) 
VALUES
    ('BNHN991234', '123456789012345', N'Trần Minh Hoàng', '1999-08-22', 1, N'123 Lê Lợi, Q.1, TP.HCM', '0912340078', 'tranminhhoang@gmail.com', '079202000001', 0, 1),
    ('BNHN981001', '234567890123456', N'Nguyễn Văn Hải', '1998-01-15', 1, N'12 Cầu Giấy, Hà Nội', '0912345001', 'nguyenvanhai@gmail.com', '001234567891', 0, 1),
    ('BNHN990002', '345678901234567', N'Trần Thị Lan', '1999-05-20', 0, N'45 Tây Hồ, Hà Nội', '0912345002', 'tranthilan@gmail.com', '002345678912', 0, 1),
    ('BNHN010003', '456789012345678', N'Lê Quang Huy', '2001-09-10', 1, N'78 Đống Đa, Hà Nội', '0912345003', 'lequanghuy@gmail.com', '003456789123', 0, 1),
    ('BNHN020004', '567890123456789', N'Hoàng Minh Đức', '2002-11-25', 1, N'22 Hai Bà Trưng, Hà Nội', '0912345004', 'hoangminhduc@gmail.com', '004567891234', 0, 1),
    ('BNHN030005', '678901234567890', N'Phạm Thu Hằng', '2003-03-05', 0, N'90 Hoàn Kiếm, Hà Nội', '0912345005', 'phamthuhang@gmail.com', '005678912345', 0, 1),
    ('BNHN970006', '789012345678901', N'Vũ Hoài Nam', '1997-07-30', 1, N'15 Ba Đình, Hà Nội', '0912345006', 'vuhoainam@gmail.com', '006789123456', 0, 1),
    ('BNHN980007', '890123456789012', N'Đỗ Thị Thanh', '1998-12-18', 0, N'36 Thanh Xuân, Hà Nội', '0912345007', 'dothithanh@gmail.com', '007891234567', 0, 1),
    ('BNHN000008', '901234567890123', N'Ngô Văn Toàn', '2000-04-22', 1, N'55 Hoàng Mai, Hà Nội', '0912345008', 'ngovantoan@gmail.com', '008912345678', 0, 1),
    ('BNHN990009', '012345678901234', N'Bùi Thu Phương', '1999-06-14', 0, N'87 Long Biên, Hà Nội', '0912345009', 'buithuphuong@gmail.com', '009123456789', 0, 1),
    ('BNHN010010', '123456789012346', N'Đinh Tiến Dũng', '2001-10-29', 1, N'33 Bắc Từ Liêm, Hà Nội', '0912345010', 'dinhtiendung@gmail.com', '010234567890', 0, 1),
    ('BNHN030011', '234567890123457', N'Nguyễn Thị Mai', '2003-08-19', 0, N'66 Nam Từ Liêm, Hà Nội', '0912345011', 'nguyenthimai@gmail.com', '011345678901', 0, 1),
    ('BNHN920012', '345678901234568', N'Hoàng Văn Kiên', '1992-01-10', 1, N'99 Cầu Giấy, Hà Nội', '0912345012', 'hoangvankien@gmail.com', '012456789012', 0, 1),
    ('BNHN950013', '456789012345679', N'Phạm Văn Hoàng', '1995-02-05', 1, N'12 Tây Hồ, Hà Nội', '0912345013', 'phamvanhoang@gmail.com', '013567890123', 0, 1),
    ('BNHN000014', '567890123456780', N'Lê Thị Ngọc', '2000-07-25', 0, N'55 Đống Đa, Hà Nội', '0912345014', 'lethingoc@gmail.com', '014678901234', 0, 1),
    ('BNHN010015', '678901234567891', N'Trần Minh Tâm', '2001-09-18', 1, N'77 Hoàn Kiếm, Hà Nội', '0912345015', 'tranminhtam@gmail.com', '015789012345', 0, 1),
    ('BNHN030016', '789012345678902', N'Nguyễn Tuấn Anh', '2003-06-07', 1, N'90 Hai Bà Trưng, Hà Nội', '0912345016', 'nguyentuananh@gmail.com', '016890123456', 0, 1),
    ('BNHN980017', '890123456789013', N'Vũ Thanh Hà', '1998-12-21', 0, N'42 Ba Đình, Hà Nội', '0912345017', 'vuthanhha@gmail.com', '017901234567', 0, 1),
    ('BNHN020018', '901234567890124', N'Đỗ Hữu Phước', '2002-03-03', 1, N'33 Thanh Xuân, Hà Nội', '0912345018', 'dohuuphuoc@gmail.com', '018012345678', 0, 1),
    ('BNHN970019', '012345678901235', N'Ngô Văn Minh', '1997-11-14', 1, N'11 Hoàng Mai, Hà Nội', '0912345019', 'ngovanminh@gmail.com', '019123456780', 0, 1),
    ('BNHN000020', '123456789012347', N'Bùi Hồng Nhung', '2000-04-25', 0, N'77 Long Biên, Hà Nội', '0912345020', 'buihongnhung@gmail.com', '020234567891', 0, 1),
    ('BNHN990021', '234567890123458', N'Đinh Văn Thắng', '1999-07-12', 1, N'55 Bắc Từ Liêm, Hà Nội', '0912345021', 'dinhvanthang@gmail.com', '021345678902', 0, 1),
    ('BNHN030022', '345678901234569', N'Nguyễn Văn Bình', '2003-02-20', 1, N'88 Nam Từ Liêm, Hà Nội', '0912345022', 'nguyenvanbinh@gmail.com', '022456789013', 0, 1),
    ('BNHN010023', '456789012345680', N'Hoàng Ngọc Lan', '2001-09-28', 0, N'33 Cầu Giấy, Hà Nội', '0912345023', 'hoangngoclan@gmail.com', '023567890124', 0, 1),
    ('BNHN970024', '567890123456781', N'Phạm Văn Hùng', '1997-11-10', 1, N'66 Tây Hồ, Hà Nội', '0912345024', 'phamvanhung@gmail.com', '024678901235', 0, 1),
    ('BNHN000025', '678901234567892', N'Lê Thị Hương', '2000-07-15', 0, N'99 Đống Đa, Hà Nội', '0912345025', 'lethihuong@gmail.com', '025789012346', 0, 1),
    ('BNHN020026', '789012345678903', N'Trần Minh Khang', '2002-03-27', 1, N'12 Hoàn Kiếm, Hà Nội', '0912345026', 'tranminhkhang@gmail.com', '026890123457', 0, 1),
    ('BNHN030027', '890123456789014', N'Nguyễn Thùy Dung', '2003-06-22', 0, N'42 Hai Bà Trưng, Hà Nội', '0912345027', 'nguyenthuydung@gmail.com', '027901234568', 0, 1),
    ('BNHN980028', '901234567890125', N'Vũ Quang Huy', '1998-12-11', 1, N'33 Ba Đình, Hà Nội', '0912345028', 'vuquanghuy@gmail.com', '028012345679', 0, 1),
    ('BNHN990029', '012345678901236', N'Đỗ Tiến Dũng', '1999-05-14', 1, N'77 Thanh Xuân, Hà Nội', '0912345029', 'dotiendung@gmail.com', '029123456780', 0, 1),
    ('BNHN970030', '123456789012348', N'Ngô Văn Lộc', '1997-08-05', 1, N'66 Hoàng Mai, Hà Nội', '0912345030', 'ngovanloc@gmail.com', '030234567891', 0, 1),
    ('BNHN170031', '234567890123459', N'Nguyễn An Khôi', '2017-06-15', 1, N'12 Cầu Giấy, Hà Nội', '0912345031', 'nguyenankhoi@gmail.com', NULL, 1, 1),
    ('BNHN180032', '345678901234570', N'Hoàng Minh Châu', '2018-08-20', 0, N'45 Tây Hồ, Hà Nội', '0912345032', 'hoangminhchau@gmail.com', NULL, 1, 1),
    ('BNHN190033', '456789012345681', N'Lê Quang Nhật', '2019-09-10', 1, N'78 Đống Đa, Hà Nội', '0912345033', 'lequangnhat@gmail.com', NULL, 1, 1),
    ('BNHN200034', '567890123456782', N'Phạm Gia Bảo', '2020-02-25', 1, N'22 Hai Bà Trưng, Hà Nội', '0912345034', 'phamgiabao@gmail.com', NULL, 1, 1),
    ('BNHN210035', '678901234567893', N'Đỗ Thảo Vy', '2021-03-05', 0, N'90 Hoàn Kiếm, Hà Nội', '0912345035', 'dothaovy@gmail.com', NULL, 1, 1),
    ('BNHN180036', '789012345678904', N'Vũ Minh Tuấn', '2018-07-30', 1, N'15 Ba Đình, Hà Nội', '0912345036', 'vuminhtuan@gmail.com', NULL, 1, 1),
    ('BNHN190037', '890123456789015', N'Ngô Hoàng My', '2019-12-18', 0, N'36 Thanh Xuân, Hà Nội', '0912345037', 'ngohoangmy@gmail.com', NULL, 1, 1),
    ('BNHN200038', '901234567890126', N'Trần Ngọc Bảo', '2020-04-22', 1, N'55 Hoàng Mai, Hà Nội', '0912345038', 'tranngocbao@gmail.com', NULL, 1, 1),
    ('BNHN210039', '012345678901237', N'Bùi Anh Khoa', '2021-06-14', 1, N'87 Long Biên, Hà Nội', '0912345039', 'buianhkhoa@gmail.com', NULL, 1, 1),
    ('BNHN220040', '123456789012349', N'Đinh Thanh Hà', '2022-10-29', 0, N'33 Bắc Từ Liêm, Hà Nội', '0912345040', 'dinhthanhha@gmail.com', NULL, 1, 1),
    ('BNHN950041', '234567890123460', N'Nguyễn Hữu Toàn', '1995-07-12', 1, N'66 Nam Từ Liêm, Hà Nội', '0912345041', 'nguyenhuutoan@gmail.com', '041345678901', 0, 0),
    ('BNHN920042', '345678901234571', N'Hoàng Văn Nghĩa', '1992-01-10', 1, N'99 Cầu Giấy, Hà Nội', '0912345042', 'hoangvannghia@gmail.com', '042456789012', 0, 0),
    ('BNHN950043', '456789012345682', N'Phạm Hoàng Nam', '1995-02-05', 1, N'12 Tây Hồ, Hà Nội', '0912345043', 'phamhoangnam@gmail.com', '043567890123', 0, 0),
    ('BNHN000044', '567890123456783', N'Lê Văn Khánh', '2000-07-25', 1, N'55 Đống Đa, Hà Nội', '0912345044', 'levankhanh@gmail.com', '044678901234', 0, 0),
    ('BNHN010045', '678901234567894', N'Trần Thị Huyền', '2001-09-18', 0, N'77 Hoàn Kiếm, Hà Nội', '0912345045', 'tranthihuyen@gmail.com', '045789012345', 0, 0),
    ('BNHCM980046', '789012345678905', N'Nguyễn Văn Tín', '1998-06-25', 1, N'12 Quận 1, TP.HCM', '0912345046', 'nguyenvantin@gmail.com', '046890123456', 0, 1),
    ('BNHCM990047', '890123456789016', N'Phạm Thị Thảo', '1999-05-20', 0, N'45 Quận 3, TP.HCM', '0912345047', 'phamthithao@gmail.com', '047901234567', 0, 1),
    ('BNHCM000048', '901234567890127', N'Lê Minh Đức', '2000-09-10', 1, N'78 Quận 5, TP.HCM', '0912345048', 'leminhduc@gmail.com', '048012345678', 0, 1),
    ('BNHCM020049', '012345678901238', N'Hoàng Văn Trung', '2002-11-25', 1, N'22 Quận 7, TP.HCM', '0912345049', 'hoangvantrung@gmail.com', '049123456789', 0, 1),
    ('BNHCM030050', '123456789012350', N'Đỗ Bích Hằng', '2003-03-05', 0, N'90 Quận 10, TP.HCM', '0912345050', 'dobichhang@gmail.com', '050234567890', 0, 1),
    ('BNHCM970051', '234567890123461', N'Vũ Hoài Phong', '1997-07-30', 1, N'15 Quận Bình Thạnh, TP.HCM', '0912345051', 'vuhoaiphong@gmail.com', '051345678901', 0, 1),
    ('BNHCM980052', '345678901234572', N'Ngô Thanh Mai', '1998-12-18', 0, N'36 Quận Phú Nhuận, TP.HCM', '0912345052', 'ngothanhmai@gmail.com', '052456789012', 0, 1),
    ('BNHCM000053', '456789012345683', N'Bùi Văn Hậu', '2000-04-22', 1, N'55 Quận Tân Bình, TP.HCM', '0912345053', 'buivanhau@gmail.com', '053567890123', 0, 1),
    ('BNHCM990054', '567890123456784', N'Đinh Ngọc Dung', '1999-06-14', 0, N'87 Quận Gò Vấp, TP.HCM', '0912345054', 'dinhngocdung@gmail.com', '054678901234', 0, 1),
    ('BNHCM010055', '678901234567895', N'Trần Hoàng Anh', '2001-10-29', 1, N'33 Quận 2, TP.HCM', '0912345055', 'tranhoanganh@gmail.com', '055789012345', 0, 1);

-- Nhập liệu cho bảng Cán bộ y tế
INSERT INTO CAN_BO_Y_TE (Ma_Can_Bo, Ho_Ten, So_Dien_Thoai, Email, Bang_Cap, Trang_Thai)
VALUES 
('CBNTTH868', N'Nguyễn Thị Thanh Hiếu', '0912978908', 'hieu.thnh@gmail.com', N'Tiến sĩ', 1),
('CBTTH888', N'Trần Thanh Hải', '0912999888', 'hai.tt@gmail.com', N'Tiến sĩ', 1),
('CBNVA001', N'Nguyễn Văn An', '0192345678', 'nguyenvana@gmail.com', N'Tiến sĩ', 1),
('CBPTH002', N'Phạm Thị Hạnh', '0987654321', 'phamthihanh@gmail.com', N'Thạc sĩ', 1),
('CBLTP003', N'Lê Tuấn Phong', '0898123456', 'letuanphong@gmail.com', N'Cử nhân', 1),
('CBTMA004', N'Trần Minh Anh', '0901122334', 'tranminhanh@gmail.com', N'Phó giáo sư - Tiến sĩ', 1),
('CBHBT005', N'Hoàng Bảo Trâm', '0977654231', 'hoangbaotram@gmail.com', N'Thạc sĩ', 1),
('CBNTT006', N'Ngô Thanh Tùng', '0866789012', 'ngothanhtung@gmail.com', N'Cử nhân', 1),
('CBPVL007', N'Phan Văn Lâm', '0834567890', 'phanvanlam@gmail.com', N'Tiến sĩ', 1),
('CBLLP008', N'Lý Lan Phương', '0920056789', 'lylanphuong@gmail.com', N'Thạc sĩ', 1),
('CBTCT009', N'Trịnh Công Thành', '0812345678', 'trinhcongthanh@gmail.com', N'Phó giáo sư - Tiến sĩ', 1),
('CBDBH010', N'Đinh Bảo Hân', '0876543210', 'dinhbaohan@gmail.com', N'Cử nhân', 0),
('CBNQA011', N'Nguyễn Quang Anh', '0903456789', 'nguyenquanganh@gmail.com', N'Thạc sĩ', 1),
('CBTTN012', N'Tô Thị Nga', '0956789012', 'tothinga@gmail.com', N'Cử nhân', 1),
('CBLHD013', N'Lương Hoàng Dũng', '0823456789', 'luonghoangdung@gmail.com', N'Tiến sĩ', 1),
('CBPTH014', N'Phan Thị Hiền', '0965432109', 'phanthihien@gmail.com', N'Thạc sĩ', 0),
('CBTTD015', N'Trần Thế Dũng', '0856789012', 'tranthidung@gmail.com', N'Phó giáo sư - Tiến sĩ', 1),
('CBPTK016', N'Phạm Thị Kim', '0812345679', 'phamthikim@gmail.com', N'Cử nhân', 1),
('CBLHV017', N'Lê Hữu Vinh', '0845678901', 'lehuuvinh@gmail.com', N'Thạc sĩ', 1),
('CBNBT018', N'Nguyễn Bảo Trang', '0998765432', 'nguyenbaotrang@gmail.com', N'Phó giáo sư - Tiến sĩ', 1),
('CBHNN019', N'Hoàng Như Ngọc', '0947658901', 'hoangnhungoc@gmail.com', N'Tiến sĩ', 1),
('CBDBP020', N'Đoàn Bảo Phúc', '0971234567', 'doanbaophuc@gmail.com', N'Cử nhân', 0),
('CBNTH021', N'Nguyễn Thị Hương', '0923456780', 'nguyenthihuong@gmail.com', N'Thạc sĩ', 1),
('CBPQT022', N'Phan Quang Thịnh', '0898765432', 'phanquangthinh@gmail.com', N'Phó giáo sư - Tiến sĩ', 1),
('CBLNT023', N'Lê Ngọc Trâm', '0956789013', 'lengoctram@gmail.com', N'Thạc sĩ', 1),
('CBTVH024', N'Trần Văn Hoàng', '0876543209', 'tranvanhoang@gmail.com', N'Tiến sĩ', 1),
('CBPHT025', N'Phạm Hải Tú', '0823456788', 'phamhaitu@gmail.com', N'Cử nhân', 1),
('CBNMC026', N'Nguyễn Minh Châu', '0934567890', 'nguyenminhchau@gmail.com', N'Phó giáo sư - Tiến sĩ', 0),
('CBLLT027', N'Lý Long Thịnh', '0198234567', 'lylongthinh@gmail.com', N'Thạc sĩ', 1),
('CBTNN028', N'Tô Ngọc Nam', '0987654309', 'tongocnam@gmail.com', N'Cử nhân', 1),
('CBMVT029', N'Mai Văn Thái', '0912345609', 'maivanthai@gmail.com', N'Thạc sĩ', 1),
('CBNDT030', N'Nguyễn Đình Tuấn', '0856789023', 'nguyendinhtuan@gmail.com', N'Tiến sĩ', 1);

INSERT INTO CAN_BO_Y_TE (Ma_Can_Bo, Ho_Ten, So_Dien_Thoai, Email, Bang_Cap, Trang_Thai)
VALUES 
('CBDHA028', N'Đỗ Hoàng Anh', '0987654328', 'd.hoanganh@gmail.com', N'Thạc sĩ', 1),
('CBBTA006', N'Bùi Thị Ánh', '0912345606', 'bui.thianh@gmail.com', N'Cử nhân', 1),
('CBVTA005', N'Võ Thị Ánh', '0978123005', 'vta005@gmail.com', N'Thạc sĩ', 1),
('CBLMT045', N'Lâm Minh Tâm', '0911123045', 'tam.lamm@hcm.gov.vn', N'Cử nhân', 1),
('CBBTN094', N'Bành Thị Nhung', '0988999094', 'nhung.bt@hanoi.gov.vn', N'Phó giáo sư - Tiến sĩ', 1);

INSERT INTO CAN_BO_Y_TE (Ma_Can_Bo, Ho_Ten, So_Dien_Thoai, Email, Bang_Cap, Trang_Thai)
VALUES
    ('CBNVA24087', N'Nguyễn Văn An', '0812345678', 'nguyenvanan@gmail.com', N'Cử nhân', 1),
    ('CBPTH24129', N'Phạm Thị Hồng', '0823456789', 'phamthihong@gmail.com', N'Cử nhân', 1),
    ('CBLMT24231', N'Lê Minh Tuấn', '0834567890', 'leminhtuan@gmail.com', N'Bác sĩ', 1),
    ('CBDHA24056', N'Đào Hoài An', '0845678901', 'daohoaian@gmail.com', N'Bác sĩ', 1),
    ('CBTMD24198', N'Trần Mạnh Dũng', '0856789012', 'tranmanhdung@gmail.com', N'Thạc sĩ', 1),
    ('CBBTA24275', N'Bùi Thị Ánh', '0867890123', 'buithianh@gmail.com', N'Thạc sĩ', 1),
    ('CBNTL24034', N'Ngô Tuấn Linh', '0878901234', 'ngotuanlinh@gmail.com', N'Tiến sĩ', 1),
    ('CBPQN24115', N'Phan Quang Nhật', '0889012345', 'phanquangnhat@gmail.com', N'Tiến sĩ', 1),
    ('CBVTA24289', N'Võ Thị Anh', '0890123456', 'vothianh@gmail.com', N'Bác sĩ', 1),
    ('CBDBH24010', N'Đinh Bảo Hân', '0876543221', 'dinhbaohan@gmail.com', N'Cử nhân', 1),
    ('CBDBP24178', N'Đoàn Bảo Phúc', '0971234567', 'doanbaophuc@gmail.com', N'Cử nhân', 1),
    ('CBHBT24092', N'Hoàng Bảo Trâm', '0977654321', 'hoangbaotram@gmail.com', N'Thạc sĩ', 1),
    ('CBHNN24203', N'Hoàng Như Ngọc', '0945678901', 'hoangnhungoc@gmail.com', N'Tiến sĩ', 1),
    ('CBLHD24147', N'Lương Hoàng Dũng', '0111167829', 'luonghoangdung@gmail.com', N'Tiến sĩ', 1),
    ('CBLHV24266', N'Lê Hữu Vinh', '0845678901', 'lehuuvinh@gmail.com', N'Thạc sĩ', 1),
    ('CBLLP24081', N'Lý Lan Phương', '0943256789', 'lylanphuong@gmail.com', N'Thạc sĩ', 1),
    ('CBLLT24259', N'Lý Long Thịnh', '0891234567', 'lylongthinh@gmail.com', N'Thạc sĩ', 1),
    ('CBBTN24039', N'Bùi Thị Nga', '0901234567', 'buithinga@gmail.com', N'Bác sĩ', 1),
    ('CBPTD24194', N'Phạm Tuấn Dũng', '0912222278', 'phamtuandung@gmail.com', N'Cử nhân', 1),
    ('CBNMD24250', N'Nguyễn Minh Đức', '0934567890', 'nguyenminhduc@gmail.com', N'Thạc sĩ', 1);

UPDATE CAN_BO_Y_TE SET Bang_Cap = N'Thạc sĩ' WHERE Bang_Cap = N'Bác sĩ';

-- Cập nhật mã cán bộ theo đúng quy tắc

UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBPTH129' WHERE Ma_Can_Bo = 'CBPTH24129';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBLMT231' WHERE Ma_Can_Bo = 'CBLMT24231';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBDHA056' WHERE Ma_Can_Bo = 'CBDHA24056';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBTMD198' WHERE Ma_Can_Bo = 'CBTMD24198';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBBTA275' WHERE Ma_Can_Bo = 'CBBTA24275';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBNTL034' WHERE Ma_Can_Bo = 'CBNTL24034';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBPQN115' WHERE Ma_Can_Bo = 'CBPQN24115';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBVTA289' WHERE Ma_Can_Bo = 'CBVTA24289';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBDBH019' WHERE Ma_Can_Bo = 'CBDBH24010';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBDBP178' WHERE Ma_Can_Bo = 'CBDBP24178';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBHBT092' WHERE Ma_Can_Bo = 'CBHBT24092';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBHNN203' WHERE Ma_Can_Bo = 'CBHNN24203';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBLHD147' WHERE Ma_Can_Bo = 'CBLHD24147';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBLHV266' WHERE Ma_Can_Bo = 'CBLHV24266';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBLLP081' WHERE Ma_Can_Bo = 'CBLLP24081';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBLLT259' WHERE Ma_Can_Bo = 'CBLLT24259';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBBTN039' WHERE Ma_Can_Bo = 'CBBTN24039';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBPTD194' WHERE Ma_Can_Bo = 'CBPTD24194';
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBNMD250' WHERE Ma_Can_Bo = 'CBNMD24250';

-- Cập nhật email và số điện thoại cho từng cán bộ
UPDATE CAN_BO_Y_TE
SET 
    So_Dien_Thoai = CONCAT('09', RIGHT(So_Dien_Thoai, 8)), -- Cập nhật số điện thoại duy nhất
    Email = CONCAT(LOWER(REPLACE(Ho_Ten, ' ', '')), '@example.com') -- Cập nhật email duy nhất
WHERE Ma_Can_Bo IN (
    'CBBTA006', 'CBBTN094', 'CBDBH010', 'CBDBH019', 'CBDBP020', 'CBDBP178', 'CBDHA028', 
    'CBHBT005', 'CBHBT092', 'CBHNN019', 'CBHNN203', 'CBLHD013', 'CBLHD147', 'CBLHV017', 
    'CBLHV266', 'CBLLP008', 'CBLLP081', 'CBLLT027', 'CBLLT259', 'CBLMT045', 'CBLNT023', 
    'CBLTP003', 'CBMVT029', 'CBNBT018', 'CBNDT030', 'CBNMC026', 'CBNMD029', 'CBNQA011', 
    'CBNTH021', 'CBNTL086', 'CBNTT006', 'CBNVA001', 'CBNVA999', 'CBPHT025', 'CBPQN033', 
    'CBPQT022', 'CBPTD012', 'CBPTH002', 'CBPTH014', 'CBPTH047', 'CBPTK016', 'CBPVL007', 
    'CBTCT009', 'CBTMA004', 'CBTMD065', 'CBTNN028', 'CBTTD015', 'CBTTN012', 'CBTVH024', 
    'CBVTA005'
);

UPDATE CAN_BO_Y_TE
SET Email = CASE Ma_Can_Bo
    WHEN 'CBBTA006' THEN 'buithi.anh01@gmail.com'
    WHEN 'CBBTN094' THEN 'buithi.nga01@gmail.com'
    WHEN 'CBDBH010' THEN 'dinhbao.han01@gmail.com'
    WHEN 'CBDBH019' THEN 'dinhbao.han02@gmail.com'
    WHEN 'CBDBP020' THEN 'doanbao.phuc01@gmail.com'
    WHEN 'CBDBP178' THEN 'doanbao.phuc02@gmail.com'
    WHEN 'CBDHA028' THEN 'daohoai.an01@gmail.com'
    WHEN 'CBHBT005' THEN 'hoangbao.tram01@gmail.com'
    WHEN 'CBHBT092' THEN 'hoangbao.tram02@gmail.com'
    WHEN 'CBHNN019' THEN 'hoangnhu.ngoc01@gmail.com'
    WHEN 'CBHNN203' THEN 'hoangnhu.ngoc02@gmail.com'
    WHEN 'CBLHD013' THEN 'luonghoang.dung01@gmail.com'
    WHEN 'CBLHD147' THEN 'luonghoang.dung02@gmail.com'
    WHEN 'CBLHV017' THEN 'lehuu.vinh01@gmail.com'
    WHEN 'CBLHV266' THEN 'lehuu.vinh02@gmail.com'
    WHEN 'CBLLP008' THEN 'lylan.phuong01@gmail.com'
    WHEN 'CBLLP081' THEN 'lylan.phuong02@gmail.com'
    WHEN 'CBLLT027' THEN 'lylong.thinh01@gmail.com'
    WHEN 'CBLLT259' THEN 'lylong.thinh02@gmail.com'
    WHEN 'CBLMT045' THEN 'leminh.tuan01@gmail.com'
    WHEN 'CBLNT023' THEN 'lengoc.tram01@gmail.com'
    WHEN 'CBLTP003' THEN 'letuan.phong01@gmail.com'
    WHEN 'CBMVT029' THEN 'maivan.thai01@gmail.com'
    WHEN 'CBNBT018' THEN 'nguyenbao.trang01@gmail.com'
    WHEN 'CBNDT030' THEN 'nguyendinh.tuan01@gmail.com'
    WHEN 'CBNMC026' THEN 'nguyenminh.chau01@gmail.com'
    WHEN 'CBNMD029' THEN 'nguyenminh.duc01@gmail.com'
    WHEN 'CBNQA011' THEN 'nguyenquang.anh01@gmail.com'
    WHEN 'CBNTH021' THEN 'nguyenthi.huong01@gmail.com'
    WHEN 'CBNTL086' THEN 'ngotuan.linh01@gmail.com'
    WHEN 'CBNTT006' THEN 'ngothanh.tung01@gmail.com'
    WHEN 'CBNVA001' THEN 'nguyenvan.an01@gmail.com'
    WHEN 'CBNVA999' THEN 'nguyenvan.an02@gmail.com'
    WHEN 'CBPHT025' THEN 'phamhai.tu01@gmail.com'
    WHEN 'CBPQN033' THEN 'phanquang.nhat01@gmail.com'
    WHEN 'CBPQT022' THEN 'phanquang.thinh01@gmail.com'
    WHEN 'CBPTD012' THEN 'phamtuan.dung01@gmail.com'
    WHEN 'CBPTH002' THEN 'phamthi.hanh01@gmail.com'
    WHEN 'CBPTH014' THEN 'phanthi.hien01@gmail.com'
    WHEN 'CBPTH047' THEN 'phamthi.hong01@gmail.com'
    WHEN 'CBPTK016' THEN 'phamthi.kim01@gmail.com'
    WHEN 'CBPVL007' THEN 'phanvan.lam01@gmail.com'
    WHEN 'CBTCT009' THEN 'trinhcong.thanh01@gmail.com'
    WHEN 'CBTMA004' THEN 'tranminh.anh01@gmail.com'
    WHEN 'CBTMD065' THEN 'tranmanh.dung01@gmail.com'
    WHEN 'CBTNN028' THEN 'tongoc.nam01@gmail.com'
    WHEN 'CBTTD015' THEN 'tranthe.dung01@gmail.com'
    WHEN 'CBTTN012' THEN 'tothi.nga01@gmail.com'
    WHEN 'CBTVH024' THEN 'tranvan.hoang01@gmail.com'
    WHEN 'CBVTA005' THEN 'vothi.anh01@gmail.com'
END
WHERE Ma_Can_Bo IN (
    'CBBTA006', 'CBBTN094', 'CBDBH010', 'CBDBH019', 'CBDBP020', 'CBDBP178', 'CBDHA028', 
    'CBHBT005', 'CBHBT092', 'CBHNN019', 'CBHNN203', 'CBLHD013', 'CBLHD147', 'CBLHV017', 
    'CBLHV266', 'CBLLP008', 'CBLLP081', 'CBLLT027', 'CBLLT259', 'CBLMT045', 'CBLNT023', 
    'CBLTP003', 'CBMVT029', 'CBNBT018', 'CBNDT030', 'CBNMC026', 'CBNMD029', 'CBNQA011', 
    'CBNTH021', 'CBNTL086', 'CBNTT006', 'CBNVA001', 'CBNVA999', 'CBPHT025', 'CBPQN033', 
    'CBPQT022', 'CBPTD012', 'CBPTH002', 'CBPTH014', 'CBPTH047', 'CBPTK016', 'CBPVL007', 
    'CBTCT009', 'CBTMA004', 'CBTMD065', 'CBTNN028', 'CBTTD015', 'CBTTN012', 'CBTVH024', 
    'CBVTA005'
);

--Nhập data cơ sở
INSERT INTO CO_SO (Ma_Co_So, Ten_Co_So, Dia_Chi, So_Dien_Thoai, Email, Cap_Co_So)
VALUES
('KH01', N'Kho dự trữ tổng', N'123 Đường Hoàng Quốc Việt, Cầu Giấy, Hà Nội', '0241234567', 'khotong.hn@gmail.com', '1'),
('CS02', N'Cơ sở Thanh Xuân', N'45 Nguyễn Trãi, Thanh Xuân, Hà Nội', '0242345678', 'coso.tx@hanoi.gov.vn', '2'),
('CS03', N'Cơ sở Hoàn Kiếm', N'20 Hàng Bài, Hoàn Kiếm, Hà Nội', '0243456789', 'coso.hk@hanoi.gov.vn', '2'),
('CS04', N'Cơ sở Tây Hồ', N'98 Võ Chí Công, Tây Hồ, Hà Nội', '0244567890', 'coso.th@hanoi.gov.vn', '2'),
('CS05', N'Trung tâm Y tế Quận Ba Đình', N'12 Đội Cấn, Ba Đình, Hà Nội', '0245678901', 'ttytbd@hanoi.gov.vn', '3'),
('CS06', N'Trung tâm Y tế Quận Đống Đa', N'60 Tôn Đức Thắng, Đống Đa, Hà Nội', '0246789012', 'ttytdd@hanoi.gov.vn', '3'),
('CS07', N'Trung tâm Y tế Quận Hai Bà Trưng', N'15 Bạch Mai, Hai Bà Trưng, Hà Nội', '0247890123', 'ttythbt@hanoi.gov.vn', '3'),
('CS08', N'Trung tâm Y tế Huyện Gia Lâm', N'234 Nguyễn Đức Thuận, Gia Lâm, Hà Nội', '0248901234', 'ttytgl@hanoi.gov.vn', '3'),
('CS09', N'Cơ sở Quận 1', N'123 Nguyễn Huệ, Quận 1, TP.HCM', '0283123456', 'coso.q1@hcm.gov.vn', '2'),
('CS10', N'Trung tâm Y tế Quận Bình Thạnh', N'88 Đinh Tiên Hoàng, Bình Thạnh, TP.HCM', '0289876543', 'ttytbt@hcm.gov.vn', '3');


INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Cơ sở Quận 1 (5 cán bộ)
('CS09', 'CBPTH002', N'Bác sĩ', '2023-02-15', NULL),
('CS09', 'CBLTP003', N'Y tá', '2023-04-10', NULL),
('CS09', 'CBTCT009', N'Trưởng khoa', '2023-04-20', NULL),
('CS09', 'CBMVT029', N'Nhân viên hành chính', '2023-05-25', NULL),
-- Cơ sở Hoàn Kiếm (5 cán bộ)
('CS03', 'CBLHD147', N'Trưởng khoa', '2023-01-05', NULL),
('CS03', 'CBLNT023', N'Bác sĩ', '2023-02-12', NULL),
('CS03', 'CBLTP003', N'Y tá', '2023-03-08','2023-04-08'),
('CS03', 'CBMVT029', N'Nhân viên y tế', '2023-04-10', NULL),
('CS03', 'CBNBT018', N'Nhân viên hành chính', '2023-05-20', NULL),

-- Trung tâm Y tế Huyện Gia Lâm (5 cán bộ)
('CS08', 'CBHBT005', N'Bác sĩ', '2023-01-05', NULL),

-- Trung tâm Y tế Quận Bình Thạnh (5 cán bộ)
('CS10', 'CBPTH002', N'Trưởng khoa', '2023-01-12', NULL),
('CS10', 'CBDHA028', N'Y tá', '2023-03-30', NULL),
('CS10', 'CBPTK016', N'Nhân viên y tế', '2023-04-15', NULL),
('CS10', 'CBPVL007', N'Nhân viên hành chính', '2023-05-10', NULL),
('CS10', 'CBPTH014', N'Bác sĩ', '2023-02-22', '2024-04-15'),
-- Trung tâm Y tế Quận Hai Bà Trưng (4 cán bộ)
('CS07', 'CBHNN203', N'Trưởng khoa', '2023-01-20', NULL),
('CS07', 'CBBTA006', N'Y tá', '2023-03-08', NULL),
('CS07', 'CBTNN028', N'Bác sĩ', '2023-04-02', NULL),
('CS07', 'CBTTD015', N'Nhân viên hành chính', '2023-05-12', NULL),

-- Trung tâm Y tế Quận Ba Đình (5 cán bộ)
('CS05', 'CBTTN012', N'Bác sĩ', '2023-01-05', NULL),
('CS05', 'CBTVH024', N'Trưởng khoa', '2023-02-10', NULL),
('CS05', 'CBVTA005', N'Y tá', '2023-03-20', NULL),
('CS05', 'CBLHV266', N'Nhân viên hành chính', '2023-04-15', NULL),
('CS05', 'CBDBH010', N'Nhân viên hành chính', '2023-02-22', '2024-04-27'),

-- Trung tâm Y tế Quận Đống Đa (5 cán bộ)
('CS06', 'CBLLP008', N'Trưởng khoa', '2023-01-15', NULL),
('CS06', 'CBLLT027', N'Bác sĩ', '2023-02-25', NULL),
('CS06', 'CBLMT045', N'Y tá', '2023-03-12', NULL),
('CS06', 'CBBTN094', N'Nhân viên hành chính', '2023-04-10', NULL),
('CS06', 'CBDBP020', N'Y tá', '2023-03-12', '2023-06-15');

-- Thêm các cán bộ còn thiếu vào bảng CAN_BO_CO_SO
INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Cơ sở Quận Bình Thạnh (CS3HCM010)
('CS10', 'CBNVA001', N'Nhân viên y tế', '2023-01-01', NULL),
('CS10', 'CBNTH021', N'Nhân viên hành chính', '2023-02-15', NULL),

-- Trung tâm Y tế Huyện Gia Lâm (CS3-HN008)
('CS08', 'CBPHT025', N'Y tá', '2023-03-10', NULL),

-- Trung tâm Y tế Quận Đống Đa (CS3HN006)
('CS06', 'CBNMC026', N'Bác sĩ', '2023-04-05', NULL);

-- code check xem mã cán bộ trong bảng cán bộ cơ sở không trùng với bảng cán bộ y tế


-- Nhập liệu bảng phiếu khám

-- Nhập liệu vaccine
INSERT INTO VACCINE (Ma_Vaccine, Ten_Vaccine, Loai_Khang_Nguyen, Hang_San_Xuat, So_Lieu_Tiem, Trang_Thai)
VALUES
('VNBGC2305', N'Vaccine BCG', N'Vi khuẩn sống giảm độc lực', N'Viện Vaccine Việt Nam', 1, 1),
('USMRN2306', N'Pfizer-BioNTech COVID-19', N'mRNA', N'Pfizer-BioNTech', 2, 1),
('GBADV2307', N'AstraZeneca COVID-19', N'Vector virus', N'AstraZeneca', 2, 1),
('CHINA2308', N'Sinopharm COVID-19', N'Virus bất hoạt', N'Sinopharm', 2, 1),
('RUSSP2309', N'Sputnik V', N'Vector virus', N'Gamaleya', 2, 1),
('USMRN2310', N'Moderna COVID-19', N'mRNA', N'Moderna', 2, 1),
('VNFVR2311', N'Vero Cell', N'Virus bất hoạt', N'Viện Vaccine Việt Nam', 2, 1),
('FRAFLU2312', N'Vaxigrip Tetra', N'Protein tái tổ hợp', N'Sanofi Pasteur', 1, 1),
('JAPJP2312', N'JEVAX (Viêm não Nhật Bản)', N'Vi rút bất hoạt', N'Biken', 2, 1),
('KORHBP2312', N'Hepavax-Gene', N'Protein tái tổ hợp', N'Korean Green Cross', 3, 1),

('FRDTP2411', N'Tetraxim (Bạch hầu - Uốn ván - Ho gà - Bại liệt)', N'Giải độc tố', N'Sanofi Pasteur', 4, 1),
('USBVG2412', N'Vaccine viêm gan A-B (Twinrix)', N'Protein tái tổ hợp', N'GlaxoSmithKline', 3, 1),
('VNRVG2413', N'Vero-Rab (Dại)', N'Virus bất hoạt', N'VABIOTECH', 3, 1),
('JPNIP2414', N'IMOJEV (Viêm não Nhật Bản)', N'Virus sống giảm độc lực', N'Sanofi Pasteur', 1, 1),
('USMEN2415', N'Menactra (Viêm màng não mô cầu)', N'Polysaccharide', N'Sanofi Pasteur', 2, 1),
('CHTYP2416', N'Typhim Vi (Thương hàn)', N'Polysaccharide', N'Sanofi Pasteur', 1, 1),
('VNPEN2417', N'Pediacel (Bạch hầu, Uốn ván, Ho gà, Bại liệt, Hib)', N'Giải độc tố & Protein tái tổ hợp', N'Sanofi Pasteur', 4, 1),
('DEZOS2418', N'Zostavax (Zona thần kinh)', N'Virus sống giảm độc lực', N'Merck & Co.', 1, 1),
('USHPV2419', N'Cervarix (HPV - ung thư cổ tử cung)', N'Protein tái tổ hợp', N'GlaxoSmithKline', 2, 1),
('INROT2420', N'Rotarix (Tiêu chảy do Rotavirus)', N'Virus sống giảm độc lực', N'GlaxoSmithKline', 2, 1);

UPDATE Vaccine
SET Ma_Vaccine = 
    CASE 
        WHEN Ma_Vaccine = 'CHTYP2416' THEN 'CHTYP2410'
        WHEN Ma_Vaccine = 'DEZOS2418' THEN 'DEZOS2410'
        WHEN Ma_Vaccine = 'INROT2420' THEN 'INROT2410'
        WHEN Ma_Vaccine = 'JPNIP2414' THEN 'JPNIP2410'
        WHEN Ma_Vaccine = 'USHPV2419' THEN 'USHPV2410'
        WHEN Ma_Vaccine = 'USMEN2415' THEN 'USMEN2410'
        WHEN Ma_Vaccine = 'VNPEN2417' THEN 'VNPEN2410'
        ELSE Ma_Vaccine
    END
WHERE Ma_Vaccine IN ('CHTYP2416', 'DEZOS2418', 'INROT2420', 'JPNIP2414', 'USHPV2419', 'USMEN2415', 'VNPEN2417');

-- Nhập data cho bảng Lô vaccine 

INSERT INTO LO_VACCINE (Ma_Lo, Ma_Vaccine, So_Lieu_Vaccine_Ban_Dau, Ngay_San_Xuat, Han_Su_Dung, Xuat_Xu, Tinh_Trang) VALUES 
('COVID230801', 'CHINA2308', 1523, '2023-08-01', '2026-08-01', N'Sinopharm', N'Đang phân phối'),
('TYP241002', 'CHTYP2410', 1789, '2024-10-01', '2027-10-01', N'Sanofi Pasteur', N'Sẵn sàng sử dụng'),
('ZOS241003', 'DEZOS2410', 1342, '2024-10-01', '2027-10-01', N'Merck & Co.', N'Đang phân phối'),
('FLU231204', 'FRAFLU2312', 1675, '2023-12-01', '2026-12-01', N'Sanofi Pasteur', N'Đang lưu kho'),
('DTP241105', 'FRDTP2411', 2104, '2024-11-01', '2027-11-01', N'Sanofi Pasteur', N'Sẵn sàng sử dụng'),
('ADV230706', 'GBADV2307', 1892, '2023-07-01', '2026-07-01', N'AstraZeneca', N'Đang phân phối'),
('ROT241007', 'INROT2410', 1456, '2024-10-01', '2027-10-01', N'GlaxoSmithKline', N'Đang lưu kho'),
('JEV231208', 'JAPJP2312', 1733, '2023-12-01', '2026-12-01', N'Biken', N'Sẵn sàng sử dụng'),
('IMJ241009', 'JPNIP2410', 1328, '2024-10-01', '2027-10-01', N'Sanofi Pasteur', N'Đang phân phối'),
('HBP231210', 'KORHBP2312', 1980, '2023-12-01', '2026-12-01', N'Korean Green Cross', N'Đang lưu kho'),


('SPT230911', 'RUSSP2309', 1572, '2023-09-01', '2026-09-01', N'Gamaleya', N'Đang phân phối'),
('HAVB241212', 'USBVG2412', 1754, '2024-12-01', '2027-12-01', N'GlaxoSmithKline', N'Sẵn sàng sử dụng'),
('HPV241013', 'USHPV2410', 1389, '2024-10-01', '2027-10-01', N'GlaxoSmithKline', N'Đang phân phối'),
('MEN241014', 'USMEN2410', 1648, '2024-10-01', '2027-10-01', N'Sanofi Pasteur', N'Đang lưu kho'),
('MRN230615', 'USMRN2306', 1823, '2023-06-01', '2026-06-01', N'Pfizer-BioNTech', N'Sẵn sàng sử dụng'),
('MRN231016', 'USMRN2310', 1452, '2023-10-01', '2026-10-01', N'Moderna', N'Đang phân phối'),
('BCG230517', 'VNBGC2305', 1335, '2023-05-01', '2026-05-01', N'Viện Vaccine Việt Nam', N'Đang lưu kho'),
('VER231118', 'VNFVR2311', 1740, '2023-11-01', '2026-11-01', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('PEN241019', 'VNPEN2410', 2108, '2024-10-01', '2027-10-01', N'Sanofi Pasteur', N'Đang lưu kho'),
('RAB241320', 'VNRVG2413', 1950, '2024-12-01', '2027-12-01', N'VABIOTECH', N'Đang lưu kho'),

('HBP231221', 'KORHBP2312', 2050, '2023-12-15', '2026-12-15', N'Korean Green Cross', N'Đang lưu kho'),
('SPT230922', 'RUSSP2309', 1623, '2023-09-10', '2026-09-10', N'Gamaleya', N'Đang phân phối'),
('HAVB241223', 'USBVG2412', 1890, '2024-12-05', '2027-12-05', N'GlaxoSmithKline', N'Sẵn sàng sử dụng'),
('HPV241024', 'USHPV2410', 1492, '2024-10-10', '2027-10-10', N'GlaxoSmithKline', N'Đang phân phối'),
('MEN241025', 'USMEN2410', 1705, '2024-10-15', '2027-10-15', N'Sanofi Pasteur', N'Đang lưu kho'),
('MRN230626', 'USMRN2306', 1930, '2023-06-05', '2026-06-05', N'Pfizer-BioNTech', N'Sẵn sàng sử dụng'),
('MRN231027', 'USMRN2310', 1530, '2023-10-12', '2026-10-12', N'Moderna', N'Đang phân phối'),
('BCG230528', 'VNBGC2305', 1405, '2023-05-08', '2026-05-08', N'Viện Vaccine Việt Nam', N'Đang lưu kho'),
('VER231129', 'VNFVR2311', 1820, '2023-11-05', '2026-11-05', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('PEN241030', 'VNPEN2410', 2200, '2024-10-20', '2027-10-20', N'Sanofi Pasteur', N'Đang lưu kho'),

('PEN250151', 'VNPEN2410', 2300, '2025-01-10', '2028-01-10', N'Sanofi Pasteur', N'Sẵn sàng sử dụng'),
('HAVB250152', 'USBVG2412', 1950, '2025-01-12', '2028-01-12', N'GlaxoSmithKline', N'Đang lưu kho'),
('BCG250153', 'VNBGC2305', 1500, '2025-01-15', '2028-01-15', N'Viện Vaccine Việt Nam', N'Đang lưu kho'),
('MRN250154', 'USMRN2310', 1600, '2025-01-18', '2028-01-18', N'Moderna', N'Đang phân phối'),
('MRN250155', 'USMRN2306', 2000, '2025-01-20', '2028-01-20', N'Pfizer-BioNTech', N'Sẵn sàng sử dụng'),
('VER250156', 'VNFVR2311', 1850, '2025-01-22', '2028-01-22', N'Viện Vaccine Việt Nam', N'Đang lưu kho'),
('HPV250157', 'USHPV2410', 1550, '2025-01-25', '2028-01-25', N'GlaxoSmithKline', N'Đang phân phối'),
('MEN250158', 'USMEN2410', 1750, '2025-01-27', '2028-01-27', N'Sanofi Pasteur', N'Sẵn sàng sử dụng');

INSERT INTO LO_VACCINE (Ma_Lo, Ma_Vaccine, So_Lieu_Vaccine_Ban_Dau, Ngay_San_Xuat, Han_Su_Dung, Xuat_Xu, Tinh_Trang) 
VALUES 
('CHINA230801', 'CHINA2308', 1523, '2023-08-01', '2026-08-01', N'Sinopharm', N'Đang phân phối'),
('CHTYP241001', 'CHTYP2410', 1800, '2024-10-05', '2027-10-05', N'Trung Quốc', N'Đang phân phối'),
('DEZOS241001', 'DEZOS2410', 2000, '2024-10-10', '2027-10-10', N'Đức', N'Đang phân phối'),
('FRAFLU231201', 'FRAFLU2312', 1500, '2023-12-15', '2026-12-15', N'Pháp', N'Đang phân phối'),
('FRDTP241101', 'FRDTP2411', 2100, '2024-11-12', '2027-11-12', N'Pháp', N'Đang phân phối'),
('GBADV230701', 'GBADV2307', 1600, '2023-07-20', '2026-07-20', N'Anh', N'Đang phân phối'),
('INROT241001', 'INROT2410', 1750, '2024-10-22', '2027-10-22', N'Ấn Độ', N'Đang phân phối'),
('JAPJP231201', 'JAPJP2312', 1450, '2023-12-30', '2026-12-30', N'Nhật Bản', N'Đang phân phối'),
('JPNIP241001', 'JPNIP2410', 1900, '2024-10-15', '2027-10-15', N'Nhật Bản', N'Đang phân phối'),
('KORHBP231201', 'KORHBP2312', 1700, '2023-12-05', '2026-12-05', N'Hàn Quốc', N'Đang phân phối'),
('RUSSP230901', 'RUSSP2309', 1650, '2023-09-25', '2026-09-25', N'Nga', N'Đang phân phối'),
('USBVG241201', 'USBVG2412', 1850, '2024-12-10', '2027-12-10', N'Mỹ', N'Đang phân phối'),
('USHPV241001', 'USHPV2410', 1950, '2024-10-08', '2027-10-08', N'Mỹ', N'Đang phân phối'),
('USMEN241001', 'USMEN2410', 1550, '2024-10-20', '2027-10-20', N'Mỹ', N'Đang phân phối'),
('USMRN230601', 'USMRN2306', 2100, '2023-06-15', '2026-06-15', N'Mỹ', N'Đang phân phối'),
('USMRN231001', 'USMRN2310', 2000, '2023-10-10', '2026-10-10', N'Mỹ', N'Đang phân phối'),
('VNBGC230501', 'VNBGC2305', 1750, '2023-05-10', '2026-05-10', N'Việt Nam', N'Đang phân phối'),
('VNFVR231101', 'VNFVR2311', 1600, '2023-11-18', '2026-11-18', N'Việt Nam', N'Đang phân phối'),
('VNPEN241001', 'VNPEN2410', 2200, '2024-10-25', '2027-10-25', N'Việt Nam', N'Đang phân phối'),
('VNRVG241201', 'VNRVG2413', 1500, '2024-12-01', '2027-12-01', N'Việt Nam', N'Đang phân phối');


INSERT INTO LO_VACCINE (Ma_Lo, Ma_Vaccine, So_Lieu_Vaccine_Ban_Dau, Ngay_San_Xuat, Han_Su_Dung, Xuat_Xu, Tinh_Trang) VALUES 
('BCG240344', 'VNBGC2305', 1500, '2024-03-01', '2027-03-01', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('BCG240356', 'VNBGC2305', 1400, '2024-03-05', '2027-03-05', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('BCG240399', 'VNBGC2305', 1600, '2024-03-10', '2027-03-10', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('BCG240398', 'VNBGC2305', 1450, '2024-03-15', '2027-03-15', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('BCG240349', 'VNBGC2305', 1550, '2024-03-20', '2027-03-20', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng');


-- File 1
INSERT INTO LAN_TIEM (Ma_Lan_Tiem, Ma_Benh_Nhan, Ma_Can_Bo, Ma_Co_So, Ngay_Tiem, Ket_Qua_Tiem) VALUES
('LT250122066', 'BNHN210039', 'CBDBH010', 'CS05', '2025-01-22', N'Xảy ra phản ứng'),
('LT250425072', 'BNHN210039', 'CBDBH010', 'CS05', '2025-04-25', N'Thành công'),
('LT250625016', 'BNHN210039', 'CBDBH010', 'CS05', '2025-06-25', N'Thành công'),
('LT250126070', 'BNHN000020', 'CBDBP020', 'CS06', '2025-01-26', N'Thành công'),
('LT250529013', 'BNHN000020', 'CBDBP020', 'CS06', '2025-05-29', N'Thành công'),
('LT250327010', 'BNHN990009', 'CBHBT005', 'CS08', '2025-03-27', N'Xảy ra phản ứng'),
('LT250429077', 'BNHN990009', 'CBHBT005', 'CS08', '2025-04-29', N'Thành công'),
('LT250120063', 'BNHN980017', 'CBPTH002', 'CS10', '2025-01-20', N'Thành công'),
('LT250320102', 'BNHN980017', 'CBPTH002', 'CS10', '2025-03-20', N'Hoãn tiêm'),
('LT250522040', 'BNHN980017', 'CBPTH002', 'CS10', '2025-05-22', N'Thành công'),
('LT250622020', 'BNHN980017', 'CBPTH002', 'CS10', '2025-06-22', N'Thành công');

-- File 2
INSERT INTO LAN_TIEM (Ma_Lan_Tiem, Ma_Benh_Nhan, Ma_Can_Bo, Ma_Co_So, Ngay_Tiem, Ket_Qua_Tiem) VALUES
('LT250129005', 'BNHCM000053', 'CBTVH024', 'CS05', '2025-01-29', N'Thành công'),
('LT250429058', 'BNHCM000053', 'CBTVH024', 'CS05', '2025-04-29', N'Thành công'),
('LT250422026', 'BNHCM030050', 'CBTTN012', 'CS05', '2025-04-22', N'Thành công'),
('LT250122041', 'BNHN010010', 'CBTCT009', 'CS09', '2025-01-22', N'Thành công'),
('LT250524029', 'BNHN010010', 'CBTCT009', 'CS09', '2025-05-24', N'Thành công'),
('LT250422015', 'BNHN990029', 'CBTCT009', 'CS09', '2025-04-22', N'Thành công'),
('LT250222034', 'BNHN220040', 'CBPTH002', 'CS10', '2025-02-22', N'Thành công');


-- File 2: Sửa các mã trùng
INSERT INTO LAN_TIEM (Ma_Lan_Tiem, Ma_Benh_Nhan, Ma_Can_Bo, Ma_Co_So, Ngay_Tiem, Ket_Qua_Tiem) VALUES
('LT250129006', 'BNHCM000053', 'CBTVH024', 'CS05', '2025-01-29', N'Thành công'),
('LT250429059', 'BNHCM000053', 'CBTVH024', 'CS05', '2025-04-29', N'Thành công'),
('LT250422027', 'BNHCM030050', 'CBTTN012', 'CS05', '2025-04-22', N'Thành công'),
('LT250224059', 'BNHN020018', 'CBPHT025', 'CS08', '2025-02-24', N'Thành công'),
('LT250525041', 'BNHN020018', 'CBPHT025', 'CS08', '2025-05-25', N'Thành công'),
('LT250122042', 'BNHN010010', 'CBTCT009', 'CS09', '2025-01-22', N'Thành công'),
('LT250524030', 'BNHN010010', 'CBTCT009', 'CS09', '2025-05-24', N'Thành công'),
('LT250422016', 'BNHN990029', 'CBTCT009', 'CS09', '2025-04-22', N'Xảy ra phản ứng'),
('LT250222035', 'BNHN220040', 'CBPTH002', 'CS10', '2025-02-22', N'Thành công'),
('LT250522030', 'BNHN220040', 'CBPTH002', 'CS10', '2025-05-22', N'Xảy ra phản ứng');

-- File 3: LAN_TIEM (Đã gán đủ Ma_Co_So và loại bỏ bản ghi không hợp lệ)
INSERT INTO LAN_TIEM (Ma_Lan_Tiem, Ma_Benh_Nhan, Ma_Can_Bo, Ma_Co_So, Ngay_Tiem, Ket_Qua_Tiem) VALUES
('LT250120004', 'BNHN210035', 'CBNVA001', 'CS10', '2025-01-20', N'Xảy ra phản ứng'),
('LT250420033', 'BNHN210035', 'CBNVA001', 'CS10', '2025-04-20', N'Thành công'),
('LT250422121', 'BNHN990021', 'CBNVA001', 'CS10', '2025-04-22', N'Thành công'),
('LT250124067', 'BNHN180032', 'CBNMC026', 'CS06', '2025-01-24', N'Thành công'),
('LT250525044', 'BNHN180032', 'CBNMC026', 'CS06', '2025-05-25', N'Thành công'),
('LT250409007', 'BNHN020004', 'CBNMC026', 'CS06', '2025-04-09', N'Xảy ra phản ứng'),
('LT250210031', 'BNHN010023', 'CBNTH021', 'CS10', '2025-02-10', N'Thành công'),
('LT250510001', 'BNHN010023', 'CBNTH021', 'CS10', '2025-05-10', N'Xảy ra phản ứng');


INSERT INTO CHI_TIET_LAN_TIEM (Ma_Lan_Tiem, Ma_Vaccine) VALUES
('LT250126070', 'USMEN2410'),
('LT250529013', 'VNPEN2410'),
('LT250122066', 'VNFVR2311'),
('LT250425072', 'VNFVR2311'),
('LT250429077', 'USMRN2310'),
('LT250224059', 'VNPEN2410'),
('LT250122041', 'JAPJP2312'),
('LT250524029', 'JAPJP2312'),
('LT250422015', 'JPNIP2410'),
('LT250222034', 'USBVG2412'),
('LT250120004', 'CHINA2308'),
('LT250420033', 'CHINA2308'),
('LT250422121', 'FRAFLU2312'),
('LT250124067', 'FRDTP2411'),
('LT250525044', 'FRDTP2411'),
('LT250409007', 'DEZOS2410'),
('LT250210031', 'USHPV2410'),
('LT250510001', 'USHPV2410');


INSERT INTO CHI_TIET_LAN_TIEM (Ma_Lan_Tiem, Ma_Vaccine) VALUES
('LT250625016', 'USMRN2310'),
('LT250327010', 'VNFVR2311'),
('LT250525041', 'USMRN2310'),
('LT250120063', 'USMEN2410'),
('LT250320102', 'USMEN2410'),
('LT250522040', 'USMEN2410'),
('LT250622020', 'USMEN2410'),
('LT250129005', 'USMEN2410'),
('LT250429058', 'USMEN2410'),
('LT250422026', 'USMEN2410'),
('LT250129006', 'USMEN2410'),
('LT250429059', 'USMEN2410'),
('LT250422027', 'USMEN2410'),
('LT250122042', 'USMEN2410'),
('LT250524030', 'USMEN2410'),
('LT250422016', 'USMEN2410'),
('LT250222035', 'USMEN2410'),
('LT250522030', 'USMEN2410');


INSERT INTO PHAN_UNG_SAU_TIEM (Ma_Phan_Ung, Ma_Lan_Tiem, Ten_Phan_Ung, Muc_Do_Phan_Ung, Thoi_Diem_Xay_Ra, Thoi_Diem_Ket_Thuc, Ghi_Chu)
VALUES
    ('PU290425MEN312', 'LT250120004', N'Sốt cao', N'Nặng', '2025-04-29 14:00', '2025-04-29 18:30', N'Đã nhập viện theo dõi'),
    ('PU220525BVG347', 'LT250122066', N'Nổi mẩn đỏ', N'Trung bình', '2025-01-22 10:15', '2025-01-22 11:00', N'Dùng thuốc kháng histamin'),
    ('PU220525ROT453', 'LT250327010', N'Sưng tại chỗ tiêm', N'Nhẹ', '2025-03-27 12:30', '2025-03-27 20:00', N'Chườm lạnh tại chỗ'),
    ('PU260525MRN056', 'LT250409007', N'Đau đầu', N'Trung bình', '2025-05-26 16:00', '2025-05-27 09:00', N'Dùng thuốc giảm đau'),
    ('PU020625MRN077', 'LT250422016', N'Chóng mặt', N'Nhẹ', '2025-06-02 14:45', '2025-06-02 17:30', N'Nghỉ ngơi theo dõi'),
    ('PU120625RVG028', 'LT250510001', N'Nôn ói', N'Nặng', '2025-06-12 18:00', '2025-06-13 12:00', N'Đã truyền dịch và theo dõi'),
    ('PU200725RVG368', 'LT250522030', N'Sốt nhẹ', N'Nhẹ', '2025-07-20 09:30', null, N'Nghỉ ngơi theo dõi');



-- File 1
INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Benh_Nhan, Ma_Can_Bo, Ma_Co_So, Ngay_Kham, Noi_Dung, Chi_Dinh) VALUES
('PK250101001', 'BNHN981001', 'CBLTP003', 'CS03', '2025-01-05', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK250101002', 'BNHN990002', 'CBPTH002', 'CS10', '2025-01-12', N'Huyết áp cao, theo dõi thêm', N'Không đủ điều kiện'),
('PK250101003', 'BNHN990002', 'CBPTH002', 'CS10', '2025-01-19', N'Huyết áp ổn định', N'Đủ điều kiện tiêm'),
('PK250102005', 'BNHN020004', 'CBHBT005', 'CS08', '2025-02-14', N'Tiền sử dị ứng nhẹ', N'Đủ điều kiện tiêm'),
('PK250102006', 'BNHN030005', 'CBTVH024', 'CS05', '2025-02-22', N'Đang bị sốt', N'Hủy bỏ'),
('PK250103007', 'BNHN030005', 'CBTVH024', 'CS05', '2025-03-22', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK250102009', 'BNHN980007', 'CBPVL007', 'CS10', '2025-02-28', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK250103010', 'BNHN980007', 'CBPVL007', 'CS10', '2025-03-07', N'Tình trạng cải thiện', N'Đủ điều kiện tiêm'),
('PK250103011', 'BNHN000008', 'CBLLP008', 'CS06', '2025-03-15', N'Thường xuyên chóng mặt', N'Hủy bỏ'),
('PK250104012', 'BNHN000008', 'CBLLP008', 'CS06', '2025-04-15', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250102013', 'BNHN990009', 'CBTCT009', 'CS09', '2025-02-20', N'Triệu chứng ổn định', N'Đủ điều kiện tiêm'),
('PK250101014', 'BNHN010010', 'CBDBH010', 'CS05', '2025-01-11', N'Cảm cúm nhẹ', N'Hủy bỏ'),
('PK250102015', 'BNHN010010', 'CBDBH010', 'CS05', '2025-02-11', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250104020', 'BNHN950013', 'CBHBT005', 'CS08', '2025-04-01', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm');
-- File 2
INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Benh_Nhan, Ma_Can_Bo, Ma_Co_So, Ngay_Kham, Noi_Dung, Chi_Dinh) VALUES
('PK250103021', 'BNHN000014', 'CBPTH002', 'CS10', '2025-03-10', N'Khám sức khỏe định kỳ', N'Đủ điều kiện tiêm'),
('PK250103022', 'BNHN010015', 'CBLTP003', 'CS09', '2025-03-15', N'Huyết áp không ổn định', N'Không đủ điều kiện'),
('PK250103023', 'BNHN010015', 'CBLTP003', 'CS09', '2025-03-22', N'Tình trạng cải thiện', N'Đủ điều kiện tiêm'),
('PK250102026', 'BNHN980017', 'CBHBT005', 'CS08', '2025-02-14', N'Sốt cao, cần theo dõi', N'Không đủ điều kiện'),
('PK250103027', 'BNHN980017', 'CBHBT005', 'CS08', '2025-03-02', N'Hạ sốt, sức khỏe tốt', N'Đủ điều kiện tiêm'),
('PK250103028', 'BNHN020018', 'CBTVH024', 'CS05', '2025-03-05', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK250103029', 'BNHN020018', 'CBTTN012', 'CS05', '2025-03-12', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK250103031', 'BNHN000020', 'CBPVL007', 'CS10', '2025-03-14', N'Cảm cúm nhẹ', N'Không đủ điều kiện'),
('PK250103032', 'BNHN000020', 'CBPVL007', 'CS10', '2025-03-21', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103033', 'BNHN990021', 'CBLLP008', 'CS06', '2025-03-11', N'Sốt nhẹ', N'Không đủ điều kiện'),
('PK250103034', 'BNHN990021', 'CBLLP008', 'CS06', '2025-03-18', N'Tình trạng tốt', N'Đủ điều kiện tiêm'),
('PK250103035', 'BNHN030022', 'CBTNN028', 'CS07', '2025-03-20', N'Không có vấn đề sức khỏe', N'Đủ điều kiện tiêm'),
('PK250103039', 'BNHN000025', 'CBHBT005', 'CS08', '2025-03-28', N'Triệu chứng nhẹ, cần theo dõi', N'Không đủ điều kiện'),
('PK250104040', 'BNHN000025', 'CBHBT005', 'CS08', '2025-04-04', N'Không còn triệu chứng', N'Đủ điều kiện tiêm');
-- File 3
INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Benh_Nhan, Ma_Can_Bo, Ma_Co_So, Ngay_Kham, Noi_Dung, Chi_Dinh) VALUES
('PK250103521', 'BNHN020026', 'CBLTP003', 'CS03', '2025-03-10', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK250103522', 'BNHN030027', 'CBPTH002', 'CS10', '2025-03-12', N'Huyết áp không ổn định, theo dõi thêm', N'Không đủ điều kiện'),
('PK250103523', 'BNHN030027', 'CBPTH002', 'CS10', '2025-03-19', N'Huyết áp ổn định', N'Đủ điều kiện tiêm'),
('PK250103525', 'BNHN990029', 'CBHBT005', 'CS08', '2025-03-14', N'Tiền sử dị ứng nhẹ', N'Đủ điều kiện tiêm'),
('PK250103526', 'BNHN970030', 'CBDBH010', 'CS05', '2025-03-11', N'Đang bị sốt', N'Hủy bỏ'),
('PK250103527', 'BNHN970030', 'CBDBH010', 'CS05', '2025-03-21', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK250103529', 'BNHN180032', 'CBPVL007', 'CS10', '2025-03-18', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK250103530', 'BNHN180032', 'CBPVL007', 'CS10', '2025-03-25', N'Tình trạng cải thiện', N'Đủ điều kiện tiêm'),
('PK250103531', 'BNHN190033', 'CBLLP008', 'CS06', '2025-03-14', N'Thường xuyên chóng mặt', N'Hủy bỏ'),
('PK250103532', 'BNHN190033', 'CBLLP008', 'CS06', '2025-04-14', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103534', 'BNHN210035', 'CBDBH010', 'CS05', '2025-03-11', N'Cảm cúm nhẹ', N'Hủy bỏ'),
('PK250103535', 'BNHN210035', 'CBDBH010', 'CS05', '2025-03-20', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103540', 'BNHN200038', 'CBHBT005', 'CS08', '2025-03-29', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm');
-- File 4
INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Benh_Nhan, Ma_Can_Bo, Ma_Co_So, Ngay_Kham, Noi_Dung, Chi_Dinh) VALUES
('PK250103221', 'BNHN210039', 'CBLTP003', 'CS03', '2025-03-10', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK250103222', 'BNHN210039', 'CBLTP003', 'CS03', '2025-03-17', N'Huyết áp cao, cần theo dõi', N'Không đủ điều kiện'),
('PK250103223', 'BNHN220040', 'CBPTH002', 'CS10', '2025-03-05', N'Chóng mặt kéo dài', N'Hủy bỏ'),
('PK250104224', 'BNHN220040', 'CBPTH002', 'CS10', '2025-04-05', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250101227', 'BNHN920042', 'CBHBT005', 'CS08', '2025-01-18', N'Cảm cúm nhẹ', N'Hủy bỏ'),
('PK250102228', 'BNHN920042', 'CBHBT005', 'CS08', '2025-02-18', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103229', 'BNHN950043', 'CBDBH010', 'CS05', '2025-03-08', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm')--Nhập data cho chi tiết lô

INSERT INTO CHI_TIET_LO_VACCINE (Ma_Lo, Ma_Co_So, So_Lieu_Da_Su_Dung, So_Lieu_Ton_Kho, Ngay_Nhap, Ngay_Xuat)  
VALUES  
('BCG230517', 'KH01', 0, 1335, '2023-05-05', NULL),  
('BCG230528', 'KH01', 0, 1405, '2023-05-10', NULL),  
('BCG250153', 'KH01', 0, 1500, '2025-01-20', NULL),  
('FLU231204', 'KH01', 0, 1675, '2023-12-05', NULL),  
('HBP231210', 'KH01', 0, 1980, '2023-12-05', NULL),  
('HBP231221', 'KH01', 0, 2050, '2023-12-18', NULL),  
('MEN241014', 'KH01', 0, 1648, '2024-10-05', NULL),  
('MEN241025', 'KH01', 0, 1705, '2024-10-20', NULL),  
('PEN241019', 'KH01', 0, 2108, '2024-10-05', NULL),  
('PEN241030', 'KH01', 0, 2200, '2024-10-25', NULL),  
('VER250156', 'KH01', 0, 1850, '2025-01-25', NULL),  
('RAB241320', 'KH01', 0, 1950, '2024-12-05', NULL),  
('ROT241007', 'KH01', 0, 1456, '2024-10-05', NULL);

INSERT INTO CHI_TIET_LO_VACCINE (Ma_Lo, Ma_Co_So, So_Lieu_Da_Su_Dung, So_Lieu_Ton_Kho, Ngay_Nhap, Ngay_Xuat)  
VALUES  
('CHINA230801', 'CS09', 123, 1400, '2024-03-01', NULL),  
('CHTYP241001', 'CS03', 150, 1650, '2024-03-02', NULL),  
('DEZOS241001', 'CS02', 150, 1850, '2024-03-03', NULL),  
('FRAFLU231201', 'CS04', 120, 1380, '2024-03-04', NULL),  
('FRDTP241101', 'CS08', 200, 1900, '2024-03-05', NULL),  
('GBADV230701', 'CS10', 120, 1480, '2024-03-06', NULL),  
('INROT241001', 'CS07', 150, 1600, '2024-03-07', NULL),  
('JAPJP231201', 'CS05', 100, 1350, '2024-03-08', NULL),  
('JPNIP241001', 'CS06', 150, 1750, '2024-03-09', NULL),  
('KORHBP231201', 'CS09', 120, 1580, '2024-03-10', NULL),  
('RUSSP230901', 'CS03', 140, 1510, '2024-03-11', NULL),  
('USBVG241201', 'CS02', 180, 1670, '2024-03-12', NULL),  
('USHPV241001', 'CS04', 170, 1780, '2024-03-13', NULL),  
('USMEN241001', 'CS08', 130, 1420, '2024-03-14', NULL),  
('USMRN230601', 'CS10', 200, 1900, '2024-03-15', NULL),  
('USMRN231001', 'CS07', 160, 1840, '2024-03-16', NULL),  
('VNBGC230501', 'CS05', 120, 1630, '2024-03-17', NULL),  
('VNFVR231101', 'CS06', 140, 1460, '2024-03-18', NULL),  
('VNPEN241001', 'CS09', 150, 2050, '2024-03-19', NULL),  
('VNRVG241201', 'CS03', 110, 1390, '2024-03-20', NULL);

INSERT INTO CHI_TIET_LO_VACCINE (Ma_Lo, Ma_Co_So, So_Lieu_Da_Su_Dung, So_Lieu_Ton_Kho, Ngay_Nhap, Ngay_Xuat)  
VALUES  
('ADV230706', 'CS09', 50, 1842, '2024-02-01', NULL),  
('BCG240344', 'CS03', 30, 1470, '2024-02-05', NULL),  
('BCG240349', 'CS02', 40, 1510, '2024-02-10', NULL),  
('BCG240356', 'CS04', 25, 1375, '2024-02-12', NULL),  
('BCG240398', 'CS08', 20, 1430, '2024-02-15', NULL),  
('BCG240399', 'CS10', 35, 1565, '2024-02-20', NULL),  
('COVID230801', 'CS07', 60, 1463, '2024-02-25', NULL),  
('DTP241105', 'CS05', 45, 2059, '2024-03-01', NULL),  
('HAVB241212', 'CS06', 50, 1704, '2024-03-05', NULL),  
('HAVB241223', 'CS09', 55, 1835, '2024-03-10', NULL),  
('HAVB250152', 'CS03', 40, 1910, '2024-03-12', NULL),  
('HPV241013', 'CS02', 30, 1359, '2024-03-15', NULL),  
('HPV241024', 'CS04', 35, 1457, '2024-03-18', NULL),  
('HPV250157', 'CS08', 50, 1500, '2024-03-20', NULL),  
('IMJ241009', 'CS10', 20, 1308, '2024-03-25', NULL),  
('JEV231208', 'CS07', 60, 1673, '2024-03-28', NULL),  
('MEN250158', 'CS05', 45, 1705, '2024-03-30', NULL),  
('MRN230615', 'CS06', 50, 1773, '2024-04-02', NULL),  
('MRN230626', 'CS09', 55, 1875, '2024-04-05', NULL),  
('MRN231016', 'CS03', 40, 1412, '2024-04-08', NULL),  
('MRN231027', 'CS02', 30, 1500, '2024-04-10', NULL),  
('MRN250154', 'CS04', 35, 1565, '2024-04-12', NULL),  
('MRN250155', 'CS08', 50, 1950, '2024-04-15', NULL),  
('PEN250151', 'CS10', 20, 2280, '2024-04-18', NULL),  
('SPT230911', 'CS07', 60, 1512, '2024-04-20', NULL),  
('SPT230922', 'CS05', 45, 1578, '2024-04-22', NULL),  
('TYP241002', 'CS06', 50, 1739, '2024-04-25', NULL),  
('VER231118', 'CS09', 55, 1685, '2024-04-28', NULL),  
('VER231129', 'CS03', 40, 1780, '2024-04-30', NULL),  
('ZOS241003', 'CS02', 30, 1312, '2024-05-02', NULL);



-- Lệnh INSERT dữ liệu vào bảng LICH_HEN (chỉ ngày tháng năm, không giờ phút giây)
INSERT INTO LICH_HEN (Ma_Lich_Hen, Ma_Co_So, Ma_Benh_Nhan, Ngay_Hen, Ngay_Dat_Lich, Ghi_Chu, Tinh_Trang_Lich)
VALUES
('LH050125386', 'CS08', 'BNHN981001', '2025-01-05', '2024-12-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH050125746', 'CS02', 'BNHN920012', '2025-01-05', '2024-12-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH110125836', 'CS05', 'BNHN010010', '2025-01-11', '2024-12-07', N'Khám Tiêm', N'Đã xác nhận'),
('LH120125777', 'CS08', 'BNHN990002', '2025-01-12', '2024-11-24', N'Khám Tiêm', N'Đã xác nhận'),
('LH120125550', 'CS02', 'BNHN991234', '2025-01-12', '2024-12-18', N'Khám Tiêm', N'Đã xác nhận'),
('LH130125534', 'CS04', 'BNHN200034', '2025-01-13', '2024-12-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH180125720', 'CS08', 'BNHN920042', '2025-01-18', '2025-01-06', N'Khám Tiêm', N'Đã xác nhận'),
('LH190125112', 'CS05', 'BNHN990002', '2025-01-19', '2024-11-29', N'Khám Tiêm', N'Đã xác nhận'),
('LH200125853', 'CS02', 'BNHN210035', '2025-01-20', '2024-12-22', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH200125850', 'CS03', 'BNHN980017', '2025-01-20', '2024-12-25', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH220125139', 'CS03', 'BNHN010010', '2025-01-22', '2024-12-08', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH220125170', 'CS04', 'BNHN210039', '2025-01-22', '2025-01-07', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH240125262', 'CS05', 'BNHN180032', '2025-01-24', '2024-12-27', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250125376', 'CS04', 'BNHN010003', '2025-01-25', '2024-12-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH260125807', 'CS05', 'BNHN000020', '2025-01-26', '2024-12-12', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH290125280', 'CS10', 'BNHCM000053', '2025-01-29', '2025-01-02', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH300125414', 'CS04', 'BNHN970019', '2025-01-30', '2024-12-07', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH010225208', 'CS09', 'BNHCM020049', '2025-02-01', '2024-12-17', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH010225141', 'CS08', 'BNHN970024', '2025-02-01', '2024-12-28', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH100225286', 'CS05', 'BNHN010023', '2025-02-10', '2025-01-21', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH110225268', 'CS03', 'BNHN010010', '2025-02-11', '2025-01-16', N'Khám Tiêm', N'Đã xác nhận'),
('LH140225719', 'CS05', 'BNHN980017', '2025-02-14', '2025-01-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH140225786', 'CS05', 'BNHN020004', '2025-02-14', '2024-12-30', N'Khám Tiêm', N'Đã xác nhận'),
('LH150225572', 'CS10', 'BNHCM990054', '2025-02-15', '2025-01-08', N'Khám Tiêm', N'Đã xác nhận'),
('LH160225347', 'CS07', 'BNHN970006', '2025-02-16', '2025-01-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH180225492', 'CS08', 'BNHN920042', '2025-02-18', '2025-01-17', N'Khám Tiêm', N'Đã xác nhận'),
('LH200225302', 'CS09', 'BNHCM020049', '2025-02-20', '2025-01-08', N'Khám Tiêm', N'Đã xác nhận');

INSERT INTO LICH_HEN (Ma_Lich_Hen, Ma_Co_So, Ma_Benh_Nhan, Ngay_Hen, Ngay_Dat_Lich, Ghi_Chu, Tinh_Trang_Lich)
VALUES
('LH200225895', 'CS08', 'BNHN990009', '2025-02-20', '2025-01-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH200225172', 'CS02', 'BNHN010003', '2025-02-20', '2025-01-01', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH200225523', 'CS02', 'BNHN970030', '2025-02-20', '2025-01-26', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH220225536', 'CS06', 'BNHN220040', '2025-02-22', '2025-01-22', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH220225617', 'CS02', 'BNHN950041', '2025-02-22', '2024-12-29', N'Khám Tiêm', N'Đã xác nhận'),
('LH220225595', 'CS05', 'BNHN030005', '2025-02-22', '2024-12-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH240225660', 'CS06', 'BNHN020018', '2025-02-24', '2024-12-27', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH280225316', 'CS05', 'BNHN980007', '2025-02-28', '2025-02-10', N'Khám Tiêm', N'Đã xác nhận'),
('LH010325949', 'CS09', 'BNHCM980046', '2025-03-01', '2025-02-15', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH020325334', 'CS05', 'BNHN980017', '2025-03-02', '2025-02-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH040325180', 'CS02', 'BNHN950013', '2025-03-04', '2025-01-18', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH050325416', 'CS06', 'BNHN020018', '2025-03-05', '2025-02-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH050325655', 'CS07', 'BNHN220040', '2025-03-05', '2025-02-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH070325318', 'CS05', 'BNHN980007', '2025-03-07', '2025-02-11', N'Khám Tiêm', N'Đã xác nhận'),
('LH080325352', 'CS04', 'BNHN970019', '2025-03-08', '2025-02-19', N'Khám Tiêm', N'Đã xác nhận'),
('LH080325313', 'CS02', 'BNHN950043', '2025-03-08', '2025-01-21', N'Khám Tiêm', N'Đã xác nhận'),
('LH100325686', 'CS04', 'BNHN210039', '2025-03-10', '2025-02-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH100325819', 'CS03', 'BNHN020026', '2025-03-10', '2025-02-23', N'Khám Tiêm', N'Đã xác nhận'),
('LH100325659', 'CS10', 'BNHCM020049', '2025-03-10', '2025-02-02', N'Khám Tiêm', N'Đã xác nhận'),
('LH100325206', 'CS06', 'BNHN000014', '2025-03-10', '2025-01-25', N'Khám Tiêm', N'Đã xác nhận'),
('LH110325599', 'CS05', 'BNHN990021', '2025-03-11', '2025-02-25', N'Khám Tiêm', N'Đã xác nhận'),
('LH110325737', 'CS02', 'BNHN210035', '2025-03-11', '2025-02-19', N'Khám Tiêm', N'Đã xác nhận'),
('LH110325398', 'CS03', 'BNHN970030', '2025-03-11', '2025-01-11', N'Khám Tiêm', N'Đã xác nhận'),
('LH120325429', 'CS06', 'BNHN030027', '2025-03-12', '2025-01-16', N'Khám Tiêm', N'Đã xác nhận'),
('LH120325830', 'CS08', 'BNHN000044', '2025-03-12', '2025-02-27', N'Khám Tiêm', N'Đã xác nhận'),
('LH120325488', 'CS07', 'BNHN020018', '2025-03-12', '2025-03-04', N'Khám Tiêm', N'Đã xác nhận'),
('LH140325301', 'CS08', 'BNHN000020', '2025-03-14', '2025-03-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH140325874', 'CS08', 'BNHN190033', '2025-03-14', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH140325826', 'CS04', 'BNHN990029', '2025-03-14', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH140325486', 'CS10', 'BNHCM000048', '2025-03-14', '2025-01-18', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH140325416', 'CS08', 'BNHN030011', '2025-03-14', '2025-02-28', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH150325251', 'CS10', 'BNHCM990054', '2025-03-15', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH150325469', 'CS09', 'BNHCM980046', '2025-03-15', '2025-02-11', N'Khám Tiêm', N'Đã xác nhận'),
('LH150325306', 'CS04', 'BNHN980028', '2025-03-15', '2025-02-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH150325562', 'CS06', 'BNHN010015', '2025-03-15', '2025-01-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH150325442', 'CS04', 'BNHN000008', '2025-03-15', '2025-01-19', N'Khám Tiêm', N'Đã xác nhận'),
('LH160325228', 'CS08', 'BNHN170031', '2025-03-16', '2025-02-17', N'Khám Tiêm', N'Đã xác nhận'),
('LH160325340', 'CS05', 'BNHN190037', '2025-03-16', '2025-02-06', N'Khám Tiêm', N'Đã xác nhận'),
('LH170325375', 'CS04', 'BNHN210039', '2025-03-17', '2025-02-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH170325454', 'CS03', 'BNHN030016', '2025-03-17', '2025-03-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH180325894', 'CS08', 'BNHN030011', '2025-03-18', '2025-01-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH180325266', 'CS05', 'BNHN990021', '2025-03-18', '2025-02-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH180325205', 'CS05', 'BNHN180032', '2025-03-18', '2025-02-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH190325872', 'CS06', 'BNHN030027', '2025-03-19', '2025-02-21', N'Khám Tiêm', N'Đã xác nhận'),
('LH200325692', 'CS02', 'BNHN210035', '2025-03-20', '2025-01-30', N'Khám Tiêm', N'Đã xác nhận'),
('LH200325279', 'CS08', 'BNHN030022', '2025-03-20', '2025-02-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH200325320', 'CS03', 'BNHN980017', '2025-03-20', '2025-02-18', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH210325595', 'CS08', 'BNHN000020', '2025-03-21', '2025-01-24', N'Khám Tiêm', N'Đã xác nhận'),
('LH210325608', 'CS08', 'BNHN010045', '2025-03-21', '2025-03-14', N'Khám Tiêm', N'Đã xác nhận');
INSERT INTO LICH_HEN (Ma_Lich_Hen, Ma_Co_So, Ma_Benh_Nhan, Ngay_Hen, Ngay_Dat_Lich, Ghi_Chu, Tinh_Trang_Lich)
VALUES
('LH210325260', 'CS03', 'BNHN970030', '2025-03-21', '2025-03-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325422', 'CS04', 'BNHN950041', '2025-03-22', '2025-01-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325576', 'CS10', 'BNHCM000048', '2025-03-22', '2025-03-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325773', 'CS03', 'BNHN180036', '2025-03-22', '2025-02-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325210', 'CS07', 'BNHN010023', '2025-03-22', '2025-02-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325627', 'CS06', 'BNHN010015', '2025-03-22', '2025-03-03', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325245', 'CS05', 'BNHN030005', '2025-03-22', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH230325180', 'CS06', 'BNHN190037', '2025-03-23', '2025-03-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH230325393', 'CS09', 'BNHCM000053', '2025-03-23', '2025-02-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH240325455', 'CS03', 'BNHN030016', '2025-03-24', '2025-03-08', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325883', 'CS08', 'BNHN030011', '2025-03-25', '2025-01-29', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325198', 'CS10', 'BNHCM970051', '2025-03-25', '2025-01-25', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325121', 'CS08', 'BNHN970024', '2025-03-25', '2025-02-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325863', 'CS05', 'BNHN180032', '2025-03-25', '2025-03-03', N'Khám Tiêm', N'Đã xác nhận'),
('LH270325277', 'CS08', 'BNHN990009', '2025-03-27', '2025-03-07', N'Lịch tiêm vaccine', N'Đã gửi mail'),
('LH280325208', 'CS07', 'BNHN000025', '2025-03-28', '2025-03-13', N'Khám Tiêm', N'Đã gửi mail'),
('LH280325818', 'CS10', 'BNHCM980052', '2025-03-28', '2025-02-01', N'Khám Tiêm', N'Đã gửi mail'),
('LH290325123', 'CS07', 'BNHN200038', '2025-03-29', '2025-02-16', N'Khám Tiêm', N'Đã gửi mail'),
('LH290325339', 'CS05', 'BNHN010023', '2025-03-29', '2025-03-15', N'Khám Tiêm', N'Đã gửi mail'),
('LH300325940', 'CS03', 'BNHN180036', '2025-03-30', '2025-03-15', N'Khám Tiêm', N'Đang chờ'),
('LH300325665', 'CS09', 'BNHCM010055', '2025-03-30', '2025-02-03', N'Khám Tiêm', N'Đang chờ'),
('LH010425294', 'CS10', 'BNHCM990054', '2025-04-01', '2025-02-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH010425206', 'CS09', 'BNHCM980046', '2025-04-01', '2025-02-24', N'Khám Tiêm', N'Đang chờ'),
('LH010425774', 'CS02', 'BNHN950013', '2025-04-01', '2025-02-06', N'Khám Tiêm', N'Đang chờ'),
('LH040425342', 'CS07', 'BNHN000025', '2025-04-04', '2025-03-10', N'Khám Tiêm', N'Đang chờ'),
('LH050425519', 'CS07', 'BNHN220040', '2025-04-05', '2025-03-26', N'Khám Tiêm', N'Đang chờ'),
('LH050425634', 'CS10', 'BNHCM030050', '2025-04-05', '2025-03-20', N'Khám Tiêm', N'Đang chờ'),
('LH050425502', 'CS10', 'BNHCM970051', '2025-04-05', '2025-03-11', N'Khám Tiêm', N'Đang chờ'),
('LH080425862', 'CS10', 'BNHCM980052', '2025-04-08', '2025-02-11', N'Khám Tiêm', N'Đang chờ'),
('LH080425833', 'CS09', 'BNHCM990047', '2025-04-08', '2025-03-30', N'Khám Tiêm', N'Đang chờ'),
('LH090425370', 'CS05', 'BNHN020004', '2025-04-09', '2025-03-17', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH100425522', 'CS09', 'BNHCM010055', '2025-04-10', '2025-03-05', N'Khám Tiêm', N'Đang chờ'),
('LH110425108', 'CS02', 'BNHN920012', '2025-04-11', '2025-03-21', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH140425622', 'CS08', 'BNHN190033', '2025-04-14', '2025-03-11', N'Khám Tiêm', N'Đang chờ'),
('LH150425493', 'CS04', 'BNHN000008', '2025-04-15', '2025-04-05', N'Khám Tiêm', N'Đang chờ'),
('LH150425491', 'CS09', 'BNHCM980046', '2025-04-15', '2025-03-27', N'Khám Tiêm', N'Đang chờ'),
('LH190425797', 'CS08', 'BNHN000044', '2025-04-19', '2025-03-27', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH200425494', 'CS02', 'BNHN210035', '2025-04-20', '2025-03-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH200425481', 'CS03', 'BNHN170031', '2025-04-20', '2025-04-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH210425640', 'CS08', 'BNHN190037', '2025-04-21', '2025-03-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425491', 'CS04', 'BNHN990029', '2025-04-22', '2025-02-27', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425179', 'CS10', 'BNHCM030050', '2025-04-22', '2025-03-21', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425971', 'CS08', 'BNHN920042', '2025-04-22', '2025-03-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425594', 'CS03', 'BNHN990021', '2025-04-22', '2025-04-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425458', 'CS08', 'BNHN950041', '2025-04-22', '2025-03-08', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425990', 'CS03', 'BNHN000014', '2025-04-22', '2025-03-15', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH230425615', 'CS03', 'BNHN030016', '2025-04-23', '2025-02-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH240425433', 'CS05', 'BNHN980007', '2025-04-24', '2025-03-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250425642', 'CS04', 'BNHN210039', '2025-04-25', '2025-03-15', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250425946', 'CS06', 'BNHN030027', '2025-04-25', '2025-03-25', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH260425188', 'CS10', 'BNHCM980052', '2025-04-26', '2025-03-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH270425540', 'CS02', 'BNHN000025', '2025-04-27', '2025-03-12', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH270425703', 'CS08', 'BNHN030022', '2025-04-27', '2025-04-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH280425789', 'CS04', 'BNHN981001', '2025-04-28', '2025-03-27', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290425661', 'CS05', 'BNHN000020', '2025-04-29', '2025-04-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290425336', 'CS10', 'BNHCM000053', '2025-04-29', '2025-03-13', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290425998', 'CS08', 'BNHN990009', '2025-04-29', '2025-03-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH300425375', 'CS08', 'BNHN190033', '2025-04-30', '2025-04-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH010525307', 'CS04', 'BNHN000008', '2025-05-01', '2025-04-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH030525665', 'CS09', 'BNHCM020049', '2025-05-03', '2025-04-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH030525230', 'CS04', 'BNHN200034', '2025-05-03', '2025-03-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH040525563', 'CS02', 'BNHN950043', '2025-05-04', '2025-04-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH060525668', 'CS09', 'BNHCM990047', '2025-05-06', '2025-03-28', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH060525150', 'CS03', 'BNHN030005', '2025-05-06', '2025-04-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH090525469', 'CS09', 'BNHCM010055', '2025-05-09', '2025-04-30', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH100525680', 'CS02', 'BNHN010023', '2025-05-10', '2025-03-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH100525176', 'CS02', 'BNHN991234', '2025-05-10', '2025-03-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH110525459', 'CS03', 'BNHN020026', '2025-05-11', '2025-04-15', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH120525139', 'CS04', 'BNHN010015', '2025-05-12', '2025-05-01', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH130525414', 'CS02', 'BNHN200038', '2025-05-13', '2025-03-31', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH140525976', 'CS04', 'BNHN010045', '2025-05-14', '2025-03-20', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220525909', 'CS07', 'BNHN220040', '2025-05-22', '2025-05-12', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220525675', 'CS03', 'BNHN980017', '2025-05-22', '2025-04-08', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220525161', 'CS08', 'BNHN920042', '2025-05-22', '2025-04-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220525754', 'CS02', 'BNHN950041', '2025-05-22', '2025-04-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH240525313', 'CS03', 'BNHN010010', '2025-05-24', '2025-05-08', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH240525682', 'CS08', 'BNHN030011', '2025-05-24', '2025-05-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250525752', 'CS06', 'BNHN020018', '2025-05-25', '2025-04-13', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250525316', 'CS04', 'BNHN180032', '2025-05-25', '2025-04-02', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH260525589', 'CS10', 'BNHCM980052', '2025-05-26', '2025-04-15', N'Lịch tiêm vaccine', N'Đang chờ')
INSERT INTO LICH_HEN (Ma_Lich_Hen, Ma_Co_So, Ma_Benh_Nhan, Ngay_Hen, Ngay_Dat_Lich, Ghi_Chu, Tinh_Trang_Lich)
VALUES
('LH260525472', 'CS02', 'BNHN000025', '2025-05-26', '2025-03-28', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH270525790', 'CS08', 'BNHN030022', '2025-05-27', '2025-05-01', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290525529', 'CS05', 'BNHN000020', '2025-05-29', '2025-05-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290525372', 'CS03', 'BNHN970030', '2025-05-29', '2025-05-03', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH300525402', 'CS04', 'BNHN970019', '2025-05-30', '2025-05-16', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH020625600', 'CS09', 'BNHCM980046', '2025-06-02', '2025-04-20', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH030625876', 'CS04', 'BNHN200034', '2025-06-03', '2025-04-21', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH050625701', 'CS03', 'BNHN030005', '2025-06-05', '2025-05-11', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH070625128', 'CS04', 'BNHN950013', '2025-06-07', '2025-05-29', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH080625347', 'CS08', 'BNHN970024', '2025-06-08', '2025-04-25', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH100625388', 'CS04', 'BNHN991234', '2025-06-10', '2025-05-26', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH120625631', 'CS03', 'BNHN010015', '2025-06-12', '2025-06-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625649', 'CS03', 'BNHN980017', '2025-06-22', '2025-04-28', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625399', 'CS08', 'BNHN920042', '2025-06-22', '2025-05-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625281', 'CS02', 'BNHN010003', '2025-06-22', '2025-04-23', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625940', 'CS02', 'BNHN950041', '2025-06-22', '2025-06-02', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625355', 'CS03', 'BNHN000014', '2025-06-22', '2025-06-09', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250625573', 'CS04', 'BNHN210039', '2025-06-25', '2025-05-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH260625529', 'CS10', 'BNHCM980052', '2025-06-26', '2025-06-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH260625757', 'CS08', 'BNHN000025', '2025-06-26', '2025-05-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290625314', 'CS03', 'BNHN970030', '2025-06-29', '2025-05-19', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH020725850', 'CS10', 'BNHCM980046', '2025-07-02', '2025-05-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH070725744', 'CS04', 'BNHN950013', '2025-07-07', '2025-06-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH190725614', 'CS03', 'BNHN010015', '2025-07-19', '2025-06-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH200725596', 'CS03', 'BNHN170031', '2025-07-20', '2025-05-25', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH210925980', 'CS02', 'BNHN200038', '2025-09-21', '2025-08-30', N'Lịch tiêm vaccine', N'Đang chờ');


INSERT INTO CHI_TIET_LICH_HEN (Ma_Lich_Hen, Ma_Vaccine) VALUES
-- Lịch hẹn ngày 2025-01-05
('LH050125386', 'USMEN2410'), -- Không trùng, chọn ngẫu nhiên
('LH050125746', 'VNPEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-11
('LH110125836', 'VNFVR2311'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-12
('LH120125777', 'USBVG2412'), -- Không trùng, chọn ngẫu nhiên
('LH120125550', 'USMRN2310'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-13
('LH130125534', 'JAPJP2312'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-18
('LH180125720', 'JPNIP2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-19
('LH190125112', 'CHINA2308'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-20 (trùng với LT250120063, LT250120004)
('LH200125853', 'FRAFLU2312'), -- Trùng ngày, chọn ngẫu nhiên
('LH200125850', 'FRDTP2411'),  -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-22 (trùng với LT250122041, LT250122066)
('LH220125139', 'DEZOS2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH220125170', 'USHPV2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-24 (trùng với LT250124067)
('LH240125262', 'USMEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-25
('LH250125376', 'VNPEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-26 (trùng với LT250126070)
('LH260125807', 'VNFVR2311'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-29 (trùng với LT250129005)
('LH290125280', 'USBVG2412'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-01-30
('LH300125414', 'USMRN2310'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-01 (trùng với LT250201011, LT250201938)
('LH010225208', 'JAPJP2312'), -- Trùng ngày, chọn ngẫu nhiên
('LH010225141', 'JPNIP2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-10 (trùng với LT250210031)
('LH100225286', 'CHINA2308'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-11
('LH110225268', 'FRAFLU2312'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-14
('LH140225719', 'FRDTP2411'), -- Không trùng, chọn ngẫu nhiên
('LH140225786', 'DEZOS2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-15
('LH150225572', 'USHPV2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-16
('LH160225347', 'USMEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-18
('LH180225492', 'VNPEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-20 (trùng với LT250220039, LT250220231)
('LH200225302', 'VNFVR2311'), -- Trùng ngày, chọn ngẫu nhiên
('LH200225895', 'USBVG2412'), -- Trùng ngày, chọn ngẫu nhiên
('LH200225172', 'USMRN2310'), -- Trùng ngày, chọn ngẫu nhiên
('LH200225523', 'JAPJP2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-22 (trùng với LT250222034)
('LH220225536', 'JPNIP2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH220225617', 'CHINA2308'), -- Trùng ngày, chọn ngẫu nhiên
('LH220225595', 'FRAFLU2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-24 (trùng với LT250224059)
('LH240225660', 'FRDTP2411'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-02-28
('LH280225316', 'DEZOS2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-01 (trùng với LT250301871)
('LH010325949', 'USHPV2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-02
('LH020325334', 'USMEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-04 (trùng với LT250304198)
('LH040325180', 'VNPEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-05
('LH050325416', 'VNFVR2311'), -- Không trùng, chọn ngẫu nhiên
('LH050325655', 'USBVG2412'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-07
('LH070325318', 'USMRN2310'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-08
('LH080325352', 'JAPJP2312'), -- Không trùng, chọn ngẫu nhiên
('LH080325313', 'JPNIP2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-10
('LH100325686', 'CHINA2308'), -- Không trùng, chọn ngẫu nhiên
('LH100325819', 'FRAFLU2312'), -- Không trùng, chọn ngẫu nhiên
('LH100325659', 'FRDTP2411'), -- Không trùng, chọn ngẫu nhiên
('LH100325206', 'DEZOS2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-11
('LH110325599', 'USHPV2410'), -- Không trùng, chọn ngẫu nhiên
('LH110325737', 'USMEN2410'), -- Không trùng, chọn ngẫu nhiên
('LH110325398', 'VNPEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-12
('LH120325429', 'VNFVR2311'), -- Không trùng, chọn ngẫu nhiên
('LH120325830', 'USBVG2412'), -- Không trùng, chọn ngẫu nhiên
('LH120325488', 'USMRN2310'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-14 (trùng với LT250314101, LT250314361)
('LH140325301', 'JAPJP2312'), -- Trùng ngày, chọn ngẫu nhiên
('LH140325874', 'JPNIP2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH140325826', 'CHINA2308'), -- Trùng ngày, chọn ngẫu nhiên
('LH140325486', 'FRAFLU2312'), -- Trùng ngày, chọn ngẫu nhiên
('LH140325416', 'FRDTP2411'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-15
('LH150325251', 'DEZOS2410'), -- Không trùng, chọn ngẫu nhiên
('LH150325469', 'USHPV2410'), -- Không trùng, chọn ngẫu nhiên
('LH150325306', 'USMEN2410'), -- Không trùng, chọn ngẫu nhiên
('LH150325562', 'VNPEN2410'), -- Không trùng, chọn ngẫu nhiên
('LH150325442', 'VNFVR2311'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-16
('LH160325228', 'USBVG2412'), -- Không trùng, chọn ngẫu nhiên
('LH160325340', 'USMRN2310'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-17
('LH170325375', 'JAPJP2312'), -- Không trùng, chọn ngẫu nhiên
('LH170325454', 'JPNIP2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-18
('LH180325894', 'CHINA2308'), -- Không trùng, chọn ngẫu nhiên
('LH180325266', 'FRAFLU2312'), -- Không trùng, chọn ngẫu nhiên
('LH180325205', 'FRDTP2411'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-19
('LH190325872', 'DEZOS2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-20 (trùng với LT250320102)
('LH200325692', 'USHPV2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH200325279', 'USMEN2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH200325320', 'VNPEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-21
('LH210325595', 'VNFVR2311'), -- Không trùng, chọn ngẫu nhiên
('LH210325608', 'USBVG2412'), -- Không trùng, chọn ngẫu nhiên
('LH210325260', 'USMRN2310'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-22 (không trùng lần tiêm nào)
('LH220325422', 'JAPJP2312'), -- Không trùng, chọn ngẫu nhiên
('LH220325576', 'JPNIP2410'), -- Không trùng, chọn ngẫu nhiên
('LH220325773', 'CHINA2308'), -- Không trùng, chọn ngẫu nhiên
('LH220325210', 'FRAFLU2312'), -- Không trùng, chọn ngẫu nhiên
('LH220325627', 'FRDTP2411'), -- Không trùng, chọn ngẫu nhiên
('LH220325245', 'DEZOS2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-23
('LH230325180', 'USHPV2410'), -- Không trùng, chọn ngẫu nhiên
('LH230325393', 'USMEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-24
('LH240325455', 'VNPEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-25
('LH250325883', 'VNFVR2311'), -- Không trùng, chọn ngẫu nhiên
('LH250325198', 'USBVG2412'), -- Không trùng, chọn ngẫu nhiên
('LH250325121', 'USMRN2310'), -- Không trùng, chọn ngẫu nhiên
('LH250325863', 'JAPJP2312'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-27
('LH270325277', 'JPNIP2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-28
('LH280325208', 'CHINA2308'), -- Không trùng, chọn ngẫu nhiên
('LH280325818', 'FRAFLU2312'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-29
('LH290325123', 'FRDTP2411'), -- Không trùng, chọn ngẫu nhiên
('LH290325339', 'DEZOS2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-03-30
('LH300325940', 'USHPV2410'), -- Không trùng, chọn ngẫu nhiên
('LH300325665', 'USMEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-01 (trùng với LT250401071)
('LH010425294', 'VNPEN2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH010425206', 'VNFVR2311'), -- Trùng ngày, chọn ngẫu nhiên
('LH010425774', 'USBVG2412'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-04
('LH040425342', 'USMRN2310'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-05
('LH050425519', 'JAPJP2312'), -- Không trùng, chọn ngẫu nhiên
('LH050425634', 'JPNIP2410'), -- Không trùng, chọn ngẫu nhiên
('LH050425502', 'CHINA2308'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-08
('LH080425862', 'FRAFLU2312'), -- Không trùng, chọn ngẫu nhiên
('LH080425833', 'FRDTP2411'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-09 (trùng với LT250409007)
('LH090425370', 'DEZOS2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-10
('LH100425522', 'USHPV2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-11 (trùng với LT250411001)
('LH110425108', 'USMEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-14
('LH140425622', 'VNPEN2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-15
('LH150425493', 'VNFVR2311'), -- Không trùng, chọn ngẫu nhiên
('LH150425491', 'USBVG2412'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-19 (trùng với LT250419001)
('LH190425797', 'USMRN2310'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-20 (trùng với LT250420033, LT250420441)
('LH200425494', 'JAPJP2312'), -- Trùng ngày, chọn ngẫu nhiên
('LH200425481', 'JPNIP2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-21
('LH210425640', 'CHINA2308'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-22 (trùng với LT250422111, LT250422121, LT250422015, LT250422026, LT250422231, LT250422349)
('LH220425491', 'FRAFLU2312'), -- Trùng ngày, chọn ngẫu nhiên
('LH220425179', 'FRDTP2411'), -- Trùng ngày, chọn ngẫu nhiên
('LH220425971', 'DEZOS2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH220425594', 'USHPV2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH220425458', 'USMEN2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH220425990', 'VNPEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-23
('LH230425615', 'VNFVR2311'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-24 (trùng với LT250424012)
('LH240425433', 'USBVG2412'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-25 (trùng với LT250425501, LT250425072)
('LH250425642', 'USMRN2310'), -- Trùng ngày, chọn ngẫu nhiên
('LH250425946', 'JAPJP2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-26
('LH260425188', 'JPNIP2410'), -- Không trùng, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-27 (trùng với LT250427341, LT250427881)
('LH270425540', 'CHINA2308'), -- Trùng ngày, chọn ngẫu nhiên
('LH270425703', 'FRAFLU2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-28 (trùng với LT250428451)
('LH280425789', 'FRDTP2411'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-29 (trùng với LT250429038, LT250429058, LT250429077)
('LH290425661', 'DEZOS2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH290425336', 'USHPV2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH290425998', 'USMEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-04-30 (trùng với LT250430009)
('LH300425375', 'VNPEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-01 (trùng với LT250501024)
('LH010525307', 'VNFVR2311'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-03 (trùng với LT250503033, LT250503067)
('LH030525665', 'USBVG2412'), -- Trùng ngày, chọn ngẫu nhiên
('LH030525230', 'USMRN2310'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-04 (trùng với LT250504356)
('LH040525563', 'JAPJP2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-06 (trùng với LT250506509, LT250506046)
('LH060525668', 'JPNIP2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH060525150', 'CHINA2308'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-09 (trùng với LT250509039)
('LH090525469', 'FRAFLU2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-10 (trùng với LT250510048, LT250510001)
('LH100525680', 'FRDTP2411'), -- Trùng ngày, chọn ngẫu nhiên
('LH100525176', 'DEZOS2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-11 (trùng với LT250511023)
('LH110525459', 'USHPV2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-12 (trùng với LT250512468)
('LH120525139', 'USMEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-13 (trùng với LT250513046)
('LH130525414', 'VNPEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-14 (trùng với LT250514231)
('LH140525976', 'VNFVR2311'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-22 (trùng với LT250522040, LT250522029, LT250522092, LT250522339)
('LH220525909', 'USBVG2412'), -- Trùng ngày, chọn ngẫu nhiên
('LH220525675', 'USMRN2310'), -- Trùng ngày, chọn ngẫu nhiên
('LH220525161', 'JAPJP2312'), -- Trùng ngày, chọn ngẫu nhiên
('LH220525754', 'JPNIP2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-24 (trùng với LT250524029, LT250524056)
('LH240525313', 'CHINA2308'), -- Trùng ngày, chọn ngẫu nhiên
('LH240525682', 'FRAFLU2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-25 (trùng với LT250525041, LT250525044)
('LH250525752', 'FRDTP2411'), -- Trùng ngày, chọn ngẫu nhiên
('LH250525316', 'DEZOS2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-26 (trùng với LT250526034, LT250526002)
('LH260525589', 'USHPV2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH260525472', 'USMEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-27 (trùng với LT250527642)
('LH270525790', 'VNPEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-29 (trùng với LT250529013, LT250529092)
('LH290525529', 'VNFVR2311'), -- Trùng ngày, chọn ngẫu nhiên
('LH290525372', 'USBVG2412'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-05-30 (trùng với LT250530572)
('LH300525402', 'USMRN2310'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-02 (trùng với LT250602772)
('LH020625600', 'JAPJP2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-03 (trùng với LT250603035)
('LH030625876', 'JPNIP2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-05 (trùng với LT250605342)
('LH050625701', 'CHINA2308'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-07 (trùng với LT250607023)
('LH070625128', 'FRAFLU2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-08 (trùng với LT250608034)
('LH080625347', 'FRDTP2411'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-10 (trùng với LT250610023)
('LH100625388', 'DEZOS2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-12 (trùng với LT250612023)
('LH120625631', 'USHPV2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-22 (trùng với LT250622020, LT250622073, LT250622136, LT250622463, LT250622667)
('LH220625649', 'USMEN2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH220625399', 'VNPEN2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH220625281', 'VNFVR2311'), -- Trùng ngày, chọn ngẫu nhiên
('LH220625940', 'USBVG2412'), -- Trùng ngày, chọn ngẫu nhiên
('LH220625355', 'USMRN2310'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-25 (trùng với LT250625016)
('LH250625573', 'JAPJP2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-26 (trùng với LT250626095, LT250626003)
('LH260625529', 'JPNIP2410'), -- Trùng ngày, chọn ngẫu nhiên
('LH260625757', 'CHINA2308'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-06-29 (trùng với LT250629403)
('LH290625314', 'FRAFLU2312'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-07-02 (trùng với LT250702343)
('LH020725850', 'FRDTP2411'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-07-07 (trùng với LT250707064)
('LH070725744', 'DEZOS2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-07-19 (trùng với LT250719053)
('LH190725614', 'USHPV2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-07-20 (trùng với LT250720009)
('LH200725596', 'USMEN2410'), -- Trùng ngày, chọn ngẫu nhiên
-- Lịch hẹn ngày 2025-09-21 (trùng với LT250921042)
('LH210925980', 'VNPEN2410'); -- Trùng ngày, chọn ngẫu nhiên
