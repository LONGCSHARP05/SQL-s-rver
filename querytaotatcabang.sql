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
    Email VARCHAR(100)                        -- Ví dụ: ttytq1@gmail.com
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
('KH01', N'Kho dự trữ tổng', N'123 Đường Hoàng Quốc Việt, Cầu Giấy, Hà Nội', '0241234567', 'khotong.hn@gmail.com'),
('CS02', N'Cơ sở Thanh Xuân', N'45 Nguyễn Trãi, Thanh Xuân, Hà Nội', '0242345678', 'coso.tx@hanoi.gov.vn'),
('CS03', N'Cơ sở Hoàn Kiếm', N'20 Hàng Bài, Hoàn Kiếm, Hà Nội', '0243456789', 'coso.hk@hanoi.gov.vn'),
('CS04', N'Cơ sở Tây Hồ', N'98 Võ Chí Công, Tây Hồ, Hà Nội', '0244567890', 'coso.th@hanoi.gov.vn'),
('CS05', N'Trung tâm Y tế Quận Ba Đình', N'12 Đội Cấn, Ba Đình, Hà Nội', '0245678901', 'ttytbd@hanoi.gov.vn'),
('CS06', N'Trung tâm Y tế Quận Đống Đa', N'60 Tôn Đức Thắng, Đống Đa, Hà Nội', '0246789012', 'ttytdd@hanoi.gov.vn'),
('CS07', N'Trung tâm Y tế Quận Hai Bà Trưng', N'15 Bạch Mai, Hai Bà Trưng, Hà Nội', '0247890123', 'ttythbt@hanoi.gov.vn'),
('CS08', N'Trung tâm Y tế Huyện Gia Lâm', N'234 Nguyễn Đức Thuận, Gia Lâm, Hà Nội', '0248901234', 'ttytgl@hanoi.gov.vn'),
('CS09', N'Cơ sở Quận 1', N'123 Nguyễn Huệ, Quận 1, TP.HCM', '0283123456', 'coso.q1@hcm.gov.vn'),
('CS10', N'Trung tâm Y tế Quận Bình Thạnh', N'88 Đinh Tiên Hoàng, Bình Thạnh, TP.HCM', '0289876543', 'ttytbt@hcm.gov.vn');


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
('CS07', 'CBNTL034', N'Bác sĩ', '2023-04-02', NULL),
('CS07', 'CBNTT006', N'Bác sĩ', '2023-04-02', NULL),

-- Trung tâm Y tế Quận Ba Đình (5 cán bộ)
('CS05', 'CBTTN012', N'Bác sĩ', '2023-01-05', NULL),
('CS05', 'CBTVH024', N'Trưởng khoa', '2023-02-10', NULL),
('CS05', 'CBVTA005', N'Y tá', '2023-03-20', NULL),
('CS05', 'CBLHV266', N'Nhân viên hành chính', '2023-04-15', NULL),
('CS05', 'CBDBH010', N'Nhân viên hành chính', '2023-02-22', '2024-04-27'),
('CS05', 'CBNQA011', N'Bác sĩ', '2023-01-05', NULL);

INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Trung tâm Y tế Quận Ba Đình (5 cán bộ)
('CS02', 'CBBTA275', N'Bác sĩ', '2023-01-05', NULL),
('CS02', 'CBBTN039', N'Trưởng khoa', '2023-02-10', NULL),
('CS02', 'CBDBH019', N'Y tá', '2023-03-20', NULL),
('CS02', 'CBDBP178', N'Nhân viên hành chính', '2023-04-15', NULL),
('CS02', 'CBDHA056', N'Nhân viên hành chính', '2023-02-22', '2024-04-27'),
('CS02', 'CBHBT092', N'Bác sĩ', '2023-01-05', NULL),

-- Trung tâm Y tế Quận Ba Đình (5 cán bộ)
('CS04', 'CBHNN019', N'Bác sĩ', '2023-01-05', NULL),
('CS04', 'CBLHD013', N'Trưởng khoa', '2023-02-10', NULL),
('CS04', 'CBLHV017', N'Y tá', '2023-03-20', NULL),
('CS04', 'CBLLP081', N'Nhân viên hành chính', '2023-04-15', NULL),
('CS04', 'CBLLT259', N'Nhân viên hành chính', '2023-02-22', '2024-04-27'),
('CS04', 'CBLMT231', N'Bác sĩ', '2023-01-05', NULL);

INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Trung tâm Y tế Quận Đống Đa (5 cán bộ)
('CS06', 'CBLLP008', N'Trưởng khoa', '2023-01-15', NULL),
('CS06', 'CBLLT027', N'Bác sĩ', '2023-02-25', NULL),
('CS06', 'CBLMT045', N'Y tá', '2023-03-12', NULL),
('CS06', 'CBBTN094', N'Nhân viên hành chính', '2023-04-10', NULL),
('CS06', 'CBDBP020', N'Y tá', '2023-03-12', '2023-06-15'),
('CS06', 'CBNMD250', N'Bác sĩ', '2023-01-05', NULL);

-- Thêm các cán bộ còn thiếu vào bảng CAN_BO_CO_SO
INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Cơ sở Quận Bình Thạnh (CS3HCM010)
('CS10', 'CBNVA001', N'Nhân viên y tế', '2023-01-01', NULL),
('CS10', 'CBNTH021', N'Nhân viên hành chính', '2023-02-15', NULL),

-- Trung tâm Y tế Huyện Gia Lâm (CS3-HN008)
('CS08', 'CBPHT025', N'Y tá', '2023-03-10', NULL),

-- Trung tâm Y tế Quận Đống Đa (CS3HN006)
('CS06', 'CBNMC026', N'Bác sĩ', '2023-04-05', NULL);
INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
--KHO
('KH01', 'CBNTTH868', N'Trưởng kho', '2023-01-15', NULL),
('KH01', 'CBPQN115', N'Kế toán', '2023-02-25', NULL),
('KH01', 'CBPQT022', N'Nhân viên kho', '2023-03-12', NULL),
('KH01', 'CBPTD194', N'Nhân viên kho', '2023-04-10', NULL),
('KH01', 'CBPTH129', N'Nhân viên kho', '2023-03-12', '2023-06-15'),
('KH01', 'CBTMD198', N'Nhân viên kho', '2023-01-05', NULL),
('KH01', 'CBVTA289', N'Nhân viên kho', '2023-01-05', NULL);







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
('COVID230801', 'CHINA2308', 152, '2023-08-01', '2026-08-01', N'Sinopharm', N'Đang phân phối'),
('TYP241002', 'CHTYP2410', 178, '2024-10-01', '2027-10-01', N'Sanofi Pasteur', N'Sẵn sàng sử dụng'),
('ZOS241003', 'DEZOS2410', 134, '2024-10-01', '2027-10-01', N'Merck & Co.', N'Đang phân phối'),
('FLU231204', 'FRAFLU2312', 167, '2023-12-01', '2026-12-01', N'Sanofi Pasteur', N'Đang lưu kho'),
('DTP241105', 'FRDTP2411', 210, '2024-11-01', '2027-11-01', N'Sanofi Pasteur', N'Sẵn sàng sử dụng'),
('ADV230706', 'GBADV2307', 189, '2023-07-01', '2026-07-01', N'AstraZeneca', N'Đang phân phối'),
('ROT241007', 'INROT2410', 145, '2024-10-01', '2027-10-01', N'GlaxoSmithKline', N'Đang lưu kho'),
('JEV231208', 'JAPJP2312', 173, '2023-12-01', '2026-12-01', N'Biken', N'Sẵn sàng sử dụng'),
('IMJ241009', 'JPNIP2410', 132, '2024-10-01', '2027-10-01', N'Sanofi Pasteur', N'Đang phân phối'),
('HBP231210', 'KORHBP2312', 198, '2023-12-01', '2026-12-01', N'Korean Green Cross', N'Đang lưu kho'),


('SPT230911', 'RUSSP2309', 157, '2023-09-01', '2026-09-01', N'Gamaleya', N'Đang phân phối'),
('HAVB241212', 'USBVG2412', 175, '2024-12-01', '2027-12-01', N'GlaxoSmithKline', N'Sẵn sàng sử dụng'),
('HPV241013', 'USHPV2410', 138, '2024-10-01', '2027-10-01', N'GlaxoSmithKline', N'Đang phân phối'),
('MEN241014', 'USMEN2410', 164, '2024-10-01', '2027-10-01', N'Sanofi Pasteur', N'Đang lưu kho'),
('MRN230615', 'USMRN2306', 182, '2023-06-01', '2026-06-01', N'Pfizer-BioNTech', N'Sẵn sàng sử dụng'),
('MRN231016', 'USMRN2310', 142, '2023-10-01', '2026-10-01', N'Moderna', N'Đang phân phối'),
('BCG230517', 'VNBGC2305', 135, '2023-05-01', '2026-05-01', N'Viện Vaccine Việt Nam', N'Đang lưu kho'),
('VER231118', 'VNFVR2311', 170, '2023-11-01', '2026-11-01', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('PEN241019', 'VNPEN2410', 218, '2024-10-01', '2027-10-01', N'Sanofi Pasteur', N'Đang lưu kho'),
('RAB241320', 'VNRVG2413', 195, '2024-12-01', '2027-12-01', N'VABIOTECH', N'Đang lưu kho'),

('HBP231221', 'KORHBP2312', 200, '2023-12-15', '2026-12-15', N'Korean Green Cross', N'Đang lưu kho'),
('SPT230922', 'RUSSP2309', 163, '2023-09-10', '2026-09-10', N'Gamaleya', N'Đang phân phối'),
('HAVB241223', 'USBVG2412', 180, '2024-12-05', '2027-12-05', N'GlaxoSmithKline', N'Sẵn sàng sử dụng'),
('HPV241024', 'USHPV2410', 149, '2024-10-10', '2027-10-10', N'GlaxoSmithKline', N'Đang phân phối'),
('MEN241025', 'USMEN2410', 175, '2024-10-15', '2027-10-15', N'Sanofi Pasteur', N'Đang lưu kho'),
('MRN230626', 'USMRN2306', 190, '2023-06-05', '2026-06-05', N'Pfizer-BioNTech', N'Sẵn sàng sử dụng'),
('MRN231027', 'USMRN2310', 153, '2023-10-12', '2026-10-12', N'Moderna', N'Đang phân phối'),
('BCG230528', 'VNBGC2305', 140, '2023-05-08', '2026-05-08', N'Viện Vaccine Việt Nam', N'Đang lưu kho'),
('VER231129', 'VNFVR2311', 180, '2023-11-05', '2026-11-05', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('PEN241030', 'VNPEN2410', 220, '2024-10-20', '2027-10-20', N'Sanofi Pasteur', N'Đang lưu kho'),

('PEN250151', 'VNPEN2410', 230, '2025-01-10', '2028-01-10', N'Sanofi Pasteur', N'Sẵn sàng sử dụng'),
('HAVB250152', 'USBVG2412', 190, '2025-01-12', '2028-01-12', N'GlaxoSmithKline', N'Đang lưu kho'),
('BCG250153', 'VNBGC2305', 150, '2025-01-15', '2028-01-15', N'Viện Vaccine Việt Nam', N'Đang lưu kho'),
('MRN250154', 'USMRN2310', 160, '2025-01-18', '2028-01-18', N'Moderna', N'Đang phân phối'),
('MRN250155', 'USMRN2306', 200, '2025-01-20', '2028-01-20', N'Pfizer-BioNTech', N'Sẵn sàng sử dụng'),
('VER250156', 'VNFVR2311', 180, '2025-01-22', '2028-01-22', N'Viện Vaccine Việt Nam', N'Đang lưu kho'),
('HPV250157', 'USHPV2410', 150, '2025-01-25', '2028-01-25', N'GlaxoSmithKline', N'Đang phân phối'),
('MEN250158', 'USMEN2410', 170, '2025-01-27', '2028-01-27', N'Sanofi Pasteur', N'Sẵn sàng sử dụng');

INSERT INTO LO_VACCINE (Ma_Lo, Ma_Vaccine, So_Lieu_Vaccine_Ban_Dau, Ngay_San_Xuat, Han_Su_Dung, Xuat_Xu, Tinh_Trang) 
VALUES 
('CHINA230801', 'CHINA2308', 153, '2023-08-01', '2026-08-01', N'Sinopharm', N'Đang phân phối'),
('CHTYP241001', 'CHTYP2410', 180, '2024-10-05', '2027-10-05', N'Trung Quốc', N'Đang phân phối'),
('DEZOS241001', 'DEZOS2410', 200, '2024-10-10', '2027-10-10', N'Đức', N'Đang phân phối'),
('FRDTP241101', 'FRDTP2411', 210, '2024-11-12', '2027-11-12', N'Pháp', N'Đang phân phối'),
('INROT241001', 'INROT2410', 170, '2024-10-22', '2027-10-22', N'Ấn Độ', N'Đang phân phối'),
('JAPJP231201', 'JAPJP2312', 145, '2023-12-30', '2026-12-30', N'Nhật Bản', N'Đang phân phối'),
('JPNIP241001', 'JPNIP2410', 190, '2024-10-15', '2027-10-15', N'Nhật Bản', N'Đang phân phối'),
('KORHBP231201', 'KORHBP2312', 170, '2023-12-05', '2026-12-05', N'Hàn Quốc', N'Đang phân phối'),
('RUSSP230901', 'RUSSP2309', 160, '2023-09-25', '2026-09-25', N'Nga', N'Đang phân phối'),
('USBVG241201', 'USBVG2412', 180, '2024-12-10', '2027-12-10', N'Mỹ', N'Đang phân phối'),
('USHPV241001', 'USHPV2410', 190, '2024-10-08', '2027-10-08', N'Mỹ', N'Đang phân phối'),
('USMEN241001', 'USMEN2410', 159, '2024-10-20', '2027-10-20', N'Mỹ', N'Đang phân phối'),
('USMRN230601', 'USMRN2306', 210, '2023-06-15', '2026-06-15', N'Mỹ', N'Đang phân phối'),
('USMRN231001', 'USMRN2310', 200, '2023-10-10', '2026-10-10', N'Mỹ', N'Đang phân phối'),
('VNBGC230501', 'VNBGC2305', 170, '2023-05-10', '2026-05-10', N'Việt Nam', N'Đang phân phối'),
('VNFVR231101', 'VNFVR2311', 160, '2023-11-18', '2026-11-18', N'Việt Nam', N'Đang phân phối'),
('VNPEN241001', 'VNPEN2410', 200, '2024-10-25', '2027-10-25', N'Việt Nam', N'Đang phân phối'),
('VNRVG241201', 'VNRVG2413', 130, '2024-12-01', '2027-12-01', N'Việt Nam', N'Đang phân phối');


INSERT INTO LO_VACCINE (Ma_Lo, Ma_Vaccine, So_Lieu_Vaccine_Ban_Dau, Ngay_San_Xuat, Han_Su_Dung, Xuat_Xu, Tinh_Trang) VALUES 
('BCG240344', 'VNBGC2305', 140, '2024-03-01', '2027-03-01', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('BCG240356', 'VNBGC2305', 140, '2024-03-05', '2027-03-05', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('BCG240399', 'VNBGC2305', 160, '2024-03-10', '2027-03-10', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('BCG240398', 'VNBGC2305', 145, '2024-03-15', '2027-03-15', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng'),
('BCG240349', 'VNBGC2305', 155, '2024-03-20', '2027-03-20', N'Viện Vaccine Việt Nam', N'Sẵn sàng sử dụng');

DELETE LAN_TIEM
-- Lần tiêm
INSERT INTO LAN_TIEM (Ma_Lan_Tiem, Ma_Benh_Nhan, Ma_Co_So, Ma_Can_Bo, Ngay_Tiem, Ket_Qua_Tiem)
VALUES
('LT200125639', 'BNHN210035', 'CS02', 'CBDBP178', '2025-01-20', N'Thành công'),
('LT200125285', 'BNHN980017', 'CS03', 'CBLHD147', '2025-01-20', N'Thành công'),
('LT220125746', 'BNHN010010', 'CS03', 'CBLNT023', '2025-01-22', N'Thành công'),
('LT220125457', 'BNHN210039', 'CS04', 'CBLHV017', '2025-01-22', N'Thành công');

INSERT INTO LAN_TIEM (Ma_Lan_Tiem, Ma_Benh_Nhan, Ma_Co_So, Ma_Can_Bo, Ngay_Tiem, Ket_Qua_Tiem)VALUES

('LT150425728', 'BNHCM030050', 'CS10', 'CBNVA001', '2025-04-15', N'Thành công'),
('LT190425913', 'BNHN000044', 'CS08', 'CBHBT005', '2025-04-19', N'Thành công'),
('LT200425759', 'BNHN170031', 'CS03', 'CBNBT018', '2025-04-20', N'Thành công'),
('LT200425827', 'BNHN210035', 'CS02', 'CBBTN039', '2025-04-20', N'Thành công'),
('LT210425479', 'BNHN190037', 'CS08', 'CBPHT025', '2025-04-21', N'Thành công'),
('LT220425197', 'BNHN000014', 'CS03', 'CBLNT023', '2025-04-22', N'Thành công'),
('LT220425582', 'BNHN920042', 'CS08', 'CBHBT005', '2025-04-22', N'Thành công'),
('LT220425826', 'BNHN950041', 'CS08', 'CBHBT005', '2025-04-22', N'Thành công'),
('LT220425357', 'BNHN990021', 'CS03', 'CBNBT018', '2025-04-22', N'Thành công'),
('LT220425753', 'BNHN990029', 'CS04', 'CBLLP081', '2025-04-22', N'Thành công'),
('LT230425618', 'BNHN030016', 'CS03', 'CBLTP003', '2025-04-23', N'Thành công'),
('LT240425217', 'BNHN980007', 'CS05', 'CBVTA005', '2025-04-24', N'Thành công'),
('LT250425567', 'BNHN030027', 'CS06', 'CBNMC026', '2025-04-25', N'Thành công'),
('LT250425539', 'BNHN210039', 'CS04', 'CBLMT231', '2025-04-25', N'Thành công'),
('LT270425893', 'BNHN000025', 'CS02', 'CBBTN039', '2025-04-27', N'Thành công'),
('LT270425746', 'BNHN030022', 'CS08', 'CBHBT005', '2025-04-27', N'Thành công'),
('LT280425648', 'BNHN981001', 'CS04', 'CBLLT259', '2025-04-28', N'Thành công'),
('LT290425587', 'BNHN000020', 'CS05', 'CBTVH024', '2025-04-29', N'Thành công'),
('LT290425461', 'BNHN990009', 'CS08', 'CBHBT005', '2025-04-29', N'Thành công'),
('LT300425368', 'BNHN190033', 'CS08', 'CBHBT005', '2025-04-30', N'Thành công'),
('LT240125935', 'BNHN180032', 'CS05', 'CBTVH024', '2025-01-24', N'Xảy ra phản ứng'),
('LT260125462', 'BNHN000020', 'CS05', 'CBVTA005', '2025-01-26', N'Xảy ra phản ứng'),
('LT300125926', 'BNHN970019', 'CS04', 'CBLLP081', '2025-01-30', N'Xảy ra phản ứng'),
('LT010225916', 'BNHCM000048', 'CS10', 'CBNVA001', '2025-02-01', N'Thành công'),
('LT010225937', 'BNHN970024', 'CS08', 'CBPHT025', '2025-02-01', N'Thành công'),
('LT100225749', 'BNHN010023', 'CS05', 'CBTTN012', '2025-02-10', N'Thành công'),
('LT150225572', 'BNHCM000053', 'CS09', 'CBMVT029', '2025-02-15', N'Thành công'),
('LT200225624', 'BNHN010003', 'CS02', 'CBBTA275', '2025-02-20', N'Thành công'),
('LT200225315', 'BNHN970030', 'CS02', 'CBDBP178', '2025-02-20', N'Thành công'),
('LT220225678', 'BNHN220040', 'CS06', 'CBLMT045', '2025-02-22', N'Thành công'),
('LT240225384', 'BNHN020018', 'CS06', 'CBLLP008', '2025-02-24', N'Thành công'),
('LT010325825', 'BNHCM980046', 'CS09', 'CBPTH002', '2025-03-01', N'Thành công'),
('LT040325796', 'BNHN950013', 'CS02', 'CBHBT092', '2025-03-04', N'Thành công'),
('LT140325524', 'BNHN030011', 'CS08', 'CBHBT005', '2025-03-14', N'Xảy ra phản ứng'),
('LT200325794', 'BNHCM020049', 'CS09', 'CBMVT029', '2025-03-20', N'Thành công'),
('LT200325476', 'BNHN980017', 'CS03', 'CBLNT023', '2025-03-20', N'Xảy ra phản ứng'),
('LT270325359', 'BNHN990009', 'CS08', 'CBPHT025', '2025-03-27', N'Thành công'),
('LT010425492', 'BNHN000008', 'CS04', 'CBLLT259', '2025-04-01', N'Thành công'),
('LT090425826', 'BNHN020004', 'CS05', 'CBDBH010', '2025-04-09', N'Thành công'),
('LT110425514', 'BNHN920012', 'CS02', 'CBBTA275', '2025-04-11', N'Thành công');


INSERT INTO CHI_TIET_LAN_TIEM (Ma_Lan_Tiem, Ma_Vaccine) VALUES
('LT200125639', 'USBVG2412'),
('LT200125285', 'JAPJP2312'),
('LT220125746', 'VNFVR2311'),
('LT220125457', 'USMRN2310'),
('LT240125935', 'RUSSP2309'),
('LT260125462', 'FRDTP2411'),
('LT300125926', 'USMRN2310'),
('LT010225916', 'VNBGC2305');
INSERT INTO CHI_TIET_LAN_TIEM (Ma_Lan_Tiem, Ma_Vaccine) VALUES
('LT010225937', 'FRDTP2411'),
('LT100225749', 'VNBGC2305'),
('LT150225572', 'CHINA2308'),
('LT200225624', 'USHPV2410'),
('LT200225315', 'USBVG2412'),
('LT220225678', 'JPNIP2410'),
('LT240225384', 'USBVG2412'),
('LT010325825', 'VNFVR2311'),
('LT040325796', 'DEZOS2410'),
('LT140325524', 'USMEN2410'),
('LT200325794', 'USMRN2306'),
('LT200325476', 'USBVG2412'),
('LT270325359', 'USMRN2306'),
('LT010425492', 'VNBGC2305'),
('LT090425826', 'USHPV2410'),
('LT110425514', 'DEZOS2410');

INSERT INTO CHI_TIET_LAN_TIEM (Ma_Lan_Tiem, Ma_Vaccine) VALUES
('LT150425728', 'JPNIP2410'),
('LT190425913', 'VNBGC2305'),
('LT200425759', 'USBVG2412'),
('LT200425827', 'USBVG2412'),
('LT210425479', 'USMEN2410'),
('LT220425197', 'RUSSP2309'),
('LT220425582', 'FRDTP2411'),
('LT220425826', 'VNBGC2305'),
('LT220425357', 'CHTYP2410'),
('LT220425753', 'VNBGC2305'),
('LT230425618', 'VNRVG2413'),
('LT240425217', 'FRDTP2411'),
('LT250425567', 'VNFVR2311'),
('LT250425539', 'VNBGC2305'),
('LT270425893', 'VNBGC2305'),
('LT270425746', 'FRDTP2411'),
('LT280425648', 'VNBGC2305'),
('LT290425587', 'FRDTP2411'),
('LT290425461', 'USMRN2306'),
('LT300425368', 'USMRN2306');

INSERT INTO PHAN_UNG_SAU_TIEM (Ma_Phan_Ung, Ma_Lan_Tiem, Ten_Phan_Ung, Muc_Do_Phan_Ung, Thoi_Diem_Xay_Ra, Thoi_Diem_Ket_Thuc, Ghi_Chu) VALUES
('PU140325MEN077', 'LT140325524', N'Chóng mặt', N'Nhẹ', '2025-03-20 14:45', '2025-03-20 17:30', N'Nghỉ ngơi theo dõi'),
('PU200325BVG028', 'LT200325476', N'Nôn ói', N'Nặng', '2025-03-20 18:00', '2025-03-20 12:00', N'Đã truyền dịch và theo dõi'),
('PU240125SSP368', 'LT240125935', N'Sốt nhẹ', N'Nhẹ', '2025-01-24 09:30', NULL, N'Nghỉ ngơi theo dõi'),
('PU260125DTP347', 'LT260125462', N'Nổi mẩn đỏ', N'Trung bình', '2025-01-26 10:15', '2025-01-26 11:00', N'Dùng thuốc kháng histamin'),
('PU300125MRN453', 'LT300125926', N'Sưng tại chỗ tiêm', N'Nhẹ', '2025-01-30 12:30', '2025-01-30 20:00', N'Chườm lạnh tại chỗ');



-- Phiếu khám
INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Benh_Nhan, Ma_Can_Bo, Ma_Co_So, Ngay_Kham, Noi_Dung, Chi_Dinh)
VALUES
('PK110325527', 'BNHN210035', 'CBDBP178', 'CS02', '2025-03-11', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK200325146', 'BNHN210035', 'CBBTN039', 'CS02', '2025-03-20', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK050125483', 'BNHN920012', 'CBBTA275', 'CS02', '2025-01-05', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK010425572', 'BNHN950013', 'CBHBT092', 'CS02', '2025-04-01', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK220225319', 'BNHN950041', 'CBDHA056', 'CS02', '2025-02-22', N'Tình trạng cải thiện', N'Đủ điều kiện tiêm'),
('PK080325784', 'BNHN950043', 'CBDBH019', 'CS02', '2025-03-08', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK120125364', 'BNHN991234', 'CBBTN039', 'CS02', '2025-01-12', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK110225153', 'BNHN010010', 'CBLTP003', 'CS03', '2025-02-11', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK100325426', 'BNHN020026', 'CBNBT018', 'CS03', '2025-03-10', N'Khám sức khỏe định kỳ', N'Đủ điều kiện tiêm'),
('PK170325719', 'BNHN030016', 'CBMVT029', 'CS03', '2025-03-17', N'Tình trạng tốt', N'Đủ điều kiện tiêm'),
('PK240325852', 'BNHN030016', 'CBLHD147', 'CS03', '2025-03-24', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK220325739', 'BNHN180036', 'CBLNT023', 'CS03', '2025-03-22', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK300325824', 'BNHN180036', 'CBNBT018', 'CS03', '2025-03-30', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK110325273', 'BNHN970030', 'CBLTP003', 'CS03', '2025-03-11', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK210325685', 'BNHN970030', 'CBNBT018', 'CS03', '2025-03-21', N'Huyết áp ổn định', N'Đủ điều kiện tiêm'),
('PK150325409', 'BNHN000008', 'CBLLT259', 'CS04', '2025-03-15', N'Khám sức khỏe định kỳ', N'Đủ điều kiện tiêm'),
('PK250125479', 'BNHN010003', 'CBLHV017', 'CS04', '2025-01-25', N'Khám sức khỏe định kỳ', N'Đủ điều kiện tiêm'),
('PK130125679', 'BNHN200034', 'CBLLP081', 'CS04', '2025-01-13', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK100325753', 'BNHN210039', 'CBHNN019', 'CS04', '2025-03-10', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK170325862', 'BNHN210039', 'CBLLT259', 'CS04', '2025-03-17', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK220325647', 'BNHN950041', 'CBLLP081', 'CS04', '2025-03-22', N'Thường xuyên chóng mặt', N'Không đủ điều kiện'),
('PK080325915', 'BNHN970019', 'CBLHV017', 'CS04', '2025-03-08', N'Huyết áp cao, cần theo dõi', N'Không đủ điều kiện'),
('PK150325568', 'BNHN980028', 'CBLMT231', 'CS04', '2025-03-15', N'Huyết áp ổn định', N'Đủ điều kiện tiêm'),
('PK140325825', 'BNHN990029', 'CBLLT259', 'CS04', '2025-03-14', N'Hạ sốt, sức khỏe tốt', N'Đủ điều kiện tiêm'),
('PK110125826', 'BNHN010010', 'CBVTA005', 'CS05', '2025-01-11', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK290325287', 'BNHN010023', 'CBTVH024', 'CS05', '2025-03-29', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK140225369', 'BNHN020004', 'CBDBH010', 'CS05', '2025-02-14', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK220225583', 'BNHN030005', 'CBTTN012', 'CS05', '2025-02-22', N'Huyết áp không ổn định, theo dõi thêm', N'Không đủ điều kiện'),
('PK220325694', 'BNHN030005', 'CBDBH010', 'CS05', '2025-03-22', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK180325412', 'BNHN180032', 'CBTVH024', 'CS05', '2025-03-18', N'Tiền sử dị ứng nhẹ', N'Đủ điều kiện tiêm'),
('PK250325685', 'BNHN180032', 'CBVTA005', 'CS05', '2025-03-25', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK160325246', 'BNHN190037', 'CBTTN012', 'CS05', '2025-03-16', N'Triệu chứng ổn định', N'Đủ điều kiện tiêm'),
('PK280225759', 'BNHN980007', 'CBDBH010', 'CS05', '2025-02-28', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK070325821', 'BNHN980007', 'CBVTA005', 'CS05', '2025-03-07', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK140225392', 'BNHN980017', 'CBTVH024', 'CS05', '2025-02-14', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK020325457', 'BNHN980017', 'CBTTN012', 'CS05', '2025-03-02', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK190125385', 'BNHN990002', 'CBVTA005', 'CS05', '2025-01-19', N'Tình trạng cải thiện', N'Đủ điều kiện tiêm'),
('PK110325593', 'BNHN990021', 'CBTTN012', 'CS05', '2025-03-11', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK180325712', 'BNHN990021', 'CBTVH024', 'CS05', '2025-03-18', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK100325276', 'BNHN000014', 'CBLLP008', 'CS06', '2025-03-10', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK150325762', 'BNHN010015', 'CBLLT027', 'CS06', '2025-03-15', N'Huyết áp không ổn định, theo dõi thêm', N'Không đủ điều kiện'),
('PK220325498', 'BNHN010015', 'CBNMC026', 'CS06', '2025-03-22', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK050325742', 'BNHN020018', 'CBLMT045', 'CS06', '2025-03-05', N'Sốt nhẹ', N'Không đủ điều kiện'),
('PK120325247', 'BNHN030027', 'CBDBP020', 'CS06', '2025-03-12', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK190325578', 'BNHN030027', 'CBBTN094', 'CS06', '2025-03-19', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK230325518', 'BNHN190037', 'CBLLP008', 'CS06', '2025-03-23', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK040425712', 'BNHN000025', 'CBTTD015', 'CS07', '2025-04-04', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK220325631', 'BNHN010023', 'CBHNN203', 'CS07', '2025-03-22', N'Tình trạng cải thiện', N'Đủ điều kiện tiêm'),
('PK120325815', 'BNHN020018', 'CBTNN028', 'CS07', '2025-03-12', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK290325382', 'BNHN200038', 'CBTTD015', 'CS07', '2025-03-29', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK050325294', 'BNHN220040', 'CBBTA006', 'CS07', '2025-03-05', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK050425617', 'BNHN220040', 'CBTTD015', 'CS07', '2025-04-05', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK160225428', 'BNHN970006', 'CBTTD015', 'CS07', '2025-02-16', N'Đang bị sốt', N'Không đủ điều kiện'),
('PK140125935', 'BNHN000020', 'CBPHT025', 'CS08', '2025-01-14', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK210325684', 'BNHN000020', 'CBHBT005', 'CS08', '2025-03-21', N'Đang bị sốt', N'Không đủ điều kiện'),
('PK120325348', 'BNHN000044', 'CBHBT005', 'CS08', '2025-03-12', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK210325854', 'BNHN010045', 'CBPHT025', 'CS08', '2025-03-21', N'Không có vấn đề sức khỏe', N'Đủ điều kiện tiêm'),
('PK180325327', 'BNHN030011', 'CBHBT005', 'CS08', '2025-03-18', N'Tiền sử dị ứng nhẹ', N'Đủ điều kiện tiêm'),
('PK250325468', 'BNHN030011', 'CBPHT025', 'CS08', '2025-03-25', N'Tiền sử dị ứng nhẹ', N'Đủ điều kiện tiêm'),
('PK200325136', 'BNHN030022', 'CBHBT005', 'CS08', '2025-03-20', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK160325963', 'BNHN170031', 'CBPHT025', 'CS08', '2025-03-16', N'Huyết áp cao, theo dõi thêm', N'Không đủ điều kiện'),
('PK140325357', 'BNHN190033', 'CBHBT005', 'CS08', '2025-03-14', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK180125726', 'BNHN920042', 'CBHBT005', 'CS08', '2025-01-18', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK180225835', 'BNHN920042', 'CBPHT025', 'CS08', '2025-02-18', N'Không có vấn đề sức khỏe', N'Đủ điều kiện tiêm'),
('PK250325536', 'BNHN970024', 'CBHBT005', 'CS08', '2025-03-25', N'Huyết áp cao, cần theo dõi', N'Không đủ điều kiện'),
('PK050125639', 'BNHN981001', 'CBHBT005', 'CS08', '2025-01-05', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK120125724', 'BNHN990002', 'CBPHT025', 'CS08', '2025-01-12', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK200225476', 'BNHN990009', 'CBHBT005', 'CS08', '2025-02-20', N'Huyết áp ổn định', N'Đủ điều kiện tiêm'),
('PK010225391', 'BNHCM000053', 'CBMVT029', 'CS09', '2025-02-01', N'Tiền sử dị ứng nhẹ', N'Đủ điều kiện tiêm'),
('PK100225158', 'BNHCM980046', 'CBPTH002', 'CS09', '2025-02-10', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK100125742', 'BNHCM000048', 'CBPTH014', 'CS10', '2025-01-10', N'Khám sức khỏe định kỳ', N'Đủ điều kiện tiêm'),
('PK050325867', 'BNHCM020049', 'CBPTK016', 'CS10', '2025-03-05', N'Khám sức khỏe định kỳ', N'Đủ điều kiện tiêm'),
('PK010425623', 'BNHCM030050', 'CBNVA001', 'CS10', '2025-04-01', N'Khám sức khỏe định kỳ', N'Đủ điều kiện tiêm');


--Nhập data cho chi tiết lô

INSERT INTO CHI_TIET_LO_VACCINE (Ma_Lo, Ma_Co_So, So_Lieu_Da_Su_Dung, So_Lieu_Ton_Kho, Ngay_Nhap, Ngay_Xuat)  
VALUES  
('ADV230706', 'CS09', 50, 139, '2024-02-01', NULL),
('BCG230517', 'KH01', 0, 135, '2023-05-05', NULL),
('BCG230528', 'KH01', 0, 140, '2023-05-10', NULL),
('BCG240344', 'CS03', 30, 110, '2024-02-05', NULL),
('BCG240349', 'CS02', 40, 115, '2024-02-10', NULL),
('BCG240356', 'CS04', 25, 115, '2024-02-12', NULL),
('BCG240398', 'CS08', 20, 125, '2024-02-15', NULL),
('BCG240399', 'CS10', 35, 125, '2024-02-20', NULL),
('BCG250153', 'KH01', 0, 150, '2025-01-20', NULL),
('CHINA230801', 'CS09', 123, 30, '2024-03-01', NULL),
('CHTYP241001', 'CS03', 150, 30, '2024-03-02', NULL),
('COVID230801', 'CS07', 60, 92, '2024-02-25', NULL),
('DEZOS241001', 'CS02', 150, 50, '2024-03-03', NULL),
('DTP241105', 'CS05', 45, 165, '2024-03-01', NULL),
('FLU231204', 'KH01', 0, 167, '2023-12-05', NULL),
('FRDTP241101', 'CS08', 200, 10, '2024-03-05', NULL),
('HAVB241212', 'CS06', 50, 125, '2024-03-05', NULL),
('HAVB241223', 'CS09', 55, 125, '2024-03-10', NULL),
('HAVB250152', 'CS03', 40, 150, '2024-03-12', NULL),
('HBP231210', 'KH01', 0, 198, '2023-12-05', NULL),
('HBP231221', 'KH01', 0, 200, '2023-12-18', NULL),
('HPV241013', 'CS02', 30, 108, '2024-03-15', NULL),
('HPV241024', 'CS04', 35, 114, '2024-03-18', NULL),
('HPV250157', 'CS08', 50, 100, '2024-03-20', NULL),
('IMJ241009', 'CS10', 20, 112, '2024-03-25', NULL),
('INROT241001', 'CS07', 150, 20, '2024-03-07', NULL),
('JAPJP231201', 'CS05', 100, 45, '2024-03-08', NULL),
('JEV231208', 'CS07', 60, 113, '2024-03-28', NULL),
('JPNIP241001', 'CS06', 150, 40, '2024-03-09', NULL),
('KORHBP231201', 'CS09', 120, 50, '2024-03-10', NULL),
('MEN241014', 'KH01', 0, 164, '2024-10-05', NULL),
('MEN241025', 'KH01', 0, 175, '2024-10-20', NULL),
('MEN250158', 'CS05', 45, 125, '2024-03-30', NULL),
('MRN230615', 'CS06', 50, 132, '2024-04-02', NULL),
('MRN230626', 'CS09', 55, 135, '2024-04-05', NULL),
('MRN231016', 'CS03', 40, 102, '2024-04-08', NULL),
('MRN231027', 'CS02', 30, 123, '2024-04-10', NULL),
('MRN250154', 'CS04', 35, 125, '2024-04-12', NULL),
('MRN250155', 'CS08', 50, 150, '2024-04-15', NULL),
('PEN241019', 'KH01', 0, 218, '2024-10-05', NULL),
('PEN241030', 'KH01', 0, 220, '2024-10-25', NULL),
('PEN250151', 'CS10', 20, 210, '2024-04-18', NULL),
('RAB241320', 'KH01', 0, 195, '2024-12-05', NULL),
('ROT241007', 'KH01', 0, 145, '2024-10-05', NULL),
('RUSSP230901', 'CS03', 140, 20, '2024-03-11', NULL),
('SPT230911', 'CS07', 60, 97, '2024-04-20', NULL),
('SPT230922', 'CS05', 45, 118, '2024-04-22', NULL),
('TYP241002', 'CS06', 50, 128, '2024-04-25', NULL),
('USBVG241201', 'CS02', 180, 0, '2024-03-12', NULL),
('USHPV241001', 'CS04', 170, 20, '2024-03-13', NULL),
('USMEN241001', 'CS08', 130, 29, '2024-03-14', NULL),
('USMRN230601', 'CS10', 200, 10, '2024-03-15', NULL),
('USMRN231001', 'CS07', 160, 40, '2024-03-16', NULL),
('VER231118', 'CS09', 55, 115, '2024-04-28', NULL),
('VER231129', 'CS03', 40, 140, '2024-04-30', NULL),
('VER250156', 'KH01', 0, 180, '2025-01-25', NULL),
('VNBGC230501', 'CS05', 120, 50, '2024-03-17', NULL),
('VNFVR231101', 'CS06', 140, 20, '2024-03-18', NULL),
('VNPEN241001', 'CS09', 150, 50, '2024-03-19', NULL),
('VNRVG241201', 'CS03', 110, 20, '2024-03-20', NULL),
('ZOS241003', 'CS02', 30, 104, '2024-05-02', NULL);



-- Lệnh INSERT dữ liệu vào bảng LICH_HEN (chỉ ngày tháng năm, không giờ phút giây)
INSERT INTO LICH_HEN (Ma_Lich_Hen, Ma_Co_So, Ma_Benh_Nhan, Ngay_Hen, Ngay_Dat_Lich, Ghi_Chu, Tinh_Trang_Lich)
VALUES
('LH250105738', 'CS02', 'BNHN920012', '2025-01-05', '2024-12-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH250105778', 'CS08', 'BNHN981001', '2025-01-05', '2024-12-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH250110285', 'CS10', 'BNHCM000048', '2025-01-10', '2024-12-20', N'Khám Tiêm', N'Đã xác nhận'),
('LH250111429', 'CS05', 'BNHN010010', '2025-01-11', '2024-12-07', N'Khám Tiêm', N'Đã xác nhận'),
('LH250112980', 'CS08', 'BNHN990002', '2025-01-12', '2024-11-24', N'Khám Tiêm', N'Đã xác nhận'),
('LH250112192', 'CS02', 'BNHN991234', '2025-01-12', '2024-12-18', N'Khám Tiêm', N'Đã xác nhận'),
('LH250113021', 'CS04', 'BNHN200034', '2025-01-13', '2024-12-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH250314492', 'CS08', 'BNHN000020', '2025-01-14', '2025-03-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH250118940', 'CS08', 'BNHN920042', '2025-01-18', '2025-01-06', N'Khám Tiêm', N'Đã xác nhận'),
('LH250119081', 'CS05', 'BNHN990002', '2025-01-19', '2024-11-29', N'Khám Tiêm', N'Đã xác nhận'),
('LH250120526', 'CS02', 'BNHN210035', '2025-01-20', '2024-12-22', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250120273', 'CS03', 'BNHN980017', '2025-01-20', '2024-12-25', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250122631', 'CS03', 'BNHN010010', '2025-01-22', '2024-12-08', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250122031', 'CS04', 'BNHN210039', '2025-01-22', '2025-01-07', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250124708', 'CS05', 'BNHN180032', '2025-01-24', '2024-12-27', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250125638', 'CS04', 'BNHN010003', '2025-01-25', '2024-12-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH250126794', 'CS05', 'BNHN000020', '2025-01-26', '2024-12-12', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250130758', 'CS04', 'BNHN970019', '2025-01-30', '2024-12-07', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250201893', 'CS09', 'BNHCM000053', '2025-02-01', '2025-01-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH250201736', 'CS10', 'BNHCM000048', '2025-02-01', '2025-01-15', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250201960', 'CS08', 'BNHN970024', '2025-02-01', '2024-12-28', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250210663', 'CS09', 'BNHCM980046', '2025-02-10', '2025-01-20', N'Khám Tiêm', N'Đã xác nhận'),
('LH250210438', 'CS05', 'BNHN010023', '2025-02-10', '2025-01-21', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250211530', 'CS03', 'BNHN010010', '2025-02-11', '2025-01-16', N'Khám Tiêm', N'Đã xác nhận'),
('LH250214245', 'CS05', 'BNHN020004', '2025-02-14', '2024-12-30', N'Khám Tiêm', N'Đã xác nhận'),
('LH250214172', 'CS05', 'BNHN980017', '2025-02-14', '2025-01-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH250215642', 'CS09', 'BNHCM000053', '2025-02-15', '2025-02-05', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250216556', 'CS07', 'BNHN970006', '2025-02-16', '2025-01-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH250218041', 'CS08', 'BNHN920042', '2025-02-18', '2025-01-17', N'Khám Tiêm', N'Đã xác nhận'),
('LH250220182', 'CS08', 'BNHN990009', '2025-02-20', '2025-01-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH250220846', 'CS02', 'BNHN010003', '2025-02-20', '2025-01-01', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250220364', 'CS02', 'BNHN970030', '2025-02-20', '2025-01-26', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250222354', 'CS05', 'BNHN030005', '2025-02-22', '2024-12-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH250222849', 'CS02', 'BNHN950041', '2025-02-22', '2024-12-29', N'Khám Tiêm', N'Đã xác nhận'),
('LH250222536', 'CS06', 'BNHN220040', '2025-02-22', '2025-01-22', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250224548', 'CS06', 'BNHN020018', '2025-02-24', '2024-12-27', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250228970', 'CS05', 'BNHN980007', '2025-02-28', '2025-02-10', N'Khám Tiêm', N'Đã xác nhận'),
('LH250301824', 'CS09', 'BNHCM980046', '2025-03-01', '2025-02-15', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250302071', 'CS05', 'BNHN980017', '2025-03-02', '2025-02-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH250304546', 'CS02', 'BNHN950013', '2025-03-04', '2025-01-18', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250305127', 'CS10', 'BNHCM020049', '2025-03-05', '2025-02-10', N'Khám Tiêm', N'Đã xác nhận'),
('LH250305346', 'CS06', 'BNHN020018', '2025-03-05', '2025-02-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH250305334', 'CS07', 'BNHN220040', '2025-03-05', '2025-02-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH250307768', 'CS05', 'BNHN980007', '2025-03-07', '2025-02-11', N'Khám Tiêm', N'Đã xác nhận'),
('LH250308455', 'CS02', 'BNHN950043', '2025-03-08', '2025-01-21', N'Khám Tiêm', N'Đã xác nhận'),
('LH250308657', 'CS04', 'BNHN970019', '2025-03-08', '2025-02-19', N'Khám Tiêm', N'Đã xác nhận'),
('LH250110284', 'CS06', 'BNHN000014', '2025-03-10', '2025-01-25', N'Khám Tiêm', N'Đã xác nhận'),
('LH250310750', 'CS03', 'BNHN020026', '2025-03-10', '2025-02-23', N'Khám Tiêm', N'Đã xác nhận'),
('LH250310829', 'CS04', 'BNHN210039', '2025-03-10', '2025-02-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH250311425', 'CS02', 'BNHN210035', '2025-03-11', '2025-02-19', N'Khám Tiêm', N'Đã xác nhận'),
('LH250311263', 'CS03', 'BNHN970030', '2025-03-11', '2025-01-11', N'Khám Tiêm', N'Đã xác nhận'),
('LH250311485', 'CS05', 'BNHN990021', '2025-03-11', '2025-02-25', N'Khám Tiêm', N'Đã xác nhận'),
('LH250312724', 'CS08', 'BNHN000044', '2025-03-12', '2025-02-27', N'Khám Tiêm', N'Đã xác nhận'),
('LH250312447', 'CS07', 'BNHN020018', '2025-03-12', '2025-03-04', N'Khám Tiêm', N'Đã xác nhận'),
('LH250312566', 'CS06', 'BNHN030027', '2025-03-12', '2025-01-16', N'Khám Tiêm', N'Đã xác nhận'),
('LH250314213', 'CS08', 'BNHN190033', '2025-03-14', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH250314788', 'CS04', 'BNHN990029', '2025-03-14', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH250314556', 'CS08', 'BNHN030011', '2025-03-14', '2025-02-28', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250315925', 'CS04', 'BNHN000008', '2025-03-15', '2025-03-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH250315135', 'CS06', 'BNHN010015', '2025-03-15', '2025-01-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH250315677', 'CS04', 'BNHN980028', '2025-03-15', '2025-02-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH250316869', 'CS08', 'BNHN170031', '2025-03-16', '2025-02-17', N'Khám Tiêm', N'Đã xác nhận'),
('LH250316516', 'CS05', 'BNHN190037', '2025-03-16', '2025-02-06', N'Khám Tiêm', N'Đã xác nhận'),
('LH250317960', 'CS03', 'BNHN030016', '2025-03-17', '2025-03-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH250317930', 'CS04', 'BNHN210039', '2025-03-17', '2025-02-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH250318657', 'CS08', 'BNHN030011', '2025-03-18', '2025-01-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH250318607', 'CS05', 'BNHN180032', '2025-03-18', '2025-02-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH250318586', 'CS05', 'BNHN990021', '2025-03-18', '2025-02-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH250319667', 'CS06', 'BNHN030027', '2025-03-19', '2025-02-21', N'Khám Tiêm', N'Đã xác nhận'),
('LH250320263', 'CS08', 'BNHN030022', '2025-03-20', '2025-02-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH250320627', 'CS02', 'BNHN210035', '2025-03-20', '2025-01-30', N'Khám Tiêm', N'Đã xác nhận'),
('LH250320486', 'CS09', 'BNHCM020049', '2025-03-20', '2025-03-10', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250320374', 'CS03', 'BNHN980017', '2025-03-20', '2025-02-18', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250321683', 'CS08', 'BNHN000020', '2025-03-21', '2025-01-24', N'Khám Tiêm', N'Đã xác nhận'),
('LH250321943', 'CS08', 'BNHN010045', '2025-03-21', '2025-03-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH250321465', 'CS03', 'BNHN970030', '2025-03-21', '2025-03-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH250322337', 'CS06', 'BNHN010015', '2025-03-22', '2025-03-03', N'Khám Tiêm', N'Đã xác nhận'),
('LH250322640', 'CS07', 'BNHN010023', '2025-03-22', '2025-02-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH250322455', 'CS05', 'BNHN030005', '2025-03-22', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH250322011', 'CS03', 'BNHN180036', '2025-03-22', '2025-02-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH250322950', 'CS04', 'BNHN950041', '2025-03-22', '2025-01-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH250323718', 'CS06', 'BNHN190037', '2025-03-23', '2025-03-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH250324162', 'CS03', 'BNHN030016', '2025-03-24', '2025-03-08', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325859', 'CS08', 'BNHN030011', '2025-03-25', '2025-01-29', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325809', 'CS05', 'BNHN180032', '2025-03-25', '2025-03-03', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325162', 'CS08', 'BNHN970024', '2025-03-25', '2025-02-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH250327283', 'CS08', 'BNHN990009', '2025-03-27', '2025-03-07', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250329741', 'CS05', 'BNHN010023', '2025-03-29', '2025-03-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH250329324', 'CS07', 'BNHN200038', '2025-03-29', '2025-02-16', N'Khám Tiêm', N'Đã xác nhận'),
('LH250330112', 'CS03', 'BNHN180036', '2025-03-30', '2025-03-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH250401752', 'CS10', 'BNHCM030050', '2025-04-01', '2025-03-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH250401445', 'CS02', 'BNHN950013', '2025-04-01', '2025-02-06', N'Khám Tiêm', N'Đã xác nhận'),
('LH250401238', 'CS04', 'BNHN000008', '2025-04-01', '2025-03-20', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250404237', 'CS07', 'BNHN000025', '2025-04-04', '2025-03-10', N'Khám Tiêm', N'Đã xác nhận'),
('LH250405435', 'CS07', 'BNHN220040', '2025-04-05', '2025-03-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH250409144', 'CS05', 'BNHN020004', '2025-04-09', '2025-03-17', N'Lịch tiêm vaccine', N'Đã gửi mail'),
('LH250411839', 'CS02', 'BNHN920012', '2025-04-11', '2025-03-21', N'Lịch tiêm vaccine', N'Đã gửi mail'),
('LH250414314', 'CS08', 'BNHN190033', '2025-04-14', '2025-03-11', N'Khám Tiêm', N'Đang chờ'),
('LH250415329', 'CS10', 'BNHCM030050', '2025-04-15', '2025-04-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250419735', 'CS08', 'BNHN000044', '2025-04-19', '2025-03-27', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250420970', 'CS03', 'BNHN170031', '2025-04-20', '2025-04-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250420728', 'CS02', 'BNHN210035', '2025-04-20', '2025-03-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250421617', 'CS08', 'BNHN190037', '2025-04-21', '2025-03-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250322157', 'CS03', 'BNHN000014', '2025-04-22', '2025-03-15', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250422142', 'CS08', 'BNHN920042', '2025-04-22', '2025-03-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250422051', 'CS08', 'BNHN950041', '2025-04-22', '2025-03-08', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250422687', 'CS03', 'BNHN990021', '2025-04-22', '2025-04-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250422889', 'CS04', 'BNHN990029', '2025-04-22', '2025-02-27', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250423061', 'CS03', 'BNHN030016', '2025-04-23', '2025-02-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250424869', 'CS05', 'BNHN980007', '2025-04-24', '2025-03-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250425768', 'CS06', 'BNHN030027', '2025-04-25', '2025-03-25', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250425132', 'CS04', 'BNHN210039', '2025-04-25', '2025-03-15', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250427862', 'CS02', 'BNHN000025', '2025-04-27', '2025-03-12', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250427364', 'CS08', 'BNHN030022', '2025-04-27', '2025-04-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250428879', 'CS04', 'BNHN981001', '2025-04-28', '2025-03-27', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250429825', 'CS05', 'BNHN000020', '2025-04-29', '2025-04-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250429384', 'CS08', 'BNHN990009', '2025-04-29', '2025-03-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250430415', 'CS08', 'BNHN190033', '2025-04-30', '2025-04-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250503819', 'CS04', 'BNHN200034', '2025-05-03', '2025-03-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250404354', 'CS02', 'BNHN950043', '2025-05-04', '2025-04-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250505188', 'CS09', 'BNHCM010055', '2025-05-05', '2025-04-01', N'Khám Tiêm', N'Đang chờ'),
('LH250506153', 'CS03', 'BNHN030005', '2025-05-06', '2025-04-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250510539', 'CS02', 'BNHN010023', '2025-05-10', '2025-03-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250510990', 'CS02', 'BNHN991234', '2025-05-10', '2025-03-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250511851', 'CS03', 'BNHN020026', '2025-05-11', '2025-04-15', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250512833', 'CS04', 'BNHN010015', '2025-05-12', '2025-05-01', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250513122', 'CS02', 'BNHN200038', '2025-05-13', '2025-03-31', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250514842', 'CS04', 'BNHN010045', '2025-05-14', '2025-03-20', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250519477', 'CS09', 'BNHCM010055', '2025-05-19', '2025-05-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250520913', 'CS07', 'BNHN000025', '2025-05-20', '2025-03-13', N'Khám Tiêm', N'Đang chờ'),
('LH250522637', 'CS07', 'BNHN220040', '2025-05-22', '2025-05-12', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250522243', 'CS08', 'BNHN920042', '2025-05-22', '2025-04-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250522152', 'CS02', 'BNHN950041', '2025-05-22', '2025-04-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250522475', 'CS03', 'BNHN980017', '2025-05-22', '2025-04-08', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250524732', 'CS03', 'BNHN010010', '2025-05-24', '2025-05-08', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250524758', 'CS08', 'BNHN030011', '2025-05-24', '2025-05-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250525649', 'CS06', 'BNHN020018', '2025-05-25', '2025-04-13', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250525910', 'CS04', 'BNHN180032', '2025-05-25', '2025-04-02', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250526148', 'CS02', 'BNHN000025', '2025-05-26', '2025-03-28', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250527465', 'CS08', 'BNHN030022', '2025-05-27', '2025-05-01', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250529916', 'CS05', 'BNHN000020', '2025-05-29', '2025-05-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250529566', 'CS03', 'BNHN970030', '2025-05-29', '2025-05-03', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250530859', 'CS04', 'BNHN970019', '2025-05-30', '2025-05-16', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250603920', 'CS04', 'BNHN200034', '2025-06-03', '2025-04-21', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250605952', 'CS03', 'BNHN030005', '2025-06-05', '2025-05-11', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250607647', 'CS04', 'BNHN950013', '2025-06-07', '2025-05-29', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250608061', 'CS08', 'BNHN970024', '2025-06-08', '2025-04-25', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250610091', 'CS04', 'BNHN991234', '2025-06-10', '2025-05-26', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250612934', 'CS03', 'BNHN010015', '2025-06-12', '2025-06-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250622368', 'CS03', 'BNHN000014', '2025-06-22', '2025-06-09', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250622957', 'CS02', 'BNHN010003', '2025-06-22', '2025-04-23', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250622344', 'CS08', 'BNHN920042', '2025-06-22', '2025-05-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250622253', 'CS02', 'BNHN950041', '2025-06-22', '2025-06-02', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250622576', 'CS03', 'BNHN980017', '2025-06-22', '2025-04-28', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250625233', 'CS04', 'BNHN210039', '2025-06-25', '2025-05-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250626759', 'CS08', 'BNHN000025', '2025-06-26', '2025-05-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250629667', 'CS03', 'BNHN970030', '2025-06-29', '2025-05-19', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250707748', 'CS04', 'BNHN950013', '2025-07-07', '2025-06-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250719236', 'CS03', 'BNHN010015', '2025-07-19', '2025-06-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250717596', 'CS03', 'BNHN170031', '2025-07-20', '2025-05-25', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250921223', 'CS02', 'BNHN200038', '2025-09-21', '2025-08-30', N'Lịch tiêm vaccine', N'Đang chờ');


INSERT INTO CHI_TIET_LICH_HEN (Ma_Lich_Hen, Ma_Vaccine) VALUES
('LH250201736', 'VNBGC2305'),
('LH250201960', 'FRDTP2411'),
('LH250301824', 'VNFVR2311'),
('LH250401238', 'VNBGC2305'),
('LH250503819', 'USHPV2410'),
('LH250603920', 'USHPV2410'),
('LH250304546', 'DEZOS2410'),
('LH250404354', 'DEZOS2410'),
('LH250605952', 'VNFVR2311'),
('LH250506153', 'VNFVR2311'),
('LH250607647', 'USHPV2410'),
('LH250707748', 'USHPV2410'),
('LH250608061', 'FRDTP2411'),
('LH250409144', 'USHPV2410'),
('LH250210438', 'VNBGC2305'),
('LH250510539', 'JAPJP2312'),
('LH250510990', 'DEZOS2410'),
('LH250610091', 'USMRN2310'),
('LH250411839', 'DEZOS2410'),
('LH250511851', 'RUSSP2309'),
('LH250512833', 'VNBGC2305'),
('LH250612934', 'RUSSP2309'),
('LH250513122', 'USMRN2310'),
('LH250314556', 'USMEN2410'),
('LH250514842', 'USMEN2410'),
('LH250215642', 'CHINA2308'),
('LH250415329', 'JPNIP2410'),
('LH250419735', 'VNBGC2305'),
('LH250519477', 'GBADV2307'),
('LH250719236', 'RUSSP2309'),
('LH250120273', 'JAPJP2312'),
('LH250120526', 'USBVG2412'),
('LH250220364', 'USBVG2412'),
('LH250220846', 'USHPV2410'),
('LH250320374', 'USBVG2412'),
('LH250320486', 'USMRN2306'),
('LH250420970', 'USBVG2412'),
('LH250420728', 'USBVG2412'),
('LH250717596', 'USBVG2412'),
('LH250421617', 'USMEN2410'),
('LH250921223', 'USBVG2412'),
('LH250122031', 'USMRN2310'),
('LH250122631', 'VNFVR2311'),
('LH250222536', 'JPNIP2410'),
('LH250322157', 'RUSSP2309'),
('LH250422687', 'CHTYP2410'),
('LH250422142', 'FRDTP2411'),
('LH250422889', 'VNBGC2305'),
('LH250422051', 'VNBGC2305'),
('LH250522475', 'USBVG2412'),
('LH250522152', 'USMRN2310'),
('LH250522243', 'FRDTP2411'),
('LH250522637', 'RUSSP2309'),
('LH250622957', 'USHPV2410'),
('LH250622253', 'USMRN2310'),
('LH250622368', 'RUSSP2309'),
('LH250622344', 'FRDTP2411'),
('LH250622576', 'USBVG2412'),
('LH250423061', 'VNRVG2413'),
('LH250124708', 'RUSSP2309'),
('LH250224548', 'USBVG2412'),
('LH250424869', 'FRDTP2411'),
('LH250524732', 'VNFVR2311'),
('LH250524758', 'USMEN2410'),
('LH250425132', 'VNBGC2305'),
('LH250425768', 'VNFVR2311'),
('LH250525649', 'USBVG2412'),
('LH250525910', 'VNBGC2305'),
('LH250625233', 'USMRN2310'),
('LH250126794', 'FRDTP2411'),
('LH250526148', 'USMRN2306'),
('LH250626759', 'USMRN2306'),
('LH250327283', 'USMRN2306'),
('LH250427364', 'FRDTP2411'),
('LH250427862', 'VNBGC2305'),
('LH250527465', 'FRDTP2411'),
('LH250428879', 'VNBGC2305'),
('LH250429384', 'USMRN2306'),
('LH250429825', 'FRDTP2411'),
('LH250529916', 'FRDTP2411'),
('LH250529566', 'USBVG2412'),
('LH250629667', 'USBVG2412'),
('LH250130758', 'USMRN2310'),
('LH250430415', 'USMRN2306'),
('LH250530859', 'USMRN2310');
