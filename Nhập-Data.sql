USE [Udcsdl-19-2]
GO

--Nhập liệu cho bảng bệnh nhân
INSERT INTO BENH_NHAN (Ma_Benh_Nhan, Ho_Ten, Ngay_Sinh, Gioi_Tinh, Dia_Chi, So_Dien_Thoai, Email, CCCD, Nguoi_Giam_Ho, Trang_Thai) 
VALUES (
    'BNHN991234',  -- Mã bệnh nhân (Hà Nội, sinh 1999, STT 1234)
    N'Trần Minh Hoàng',
    '1999-08-22',
    1,  -- Nam (1: Nam, 0: Nữ, NULL: Không xác định)
    N'123 Lê Lợi, Q.1, TP.HCM',
    '0912345678',
    'tranminhhoang@gmail.com',
    '079202000001',  -- Số CCCD (có thể NULL)
    0,  -- Không có người giám hộ (1: Có, 0: Không)
    1   -- Trạng thái hoạt động (1: Hoạt động, 0: Không hoạt động)
);

INSERT INTO BENH_NHAN (Ma_Benh_Nhan, Ho_Ten, Ngay_Sinh, Gioi_Tinh, Dia_Chi, So_Dien_Thoai, Email, CCCD, Nguoi_Giam_Ho, Trang_Thai) 
VALUES
    ('BNHN981001', N'Nguyễn Văn Hải', '1998-01-15', 1, N'12 Cầu Giấy, Hà Nội', '0912345001', 'nguyenvanhai@gmail.com', '001234567891', 0, 1),
    ('BNHN990002', N'Trần Thị Lan', '1999-05-20', 0, N'45 Tây Hồ, Hà Nội', '0912345002', 'tranthilan@gmail.com', '002345678912', 0, 1),
    ('BNHN010003', N'Lê Quang Huy', '2001-09-10', 1, N'78 Đống Đa, Hà Nội', '0912345003', 'lequanghuy@gmail.com', '003456789123', 0, 1),
    ('BNHN020004', N'Hoàng Minh Đức', '2002-11-25', 1, N'22 Hai Bà Trưng, Hà Nội', '0912345004', 'hoangminhduc@gmail.com', '004567891234', 0, 1),
    ('BNHN030005', N'Phạm Thu Hằng', '2003-03-05', 0, N'90 Hoàn Kiếm, Hà Nội', '0912345005', 'phamthuhang@gmail.com', '005678912345', 0, 1),
    ('BNHN970006', N'Vũ Hoài Nam', '1997-07-30', 1, N'15 Ba Đình, Hà Nội', '0912345006', 'vuhoainam@gmail.com', '006789123456', 0, 1),
    ('BNHN980007', N'Đỗ Thị Thanh', '1998-12-18', 0, N'36 Thanh Xuân, Hà Nội', '0912345007', 'dothithanh@gmail.com', '007891234567', 0, 1),
    ('BNHN000008', N'Ngô Văn Toàn', '2000-04-22', 1, N'55 Hoàng Mai, Hà Nội', '0912345008', 'ngovantoan@gmail.com', '008912345678', 0, 1),
    ('BNHN990009', N'Bùi Thu Phương', '1999-06-14', 0, N'87 Long Biên, Hà Nội', '0912345009', 'buithuphuong@gmail.com', '009123456789', 0, 1),
    ('BNHN010010', N'Đinh Tiến Dũng', '2001-10-29', 1, N'33 Bắc Từ Liêm, Hà Nội', '0912345010', 'dinhtiendung@gmail.com', '010234567890', 0, 1),
    
    ('BNHN030011', N'Nguyễn Thị Mai', '2003-08-19', 0, N'66 Nam Từ Liêm, Hà Nội', '0912345011', 'nguyenthimai@gmail.com', '011345678901', 0, 1),
    ('BNHN920012', N'Hoàng Văn Kiên', '1992-01-10', 1, N'99 Cầu Giấy, Hà Nội', '0912345012', 'hoangvankien@gmail.com', '012456789012', 0, 1),
    ('BNHN950013', N'Phạm Văn Hoàng', '1995-02-05', 1, N'12 Tây Hồ, Hà Nội', '0912345013', 'phamvanhoang@gmail.com', '013567890123', 0, 1),
    ('BNHN000014', N'Lê Thị Ngọc', '2000-07-25', 0, N'55 Đống Đa, Hà Nội', '0912345014', 'lethingoc@gmail.com', '014678901234', 0, 1),
    ('BNHN010015', N'Trần Minh Tâm', '2001-09-18', 1, N'77 Hoàn Kiếm, Hà Nội', '0912345015', 'tranminhtam@gmail.com', '015789012345', 0, 1),
    ('BNHN030016', N'Nguyễn Tuấn Anh', '2003-06-07', 1, N'90 Hai Bà Trưng, Hà Nội', '0912345016', 'nguyentuananh@gmail.com', '016890123456', 0, 1),
    ('BNHN980017', N'Vũ Thanh Hà', '1998-12-21', 0, N'42 Ba Đình, Hà Nội', '0912345017', 'vuthanhha@gmail.com', '017901234567', 0, 1),
    ('BNHN020018', N'Đỗ Hữu Phước', '2002-03-03', 1, N'33 Thanh Xuân, Hà Nội', '0912345018', 'dohuuphuoc@gmail.com', '018012345678', 0, 1),
    ('BNHN970019', N'Ngô Văn Minh', '1997-11-14', 1, N'11 Hoàng Mai, Hà Nội', '0912345019', 'ngovanminh@gmail.com', '019123456780', 0, 1),
    ('BNHN000020', N'Bùi Hồng Nhung', '2000-04-25', 0, N'77 Long Biên, Hà Nội', '0912345020', 'buihongnhung@gmail.com', '020234567891', 0, 1),
    
    ('BNHN990021', N'Đinh Văn Thắng', '1999-07-12', 1, N'55 Bắc Từ Liêm, Hà Nội', '0912345021', 'dinhvanthang@gmail.com', '021345678902', 0, 1),
    ('BNHN030022', N'Nguyễn Văn Bình', '2003-02-20', 1, N'88 Nam Từ Liêm, Hà Nội', '0912345022', 'nguyenvanbinh@gmail.com', '022456789013', 0, 1),
    ('BNHN010023', N'Hoàng Ngọc Lan', '2001-09-28', 0, N'33 Cầu Giấy, Hà Nội', '0912345023', 'hoangngoclan@gmail.com', '023567890124', 0, 1),
    ('BNHN970024', N'Phạm Văn Hùng', '1997-11-10', 1, N'66 Tây Hồ, Hà Nội', '0912345024', 'phamvanhung@gmail.com', '024678901235', 0, 1),
    ('BNHN000025', N'Lê Thị Hương', '2000-07-15', 0, N'99 Đống Đa, Hà Nội', '0912345025', 'lethihuong@gmail.com', '025789012346', 0, 1),
    ('BNHN020026', N'Trần Minh Khang', '2002-03-27', 1, N'12 Hoàn Kiếm, Hà Nội', '0912345026', 'tranminhkhang@gmail.com', '026890123457', 0, 1),
    ('BNHN030027', N'Nguyễn Thùy Dung', '2003-06-22', 0, N'42 Hai Bà Trưng, Hà Nội', '0912345027', 'nguyenthuydung@gmail.com', '027901234568', 0, 1),
    ('BNHN980028', N'Vũ Quang Huy', '1998-12-11', 1, N'33 Ba Đình, Hà Nội', '0912345028', 'vuquanghuy@gmail.com', '028012345679', 0, 1),
    ('BNHN990029', N'Đỗ Tiến Dũng', '1999-05-14', 1, N'77 Thanh Xuân, Hà Nội', '0912345029', 'dotiendung@gmail.com', '029123456780', 0, 1),
    ('BNHN970030', N'Ngô Văn Lộc', '1997-08-05', 1, N'66 Hoàng Mai, Hà Nội', '0912345030', 'ngovanloc@gmail.com', '030234567891', 0, 1);


   INSERT INTO BENH_NHAN (Ma_Benh_Nhan, Ho_Ten, Ngay_Sinh, Gioi_Tinh, Dia_Chi, So_Dien_Thoai, Email, CCCD, Nguoi_Giam_Ho, Trang_Thai) 
VALUES
    -- 10 trẻ em có người giám hộ, chưa có căn cước
    ('BNHN170031', N'Nguyễn An Khôi', '2017-06-15', 1, N'12 Cầu Giấy, Hà Nội', '0912345031', 'nguyenankhoi@gmail.com',null, 1, 1),
    ('BNHN180032', N'Hoàng Minh Châu', '2018-08-20', 0, N'45 Tây Hồ, Hà Nội', '0912345032', 'hoangminhchau@gmail.com',null, 1, 1),
    ('BNHN190033', N'Lê Quang Nhật', '2019-09-10', 1, N'78 Đống Đa, Hà Nội', '0912345033', 'lequangnhat@gmail.com',null, 1, 1),
    ('BNHN200034', N'Phạm Gia Bảo', '2020-02-25', 1, N'22 Hai Bà Trưng, Hà Nội', '0912345034', 'phamgiabao@gmail.com', NULL, 1, 1),
    ('BNHN210035', N'Đỗ Thảo Vy', '2021-03-05', 0, N'90 Hoàn Kiếm, Hà Nội', '0912345035', 'dothaovy@gmail.com', NULL, 1, 1),
    ('BNHN180036', N'Vũ Minh Tuấn', '2018-07-30', 1, N'15 Ba Đình, Hà Nội', '0912345036', 'vuminhtuan@gmail.com', NULL, 1, 1),
    ('BNHN190037', N'Ngô Hoàng My', '2019-12-18', 0, N'36 Thanh Xuân, Hà Nội', '0912345037', 'ngohoangmy@gmail.com', NULL, 1, 1),
    ('BNHN200038', N'Trần Ngọc Bảo', '2020-04-22', 1, N'55 Hoàng Mai, Hà Nội', '0912345038', 'tranngocbao@gmail.com', NULL, 1, 1),
    ('BNHN210039', N'Bùi Anh Khoa', '2021-06-14', 1, N'87 Long Biên, Hà Nội', '0912345039', 'buianhkhoa@gmail.com', NULL, 1, 1),
    ('BNHN220040', N'Đinh Thanh Hà', '2022-10-29', 0, N'33 Bắc Từ Liêm, Hà Nội', '0912345040', 'dinhthanhha@gmail.com', NULL, 1, 1),

    -- 5 người có trạng thái = 0
    ('BNHN950041', N'Nguyễn Hữu Toàn', '1995-07-12', 1, N'66 Nam Từ Liêm, Hà Nội', '0912345041', 'nguyenhuutoan@gmail.com', '041345678901', 0, 0),
    ('BNHN920042', N'Hoàng Văn Nghĩa', '1992-01-10', 1, N'99 Cầu Giấy, Hà Nội', '0912345042', 'hoangvannghia@gmail.com', '042456789012', 0, 0),
    ('BNHN950043', N'Phạm Hoàng Nam', '1995-02-05', 1, N'12 Tây Hồ, Hà Nội', '0912345043', 'phamhoangnam@gmail.com', '043567890123', 0, 0),
    ('BNHN000044', N'Lê Văn Khánh', '2000-07-25', 1, N'55 Đống Đa, Hà Nội', '0912345044', 'levankhanh@gmail.com', '044678901234', 0, 0),
    ('BNHN010045', N'Trần Thị Huyền', '2001-09-18', 0, N'77 Hoàn Kiếm, Hà Nội', '0912345045', 'tranthihuyen@gmail.com', '045789012345', 0, 0),

    -- 10 người ở Hồ Chí Minh
    ('BNHCM980046', N'Nguyễn Văn Tín', '1998-06-25', 1, N'12 Quận 1, TP.HCM', '0912345046', 'nguyenvantin@gmail.com', '046890123456', 0, 1),
    ('BNHCM990047', N'Phạm Thị Thảo', '1999-05-20', 0, N'45 Quận 3, TP.HCM', '0912345047', 'phamthithao@gmail.com', '047901234567', 0, 1),
    ('BNHCM000048', N'Lê Minh Đức', '2000-09-10', 1, N'78 Quận 5, TP.HCM', '0912345048', 'leminhduc@gmail.com', '048012345678', 0, 1),
    ('BNHCM020049', N'Hoàng Văn Trung', '2002-11-25', 1, N'22 Quận 7, TP.HCM', '0912345049', 'hoangvantrung@gmail.com', '049123456789', 0, 1),
    ('BNHCM030050', N'Đỗ Bích Hằng', '2003-03-05', 0, N'90 Quận 10, TP.HCM', '0912345050', 'dobichhang@gmail.com', '050234567890', 0, 1),
    ('BNHCM970051', N'Vũ Hoài Phong', '1997-07-30', 1, N'15 Quận Bình Thạnh, TP.HCM', '0912345051', 'vuhoaiphong@gmail.com', '051345678901', 0, 1),
    ('BNHCM980052', N'Ngô Thanh Mai', '1998-12-18', 0, N'36 Quận Phú Nhuận, TP.HCM', '0912345052', 'ngothanhmai@gmail.com', '052456789012', 0, 1),
    ('BNHCM000053', N'Bùi Văn Hậu', '2000-04-22', 1, N'55 Quận Tân Bình, TP.HCM', '0912345053', 'buivanhau@gmail.com', '053567890123', 0, 1),
    ('BNHCM990054', N'Đinh Ngọc Dung', '1999-06-14', 0, N'87 Quận Gò Vấp, TP.HCM', '0912345054', 'dinhngocdung@gmail.com', '054678901234', 0, 1),
    ('BNHCM010055', N'Trần Hoàng Anh', '2001-10-29', 1, N'33 Quận 2, TP.HCM', '0912345055', 'tranhoanganh@gmail.com', '055789012345', 0, 1);

-- Nhập liệu cho bảng Cán bộ y tế
INSERT INTO CAN_BO_Y_TE (Ma_Can_Bo, Ho_Ten, So_Dien_Thoai, Email, Bang_Cap, Trang_Thai)
VALUES 
('CBNTTH868', N'Nguyễn Thị Thanh Hiếu', '0912978908', 'hieu.thnh@gmail.com', N'Tiến sĩ', 1),
('CBTTH888', N'Trần Thanh Hải', '0912999888', 'hai.tt@gmail.com', N'Tiến sĩ', 1),
('CBNVA001', N'Nguyễn Văn An', '0912345678', 'nguyenvana@gmail.com', N'Tiến sĩ', 1),
('CBPTH002', N'Phạm Thị Hạnh', '0987654321', 'phamthihanh@gmail.com', N'Thạc sĩ', 1),
('CBLTP003', N'Lê Tuấn Phong', '0898123456', 'letuanphong@gmail.com', N'Cử nhân', 1),
('CBTMA004', N'Trần Minh Anh', '0901122334', 'tranminhanh@gmail.com', N'Phó giáo sư - Tiến sĩ', 1),
('CBHBT005', N'Hoàng Bảo Trâm', '0977654321', 'hoangbaotram@gmail.com', N'Thạc sĩ', 1),
('CBNTT006', N'Ngô Thanh Tùng', '0866789012', 'ngothanhtung@gmail.com', N'Cử nhân', 1),
('CBPVL007', N'Phan Văn Lâm', '0834567890', 'phanvanlam@gmail.com', N'Tiến sĩ', 1),
('CBLLP008', N'Lý Lan Phương', '0923456789', 'lylanphuong@gmail.com', N'Thạc sĩ', 1),
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
('CBHNN019', N'Hoàng Như Ngọc', '0945678901', 'hoangnhungoc@gmail.com', N'Tiến sĩ', 1),
('CBDBP020', N'Đoàn Bảo Phúc', '0971234567', 'doanbaophuc@gmail.com', N'Cử nhân', 0),
('CBNTH021', N'Nguyễn Thị Hương', '0923456780', 'nguyenthihuong@gmail.com', N'Thạc sĩ', 1),
('CBPQT022', N'Phan Quang Thịnh', '0898765432', 'phanquangthinh@gmail.com', N'Phó giáo sư - Tiến sĩ', 1),
('CBLNT023', N'Lê Ngọc Trâm', '0956789013', 'lengoctram@gmail.com', N'Thạc sĩ', 1),
('CBTVH024', N'Trần Văn Hoàng', '0876543209', 'tranvanhoang@gmail.com', N'Tiến sĩ', 1),
('CBPHT025', N'Phạm Hải Tú', '0823456788', 'phamhaitu@gmail.com', N'Cử nhân', 1),
('CBNMC026', N'Nguyễn Minh Châu', '0934567890', 'nguyenminhchau@gmail.com', N'Phó giáo sư - Tiến sĩ', 0),
('CBLLT027', N'Lý Long Thịnh', '0891234567', 'lylongthinh@gmail.com', N'Thạc sĩ', 1),
('CBTNN028', N'Tô Ngọc Nam', '0987654309', 'tongocnam@gmail.com', N'Cử nhân', 1),
('CBMVT029', N'Mai Văn Thái', '0912345609', 'maivanthai@gmail.com', N'Thạc sĩ', 1),
('CBNDT030', N'Nguyễn Đình Tuấn', '0856789023', 'nguyendinhtuan@gmail.com', N'Tiến sĩ', 1);

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
    ('CBDBH24010', N'Đinh Bảo Hân', '0876543210', 'dinhbaohan@gmail.com', N'Cử nhân', 1),
    ('CBDBP24178', N'Đoàn Bảo Phúc', '0971234567', 'doanbaophuc@gmail.com', N'Cử nhân', 1),
    ('CBHBT24092', N'Hoàng Bảo Trâm', '0977654321', 'hoangbaotram@gmail.com', N'Thạc sĩ', 1),
    ('CBHNN24203', N'Hoàng Như Ngọc', '0945678901', 'hoangnhungoc@gmail.com', N'Tiến sĩ', 1),
    ('CBLHD24147', N'Lương Hoàng Dũng', '0823456789', 'luonghoangdung@gmail.com', N'Tiến sĩ', 1),
    ('CBLHV24266', N'Lê Hữu Vinh', '0845678901', 'lehuuvinh@gmail.com', N'Thạc sĩ', 1),
    ('CBLLP24081', N'Lý Lan Phương', '0923456789', 'lylanphuong@gmail.com', N'Thạc sĩ', 1),
    ('CBLLT24259', N'Lý Long Thịnh', '0891234567', 'lylongthinh@gmail.com', N'Thạc sĩ', 1),
    ('CBBTN24039', N'Bùi Thị Nga', '0901234567', 'buithinga@gmail.com', N'Bác sĩ', 1),
    ('CBPTD24194', N'Phạm Tuấn Dũng', '0912345678', 'phamtuandung@gmail.com', N'Cử nhân', 1),
    ('CBNMD24250', N'Nguyễn Minh Đức', '0934567890', 'nguyenminhduc@gmail.com', N'Thạc sĩ', 1);

UPDATE CAN_BO_Y_TE SET Bang_Cap = N'Thạc sĩ' WHERE Bang_Cap = N'Bác sĩ';

-- Cập nhật mã cán bộ theo đúng quy tắc
UPDATE CAN_BO_Y_TE SET Ma_Can_Bo = 'CBNVA001' WHERE Ma_Can_Bo = 'CBNVA24087';
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


-- Nhập liệu bảng Hồ sơ bệnh nhân 
INSERT INTO HO_SO_TIEM_CHUNG (Ma_Ho_So, Ma_Tiem_Chung, Ma_Benh_Nhan, Ngay_Tao, Trang_Thai) VALUES
('HSTMH34', '012320058912001', 'BNHN991234', '2025-03-21 07:00:00', 1),
('HSNVH01', '012320058912301', 'BNHN981001', '2025-03-21 08:00:00', 1),
('HSTTL02', '012320058912302', 'BNHN990002', '2025-03-21 08:10:00', 1),
('HSLQH03', '012320058912303', 'BNHN010003', '2025-03-21 08:20:00', 1),
('HSHMD04', '012320058912304', 'BNHN020004', '2025-03-21 08:30:00', 1),
('HSPTH05', '012320058912305', 'BNHN030005', '2025-03-21 08:40:00', 1),
('HSVHN06', '012320058912306', 'BNHN970006', '2025-03-21 08:50:00', 1),
('HSDTT07', '012320058912307', 'BNHN980007', '2025-03-21 09:00:00', 1),
('HSNVT08', '012320058912308', 'BNHN000008', '2025-03-21 09:10:00', 1),
('HSBTP09', '012320058912309', 'BNHN990009', '2025-03-21 09:20:00', 1),
('HSDTD10', '012320058912310', 'BNHN010010', '2025-03-21 09:30:00', 1),
('HSNTH11', '012320058912311', 'BNHN030011', '2025-03-21 09:40:00', 1),
('HSHVK12', '012320058912312', 'BNHN920012', '2025-03-21 09:50:00', 1),
('HSPVH13', '012320058912313', 'BNHN950013', '2025-03-21 10:00:00', 1),
('HSLTN14', '012320058912314', 'BNHN000014', '2025-03-21 10:10:00', 1),
('HSTMT15', '012320058912315', 'BNHN010015', '2025-03-21 10:20:00', 1),
('HSNTA16', '012320058912316', 'BNHN030016', '2025-03-21 10:30:00', 1),
('HSVTH17', '012320058912317', 'BNHN980017', '2025-03-21 10:40:00', 1),
('HSDHP18', '012320058912318', 'BNHN020018', '2025-03-21 10:50:00', 1),
('HSNVM19', '012320058912319', 'BNHN970019', '2025-03-21 11:00:00', 1),
('HSBHN20', '012320058912320', 'BNHN000020', '2025-03-21 11:10:00', 1),
('HSDVT21', '012320058912321', 'BNHN990021', '2025-03-21 11:20:00', 1),
('HSNVB22', '012320058912322', 'BNHN030022', '2025-03-21 11:30:00', 1),
('HSHNL23', '012320058912323', 'BNHN010023', '2025-03-21 11:40:00', 1),
('HSPVH24', '012320058912324', 'BNHN970024', '2025-03-21 11:50:00', 1),
('HSLTH25', '012320058912325', 'BNHN000025', '2025-03-21 12:00:00', 1),
('HSTMK26', '012320058912326', 'BNHN020026', '2025-03-21 12:10:00', 1),
('HSNTH27', '012320058912327', 'BNHN030027', '2025-03-21 12:20:00', 1),
('HSVQH28', '012320058912328', 'BNHN980028', '2025-03-21 12:30:00', 1),
('HSDTD29', '012320058912329', 'BNHN990029', '2025-03-21 12:40:00', 1),
('HSNVL30', '012320058912330', 'BNHN970030', '2025-03-21 12:50:00', 1),
('HSNAK31', '012320058912331', 'BNHN170031', '2025-03-21 13:00:00', 1),
('HSHMC32', '012320058912332', 'BNHN180032', '2025-03-21 13:10:00', 1),
('HSLQN33', '012320058912333', 'BNHN190033', '2025-03-21 13:20:00', 1),
('HSPGB34', '012320058912334', 'BNHN200034', '2025-03-21 13:30:00', 1),
('HSDTV35', '012320058912335', 'BNHN210035', '2025-03-21 13:40:00', 1),
('HSVMT36', '012320058912336', 'BNHN180036', '2025-03-21 13:50:00', 1),
('HSNHM37', '012320058912337', 'BNHN190037', '2025-03-21 14:00:00', 1),
('HSTNB38', '012320058912338', 'BNHN200038', '2025-03-21 14:10:00', 1),
('HSBAK39', '012320058912339', 'BNHN210039', '2025-03-21 14:20:00', 1),
('HSDTH40', '012320058912340', 'BNHN220040', '2025-03-21 14:30:00', 1),
('HSNHT41', '012320058912341', 'BNHN950041', '2025-03-21 14:40:00', 1),
('HSHVN42', '012320058912342', 'BNHN920042', '2025-03-21 14:50:00', 1),
('HSPHN43', '012320058912343', 'BNHN950043', '2025-03-21 15:00:00', 1),
('HSLVK44', '012320058912344', 'BNHN000044', '2025-03-21 15:10:00', 1),
('HSTTH45', '012320058912345', 'BNHN010045', '2025-03-21 15:20:00', 1),
('HSNVT46', '028420058912346', 'BNHCM980046', '2025-03-21 15:30:00', 1),
('HSPTT47', '028420058912347', 'BNHCM990047', '2025-03-21 15:40:00', 1),
('HSLMD48', '028420058912348', 'BNHCM000048', '2025-03-21 15:50:00', 1),
('HSHVT49', '028420058912349', 'BNHCM020049', '2025-03-21 16:00:00', 1),
('HSDBH50', '028420058912350', 'BNHCM030050', '2025-03-21 16:10:00', 1),
('HSVHP51', '028420058912351', 'BNHCM970051', '2025-03-21 16:20:00', 1),
('HSNTP52', '028420058912352', 'BNHCM980052', '2025-03-21 16:30:00', 1),
('HSBVH53', '028420058912353', 'BNHCM000053', '2025-03-21 16:40:00', 1),
('HSDND54', '028420058912354', 'BNHCM990054', '2025-03-21 16:50:00', 1),
('HSTHA55', '028420058912355', 'BNHCM010055', '2025-03-21 17:00:00', 1);

UPDATE HO_SO_TIEM_CHUNG
SET Ngay_Tao = 
    DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 90, '2024-11-01') + 
    DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % 86400, '00:00:00');



-- Nhập liệu bảng phiếu khám
INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Ho_So, Ma_Can_Bo, Ngay_Kham, Noi_Dung, Chi_Dinh) VALUES
('PK250101001', 'HSNVH01', 'CBLTP003', '2025-01-05', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK250101002', 'HSTTL02', 'CBPTH002', '2025-01-12', N'Huyết áp cao, theo dõi thêm', N'Không đủ điều kiện'),
('PK250101003', 'HSTTL02', 'CBPTH002', '2025-01-19', N'Huyết áp ổn định', N'Đủ điều kiện tiêm'),
('PK250101004', 'HSLQH03', 'CBTMA004', '2025-01-25', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK250102005', 'HSHMD04', 'CBHBT005', '2025-02-14', N'Tiền sử dị ứng nhẹ', N'Đủ điều kiện tiêm'),
('PK250102006', 'HSPTH05', 'CBDBH010', '2025-02-22', N'Đang bị sốt', N'Hủy bỏ'),
('PK250103007', 'HSPTH05', 'CBDBH010', '2025-03-22', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK250102008', 'HSVHN06', 'CBNTT006', '2025-02-16', N'Khỏe mạnh, đủ điều kiện', N'Đủ điều kiện tiêm'),
('PK250102009', 'HSDTT07', 'CBPVL007', '2025-02-28', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK250103010', 'HSDTT07', 'CBPVL007', '2025-03-07', N'Tình trạng cải thiện', N'Đủ điều kiện tiêm'),
('PK250103011', 'HSNVT08', 'CBLLP008', '2025-03-15', N'Thường xuyên chóng mặt', N'Hủy bỏ'),
('PK250104012', 'HSNVT08', 'CBLLP008', '2025-04-15', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250102013', 'HSBTP09', 'CBTCT009', '2025-02-20', N'Triệu chứng ổn định', N'Đủ điều kiện tiêm'),
('PK250101014', 'HSDTD10', 'CBDBH010', '2025-01-11', N'Cảm cúm nhẹ', N'Hủy bỏ'),
('PK250102015', 'HSDTD10', 'CBDBH010', '2025-02-11', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103016', 'HSNTH11', 'CBNVA001', '2025-03-18', N'Triệu chứng nhẹ, cần theo dõi', N'Không đủ điều kiện'),
('PK250103017', 'HSNTH11', 'CBNVA001', '2025-03-25', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250104020', 'HSPVH13', 'CBHBT005', '2025-04-01', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm');

INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Ho_So, Ma_Can_Bo, Ngay_Kham, Noi_Dung, Chi_Dinh) VALUES
('PK250103021', 'HSLTN14', 'CBPTH002', '2025-03-10', N'Khám sức khỏe định kỳ', N'Đủ điều kiện tiêm'),
('PK250103022', 'HSTMT15', 'CBLTP003', '2025-03-15', N'Huyết áp không ổn định', N'Không đủ điều kiện'),
('PK250103023', 'HSTMT15', 'CBLTP003', '2025-03-22', N'Tình trạng cải thiện', N'Đủ điều kiện tiêm'),
('PK250103024', 'HSNTA16', 'CBTMA004', '2025-03-17', N'Tiền sử dị ứng', N'Không đủ điều kiện'),
('PK250103025', 'HSNTA16', 'CBTMA004', '2025-03-24', N'Tình trạng ổn định', N'Đủ điều kiện tiêm'),
('PK250102026', 'HSVTH17', 'CBHBT005', '2025-02-14', N'Sốt cao, cần theo dõi', N'Không đủ điều kiện'),
('PK250103027', 'HSVTH17', 'CBHBT005', '2025-03-02', N'Hạ sốt, sức khỏe tốt', N'Đủ điều kiện tiêm'),
('PK250103028', 'HSDHP18', 'CBDBH010', '2025-03-05', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK250103029', 'HSDHP18', 'CBDBH010', '2025-03-12', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK250103030', 'HSNVM19', 'CBNTT006', '2025-03-08', N'Không có triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103031', 'HSBHN20', 'CBPVL007', '2025-03-14', N'Cảm cúm nhẹ', N'Không đủ điều kiện'),
('PK250103032', 'HSBHN20', 'CBPVL007', '2025-03-21', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103033', 'HSDVT21', 'CBLLP008', '2025-03-11', N'Sốt nhẹ', N'Không đủ điều kiện'),
('PK250103034', 'HSDVT21', 'CBLLP008', '2025-03-18', N'Tình trạng tốt', N'Đủ điều kiện tiêm'),
('PK250103035', 'HSNVB22', 'CBTCT009', '2025-03-20', N'Không có vấn đề sức khỏe', N'Đủ điều kiện tiêm'),
('PK250103036', 'HSHNL23', 'CBNVA001', '2025-03-22', N'Huyết áp cao, cần theo dõi', N'Không đủ điều kiện'),
('PK250103037', 'HSHNL23', 'CBNVA001', '2025-03-29', N'Huyết áp bình thường', N'Đủ điều kiện tiêm'),
('PK250103038', 'HSPVH24', 'CBTMA004', '2025-03-25', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK250103039', 'HSLTH25', 'CBHBT005', '2025-03-28', N'Triệu chứng nhẹ, cần theo dõi', N'Không đủ điều kiện'),
('PK250104040', 'HSLTH25', 'CBHBT005', '2025-04-04', N'Không còn triệu chứng', N'Đủ điều kiện tiêm');

INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Ho_So, Ma_Can_Bo, Ngay_Kham, Noi_Dung, Chi_Dinh) VALUES
('PK250103521', 'HSTMK26', 'CBLTP003', '2025-03-10', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK250103522', 'HSNTH27', 'CBPTH002', '2025-03-12', N'Huyết áp không ổn định, theo dõi thêm', N'Không đủ điều kiện'),
('PK250103523', 'HSNTH27', 'CBPTH002', '2025-03-19', N'Huyết áp ổn định', N'Đủ điều kiện tiêm'),
('PK250103524', 'HSVQH28', 'CBTMA004', '2025-03-15', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK250103525', 'HSDTD29', 'CBHBT005', '2025-03-14', N'Tiền sử dị ứng nhẹ', N'Đủ điều kiện tiêm'),
('PK250103526', 'HSNVL30', 'CBDBH010', '2025-03-11', N'Đang bị sốt', N'Hủy bỏ'),
('PK250103527', 'HSNVL30', 'CBDBH010', '2025-03-21', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK250103528', 'HSNAK31', 'CBNTT006', '2025-03-16', N'Khỏe mạnh, đủ điều kiện', N'Đủ điều kiện tiêm'),
('PK250103529', 'HSHMC32', 'CBPVL007', '2025-03-18', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK250103530', 'HSHMC32', 'CBPVL007', '2025-03-25', N'Tình trạng cải thiện', N'Đủ điều kiện tiêm'),
('PK250103531', 'HSLQN33', 'CBLLP008', '2025-03-14', N'Thường xuyên chóng mặt', N'Hủy bỏ'),
('PK250103532', 'HSLQN33', 'CBLLP008', '2025-04-14', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103534', 'HSDTV35', 'CBDBH010', '2025-03-11', N'Cảm cúm nhẹ', N'Hủy bỏ'),
('PK250103535', 'HSDTV35', 'CBDBH010', '2025-03-20', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103536', 'HSVMT36', 'CBNVA001', '2025-03-22', N'Triệu chứng nhẹ, cần theo dõi', N'Không đủ điều kiện'),
('PK250103537', 'HSVMT36', 'CBNVA001', '2025-03-30', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103538', 'HSNHM37', 'CBTMA004', '2025-03-16', N'Tiền sử bệnh tim nhẹ', N'Không đủ điều kiện'),
('PK250103539', 'HSNHM37', 'CBTMA004', '2025-03-23', N'Tình trạng ổn định', N'Đủ điều kiện tiêm'),
('PK250103540', 'HSTNB38', 'CBHBT005', '2025-03-29', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm');

INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Ho_So, Ma_Can_Bo, Ngay_Kham, Noi_Dung, Chi_Dinh) VALUES
('PK250103221', 'HSBAK39', 'CBLTP003', '2025-03-10', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK250103222', 'HSBAK39', 'CBLTP003', '2025-03-17', N'Huyết áp cao, cần theo dõi', N'Không đủ điều kiện'),
('PK250103223', 'HSDTH40', 'CBPTH002', '2025-03-05', N'Chóng mặt kéo dài', N'Hủy bỏ'),
('PK250104224', 'HSDTH40', 'CBPTH002', '2025-04-05', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250102225', 'HSNHT41', 'CBTMA004', '2025-02-22', N'Tiền sử bệnh hô hấp', N'Không đủ điều kiện'),
('PK250103226', 'HSNHT41', 'CBTMA004', '2025-03-22', N'Tình trạng sức khỏe ổn định', N'Đủ điều kiện tiêm'),
('PK250101227', 'HSHVN42', 'CBHBT005', '2025-01-18', N'Cảm cúm nhẹ', N'Hủy bỏ'),
('PK250102228', 'HSHVN42', 'CBHBT005', '2025-02-18', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103229', 'HSPHN43', 'CBDBH010', '2025-03-08', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK250103230', 'HSLVK44', 'CBNTT006', '2025-03-12', N'Tiền sử dị ứng nhẹ', N'Đủ điều kiện tiêm'),
('PK250103233', 'HSNVT46', 'CBLLP008', '2025-03-15', N'Thường xuyên chóng mặt', N'Hủy bỏ'),
('PK250104234', 'HSNVT46', 'CBLLP008', '2025-04-15', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250101901', 'HSHVK12', 'CBHBT005', '2025-01-05', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK250112902', 'HSTMH34', 'CBLLP008', '2025-01-12', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm'),
('PK250113942', 'HSPGB34', 'CBLLP008', '2025-01-13', N'Khám tổng quát định kỳ', N'Đủ điều kiện tiêm');

INSERT INTO PHIEU_KHAM (Ma_Phieu_Kham, Ma_Ho_So, Ma_Can_Bo, Ngay_Kham, Noi_Dung, Chi_Dinh)
VALUES
('PK250103821', 'HSTTH45', 'CBLTP003', '2025-03-21', N'Khám tổng quát', N'Đủ điều kiện tiêm'),
('PK250104822', 'HSNVT46', 'CBPTH002', '2025-04-01', N'Tiền sử dị ứng nhẹ', N'Không đủ điều kiện'),
('PK250104823', 'HSPTT47', 'CBTMA004', '2025-04-08', N'Cao huyết áp, cần theo dõi', N'Không đủ điều kiện'),
('PK250103824', 'HSLMD48', 'CBHBT005', '2025-03-22', N'Không có triệu chứng bất thường', N'Đủ điều kiện tiêm'),
('PK250102825', 'HSHVT49', 'CBDBH010', '2025-02-20', N'Bệnh tim nhẹ', N'Không đủ điều kiện'),
('PK250103826', 'HSHVT49', 'CBDBH010', '2025-03-10', N'Tình trạng ổn định', N'Đủ điều kiện tiêm'),
('PK250104827', 'HSDBH50', 'CBNTT006', '2025-04-05', N'Huyết áp thấp', N'Không đủ điều kiện'),
('PK250103828', 'HSVHP51', 'CBPVL007', '2025-03-25', N'Triệu chứng cảm cúm nhẹ', N'Hủy bỏ'),
('PK250104829', 'HSVHP51', 'CBPVL007', '2025-04-05', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103830', 'HSNTP52', 'CBLLP008', '2025-03-28', N'Thường xuyên chóng mặt', N'Không đủ điều kiện'),
('PK250104831', 'HSNTP52', 'CBLLP008', '2025-04-08', N'Triệu chứng đã giảm', N'Đủ điều kiện tiêm'),
('PK250103832', 'HSBVH53', 'CBTCT009', '2025-03-23', N'Khỏe mạnh, đủ điều kiện', N'Đủ điều kiện tiêm'),
('PK250102833', 'HSDND54', 'CBDBH010', '2025-02-15', N'Cảm sốt nhẹ', N'Hủy bỏ'),
('PK250103834', 'HSDND54', 'CBDBH010', '2025-03-15', N'Không còn triệu chứng', N'Đủ điều kiện tiêm'),
('PK250103835', 'HSTHA55', 'CBNVA001', '2025-03-30', N'Bệnh nền tiểu đường, cần theo dõi', N'Không đủ điều kiện'),
('PK250104836', 'HSTHA55', 'CBNVA001', '2025-04-10', N'Tình trạng ổn định', N'Đủ điều kiện tiêm');

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

-- Thêm dữ liệu vào bảng LAN_TIEM với mã lần tiêm đúng định dạng
INSERT INTO LAN_TIEM (Ma_Lan_Tiem, Ma_Ho_So, Ma_Can_Bo, Ngay_Tiem, Ket_Qua_Tiem) VALUES
-- Hồ sơ HSBAK39 - 3 lần tiêm
('LT250122066', 'HSBAK39', 'CBDBH010', '2025-01-22', N'Thành công'),
('LT250425072', 'HSBAK39', 'CBDBH010', '2025-04-25', N'Thành công'),
('LT250625016', 'HSBAK39', 'CBDBH010', '2025-06-25', N'Thành công');
INSERT INTO LAN_TIEM (Ma_Lan_Tiem, Ma_Ho_So, Ma_Can_Bo, Ngay_Tiem, Ket_Qua_Tiem) VALUES
-- Hồ sơ HSBHN20 - 3 lần tiêm
('LT250126070', 'HSBHN20', 'CBDBP020', '2025-01-26', N'Thành công'),
('LT250429038', 'HSBHN20', 'CBDBP020', '2025-04-29', N'Xảy ra phản ứng'),
('LT250529013', 'HSBHN20', 'CBDBP020', '2025-05-29', N'Thành công'),

-- Hồ sơ HSBTP09 - 2 lần tiêm
('LT250327010', 'HSBTP09', 'CBHBT005', '2025-03-27', N'Thành công'),
('LT250429077', 'HSBTP09', 'CBHBT005', '2025-04-29', N'Thành công'),

-- Hồ sơ HSVTH17 - 4 lần tiêm
('LT250120063', 'HSVTH17', 'CBPTH002', '2025-01-20', N'Thành công'),
('LT250320102', 'HSVTH17', 'CBPTH002', '2025-03-20', N'Hoãn tiêm'),
('LT250522040', 'HSVTH17', 'CBPTH002', '2025-05-22', N'Thành công'),
('LT250622020', 'HSVTH17', 'CBPTH002', '2025-06-22', N'Thành công');

INSERT INTO LAN_TIEM (Ma_Lan_Tiem, Ma_Ho_So, Ma_Can_Bo, Ngay_Tiem, Ket_Qua_Tiem) VALUES

-- Hồ sơ HSBVH53 - 2 lần tiêm
('LT250129005', 'HSBVH53', 'CBTVH024', '2025-01-29', N'Thành công'),
('LT250429058', 'HSBVH53', 'CBTVH024', '2025-04-29', N'Thành công'),

-- Hồ sơ HSDBH50 - 1 lần tiêm
('LT250422026', 'HSDBH50', 'CBDBH010', '2025-04-22', N'Thành công'),

-- Hồ sơ HSDHP18 - 2 lần tiêm
('LT250224059', 'HSDHP18', 'CBPHT025', '2025-02-24', N'Thành công'),
('LT250525041', 'HSDHP18', 'CBPHT025', '2025-05-25', N'Thành công'),

-- Hồ sơ HSDND54 - 1 lần tiêm
('LT250401071', 'HSDND54', 'CBNTT006', '2025-04-01', N'Thành công'),

-- Hồ sơ HSDTD10 - 2 lần tiêm
('LT250122041', 'HSDTD10', 'CBTCT009', '2025-01-22', N'Thành công'),
('LT250524029', 'HSDTD10', 'CBTCT009', '2025-05-24', N'Thành công'),

-- Hồ sơ HSDTD29 - 1 lần tiêm
('LT250422015', 'HSDTD29', 'CBTCT009', '2025-04-22', N'Thành công'),

-- Hồ sơ HSDTH40 - 2 lần tiêm
('LT250222034', 'HSDTH40', 'CBPTH002', '2025-02-22', N'Thành công'),
('LT250522029', 'HSDTH40', 'CBPTH002', '2025-05-22', N'Xảy ra phản ứng'),

-- Hồ sơ HSDTT07 - 1 lần tiêm
('LT250424012', 'HSDTT07', 'CBNTT006', '2025-04-24', N'Thành công'),

-- Hồ sơ HSDTV35 - 2 lần tiêm
('LT250120004', 'HSDTV35', 'CBNVA001', '2025-01-20', N'Thành công'),
('LT250420033', 'HSDTV35', 'CBNVA001', '2025-04-20', N'Thành công'),

-- Hồ sơ HSDVT21 - 1 lần tiêm
('LT250422121', 'HSDVT21', 'CBNVA001', '2025-04-22', N'Thành công'),

-- Hồ sơ HSHMC32 - 2 lần tiêm
('LT250124067', 'HSHMC32', 'CBNMC026', '2025-01-24', N'Thành công'),
('LT250525044', 'HSHMC32', 'CBNMC026', '2025-05-25', N'Thành công'),

-- Hồ sơ HSHMD04 - 1 lần tiêm
('LT250409007', 'HSHMD04', 'CBNMC026', '2025-04-09', N'Thành công'),

-- Hồ sơ HSHNL23 - 2 lần tiêm
('LT250210031', 'HSHNL23', 'CBNTH021', '2025-02-10', N'Thành công'),
('LT250510001', 'HSHNL23', 'CBNTH021', '2025-05-10', N'Thành công'),

-- Hồ sơ HSHVK12 - 1 lần tiêm
('LT250411001', 'HSHVK12', 'CBNTH021', '2025-04-11', N'Thành công'),

-- Hồ sơ HSHVN42 - 3 lần tiêm
('LT250422111', 'HSHVN42', 'CBNTH021', '2025-04-22', N'Thành công'),
('LT250522092', 'HSHVN42', 'CBNTH021', '2025-05-22', N'Xảy ra phản ứng'),
('LT250622073', 'HSHVN42', 'CBNTH021', '2025-06-22', N'Thành công'),

-- Hồ sơ HSHVT49 - 2 lần tiêm
('LT250201011', 'HSHVT49', 'CBNTH021', '2025-02-01', N'Thành công'),
('LT250503033', 'HSHVT49', 'CBNTH021', '2025-05-03', N'Thành công'),

-- Hồ sơ HSLMD48 - 1 lần tiêm
('LT250314101', 'HSLMD48', 'CBNTH021', '2025-03-14', N'Thành công'),

-- Hồ sơ HSLQH03 - 2 lần tiêm
('LT250220039', 'HSLQH03', 'CBNTH021', '2025-02-20', N'Thành công'),
('LT250622136', 'HSLQH03', 'CBNTH021', '2025-06-22', N'Thành công'),

-- Hồ sơ HSLQN33 - 1 lần tiêm
('LT250430009', 'HSLQN33', 'CBNTH021', '2025-04-30', N'Thành công'),

-- Hồ sơ HSLTH25 - 3 lần tiêm
('LT250427341', 'HSLTH25', 'CBNTH021', '2025-04-27', N'Thành công'),
('LT250526034', 'HSLTH25', 'CBNTH021', '2025-05-26', N'Hoãn tiêm'),
('LT250626095', 'HSLTH25', 'CBNTH021', '2025-06-26', N'Thành công'),

-- Hồ sơ HSLTN14 - 2 lần tiêm
('LT250422349', 'HSLTN14', 'CBNTH021', '2025-04-22', N'Thành công'),
('LT250622667', 'HSLTN14', 'CBNTH021', '2025-06-22', N'Thành công'),

-- Hồ sơ HSLVK44 - 1 lần tiêm
('LT250419001', 'HSLVK44', 'CBNTH021', '2025-04-19', N'Thành công'),

-- Hồ sơ HSNAK31 - 2 lần tiêm
('LT250420441', 'HSNAK31', 'CBNTH021', '2025-04-20', N'Thành công'),
('LT250720009', 'HSNAK31', 'CBNTH021', '2025-07-20', N'Xảy ra phản ứng'),

-- Hồ sơ HSNHM37 - 1 lần tiêm
('LT250421231', 'HSNHM37', 'CBNTH021', '2025-04-21', N'Thành công'),

-- Hồ sơ HSNHT41 - 3 lần tiêm
('LT250422231', 'HSNHT41', 'CBNTH021', '2025-04-22', N'Thành công'),
('LT250522339', 'HSNHT41', 'CBNTH021', '2025-05-22', N'Thành công'),
('LT250622463', 'HSNHT41', 'CBNTH021', '2025-06-22', N'Thành công'),

-- Hồ sơ HSNTA16 - 1 lần tiêm
('LT250423341', 'HSNTA16', 'CBNTH021', '2025-04-23', N'Thành công'),

-- Hồ sơ HSNTH11 - 2 lần tiêm
('LT250314361', 'HSNTH11', 'CBNTH021', '2025-03-14', N'Thành công'),
('LT250524056', 'HSNTH11', 'CBNTH021', '2025-05-24', N'Thành công'),

-- Hồ sơ HSNTH27 - 1 lần tiêm
('LT250425501', 'HSNTH27', 'CBNTH021', '2025-04-25', N'Thành công'),

-- Hồ sơ HSNTP52 - 3 lần tiêm
('LT250426001', 'HSNTP52', 'CBNTH021', '2025-04-26', N'Thành công'),
('LT250526002', 'HSNTP52', 'CBNTH021', '2025-05-26', N'Xảy ra phản ứng'),
('LT250626003', 'HSNTP52', 'CBNTH021', '2025-06-26', N'Thành công'),

-- Hồ sơ HSNVB22 - 2 lần tiêm
('LT250427881', 'HSNVB22', 'CBNTH021', '2025-04-27', N'Thành công'),
('LT250527642', 'HSNVB22', 'CBNTH021', '2025-05-27', N'Thành công'),

-- Hồ sơ HSNVH01 - 1 lần tiêm
('LT250428451', 'HSNVH01', 'CBNTH021', '2025-04-28', N'Thành công'),

-- Hồ sơ HSNVL30 - 3 lần tiêm
('LT250220231', 'HSNVL30', 'CBNTH021', '2025-02-20', N'Thành công'),
('LT250529092', 'HSNVL30', 'CBNTH021', '2025-05-29', N'Hoãn tiêm'),
('LT250629403', 'HSNVL30', 'CBNTH021', '2025-06-29', N'Thành công'),

-- Hồ sơ HSNVM19 - 2 lần tiêm
('LT250130431', 'HSNVM19', 'CBNTH021', '2025-01-30', N'Thành công'),
('LT250530572', 'HSNVM19', 'CBNTH021', '2025-05-30', N'Thành công'),

-- Hồ sơ HSNVT08 - 1 lần tiêm
('LT250501024', 'HSNVT08', 'CBNTH021', '2025-05-01', N'Thành công'),

-- Hồ sơ HSNVT46 - 3 lần tiêm
('LT250301871', 'HSNVT46', 'CBNTH021', '2025-03-01', N'Thành công'),
('LT250602772', 'HSNVT46', 'CBNTH021', '2025-06-02', N'Xảy ra phản ứng'),
('LT250702343', 'HSNVT46', 'CBNTH021', '2025-07-02', N'Thành công'),

-- Hồ sơ HSPGB34 - 2 lần tiêm
('LT250503067', 'HSPGB34', 'CBNTH021', '2025-05-03', N'Thành công'),
('LT250603035', 'HSPGB34', 'CBNTH021', '2025-06-03', N'Thành công'),

-- Hồ sơ HSPHN43 - 1 lần tiêm
('LT250504356', 'HSPHN43', 'CBNTH021', '2025-05-04', N'Thành công'),

-- Hồ sơ HSPTH05 - 2 lần tiêm
('LT250506509', 'HSPTH05', 'CBNTH021', '2025-05-06', N'Thành công'),
('LT250605342', 'HSPTH05', 'CBNTH021', '2025-06-05', N'Thành công'),

-- Hồ sơ HSPTT47 - 1 lần tiêm
('LT250506046', 'HSPTT47', 'CBNTH021', '2025-05-06', N'Thành công'),

-- Hồ sơ HSPVH13 - 3 lần tiêm
('LT250304198', 'HSPVH13', 'CBNTH021', '2025-03-04', N'Thành công'),
('LT250607023', 'HSPVH13', 'CBNTH021', '2025-06-07', N'Hoãn tiêm'),
('LT250707064', 'HSPVH13', 'CBNTH021', '2025-07-07', N'Thành công'),

-- Hồ sơ HSPVH24 - 2 lần tiêm
('LT250201938', 'HSPVH24', 'CBNTH021', '2025-02-01', N'Thành công'),
('LT250608034', 'HSPVH24', 'CBNTH021', '2025-06-08', N'Thành công'),

-- Hồ sơ HSTHA55 - 1 lần tiêm
('LT250509039', 'HSTHA55', 'CBNTH021', '2025-05-09', N'Thành công'),

-- Hồ sơ HSTMH34 - 2 lần tiêm
('LT250510048', 'HSTMH34', 'CBNTH021', '2025-05-10', N'Thành công'),
('LT250610023', 'HSTMH34', 'CBNTH021', '2025-06-10', N'Thành công'),

-- Hồ sơ HSTMK26 - 1 lần tiêm
('LT250511023', 'HSTMK26', 'CBNTH021', '2025-05-11', N'Thành công'),

-- Hồ sơ HSTMT15 - 3 lần tiêm
('LT250512468', 'HSTMT15', 'CBNTH021', '2025-05-12', N'Thành công'),
('LT250612023', 'HSTMT15', 'CBNTH021', '2025-06-12', N'Xảy ra phản ứng'),
('LT250719053', 'HSTMT15', 'CBNTH021', '2025-07-19', N'Thành công'),

-- Hồ sơ HSTNB38 - 2 lần tiêm
('LT250513046', 'HSTNB38', 'CBNTH021', '2025-05-13', N'Thành công'),
('LT250921042', 'HSTNB38', 'CBNTH021', '2025-09-21', N'Thành công'),

-- Hồ sơ HSTTH45 - 1 lần tiêm
('LT250514231', 'HSTTH45', 'CBNTH021', '2025-05-14', N'Thành công');

INSERT INTO CHI_TIET_LAN_TIEM (Ma_Lan_Tiem, Ma_Vaccine) VALUES
('LT250126070', 'USMEN2410'),
('LT250429038', 'USMEN2410'),
('LT250529013', 'VNPEN2410'),
('LT250122066', 'VNFVR2311'),
('LT250425072', 'VNFVR2311'),
('LT250625016', 'USBVG2412'),
('LT250327010', 'USMRN2310'),
('LT250429077', 'USMRN2310'),
('LT250224059', 'VNPEN2410'),
('LT250525041', 'VNPEN2410'),
('LT250401071', 'USMRN2306'),
('LT250122041', 'JAPJP2312'),
('LT250524029', 'JAPJP2312'),
('LT250422015', 'JPNIP2410'),
('LT250222034', 'USBVG2412'),
('LT250522029', 'USBVG2412'),
('LT250120004', 'CHINA2308'),
('LT250420033', 'CHINA2308'),
('LT250422121', 'FRAFLU2312'),
('LT250124067', 'FRDTP2411'),
('LT250525044', 'FRDTP2411'),
('LT250409007', 'DEZOS2410'),
('LT250210031', 'USHPV2410'),
('LT250510001', 'USHPV2410'),
('LT250411001', 'KORHBP2312'),
('LT250422111', 'INROT2410'),
('LT250522092', 'INROT2410'),
('LT250622073', 'USBVG2412'),
('LT250201011', 'USMRN2306'),
('LT250503033', 'USMRN2306'),
('LT250314101', 'VNBGC2305'),
('LT250220039', 'RUSSP2309'),
('LT250622136', 'RUSSP2309'),
('LT250427341', 'FRAFLU2312'),
('LT250526034', 'FRAFLU2312'),
('LT250626095', 'VNPEN2410'),
('LT250422349', 'USMEN2410'),
('LT250622667', 'USMEN2410'),
('LT250419001', 'VNRVG2413'),
('LT250422231', 'GBADV2307'),
('LT250522339', 'GBADV2307'),
('LT250622463', 'VNFVR2311'),
('LT250423341', 'FRAFLU2312'),
('LT250314361', 'USHPV2410'),
('LT250524056', 'USHPV2410'),
('LT250425501', 'JAPJP2312'),
('LT250426001', 'USMRN2310'),
('LT250526002', 'USMRN2310'),
('LT250626003', 'USBVG2412'),
('LT250427881', 'USBVG2412'),
('LT250527642', 'USBVG2412'),
('LT250130431', 'USMEN2410'),
('LT250530572', 'USMEN2410'),
('LT250501024', 'USMRN2310'),
('LT250301871', 'USMRN2306'),
('LT250602772', 'USMRN2306'),
('LT250702343', 'INROT2410'),
('LT250220231', 'USHPV2410'),
('LT250529092', 'USHPV2410'),
('LT250629403', 'CHINA2308'),
('LT250428451', 'VNRVG2413'),
('LT250129005', 'USBVG2412'),
('LT250429058', 'USBVG2412'),
('LT250503067', 'USMRN2310'),
('LT250603035', 'USMRN2310'),
('LT250504356', 'FRAFLU2312'),
('LT250506509', 'VNPEN2410'),
('LT250605342', 'VNPEN2410'),
('LT250506046', 'CHINA2308'),
('LT250304198', 'USHPV2410'),
('LT250707064', 'USHPV2410'),
('LT250201938', 'GBADV2307'),
('LT250608034', 'GBADV2307'),
('LT250510048', 'DEZOS2410'),
('LT250610023', 'DEZOS2410'),
('LT250511023', 'USMRN2310'),
('LT250512468', 'VNRVG2413'),
('LT250612023', 'VNRVG2413'),
('LT250719053', 'RUSSP2309'),
('LT250513046', 'CHTYP2410'),
('LT250921042', 'CHTYP2410'),
('LT250514231', 'CHINA2308');

INSERT INTO CHI_TIET_LAN_TIEM (Ma_Lan_Tiem, Ma_Vaccine) VALUES
-- Hồ sơ HSVTH17: Tiêm vaccine CHINA2308 (Sinopharm COVID-19) - 2 mũi
('LT250120063', 'FRDTP2411'),  -- Lần tiêm 1
('LT250320102', 'FRDTP2411'),  -- Lần tiêm 2 (Hoãn tiêm)
('LT250522042', 'FRDTP2411'),  -- Lần tiêm 3
('LT250622020', 'FRDTP2411'),  -- Lần tiêm 4

-- Hồ sơ HSNAK31: Tiêm vaccine USMRN2306 (Pfizer-BioNTech COVID-19) - 2 mũi
('LT250420441', 'VNRVG2413'),  -- Lần tiêm 1
('LT250720009', 'VNRVG2413'),
-- Hồ sơ HSNHM37: Tiêm vaccine USMRN2306 (Pfizer-BioNTech COVID-19) - 2 mũi
('LT250421231', 'USMRN2306'),  -- Lần tiêm 1

-- Hồ sơ HSDBH50: Tiêm vaccine VNBGC2305 (BCG) - 1 mũi
('LT250422026', 'VNBGC2305'),  -- Lần tiêm 1

-- Hồ sơ HSDTT07: Tiêm vaccine VNBGC2305 (BCG) - 1 mũi
('LT250424012', 'VNBGC2305'),  -- Lần tiêm 1

-- Hồ sơ HSLQN33: Tiêm vaccine USMRN2306 (Pfizer-BioNTech COVID-19) - 2 mũi
('LT250430009', 'USMRN2306'),  -- Lần tiêm 1

-- Hồ sơ HSTHA55: Tiêm vaccine USMRN2306 (Pfizer-BioNTech COVID-19) - 2 mũi
('LT250509039', 'USMRN2306'),  -- Lần tiêm 1

-- Hồ sơ HSPVH13: Tiêm vaccine USMRN2306 (Pfizer-BioNTech COVID-19) - 2 mũi
('LT250607023', 'USMRN2306');  -- Lần tiêm 1


INSERT INTO PHAN_UNG_SAU_TIEM (Ma_Phan_Ung, Ma_Lan_Tiem, Ten_Phan_Ung, Muc_Do_Phan_Ung, Thoi_Diem_Xay_Ra, Thoi_Diem_Ket_Thuc, Ghi_Chu)
VALUES
    ('PU290425MEN312', 'LT250429038', N'Sốt cao', N'Nặng', '2025-04-29 14:00:00', '2025-04-29 18:30:00', N'Đã nhập viện theo dõi'),
    ('PU220525BVG347', 'LT250522029', N'Nổi mẩn đỏ', N'Trung bình', '2025-05-22 10:15:00', '2025-05-23 08:00:00', N'Dùng thuốc kháng histamin'),
    ('PU220525ROT453', 'LT250522092', N'Sưng tại chỗ tiêm', N'Nhẹ', '2025-05-22 12:30:00', '2025-05-22 20:00:00', N'Chườm lạnh tại chỗ'),
    ('PU260525MRN056', 'LT250526002', N'Đau đầu', N'Trung bình', '2025-05-26 16:00:00', '2025-05-27 09:00:00', N'Dùng thuốc giảm đau'),
    ('PU020625MRN077', 'LT250602772', N'Chóng mặt', N'Nhẹ', '2025-06-02 14:45:00', '2025-06-02 17:30:00', N'Nghỉ ngơi theo dõi'),
    ('PU120625RVG028', 'LT250612023', N'Nôn ói', N'Nặng', '2025-06-12 18:00:00', '2025-06-13 12:00:00', N'Đã truyền dịch và theo dõi'),
    ('PU200725RVG368', 'LT250720009', N'Sốt nhẹ', N'Nhẹ', '2025-07-20 09:30:00', null, N'Nghỉ ngơi theo dõi');

--Nhập data cơ sở
INSERT INTO CO_SO (Ma_Co_So, Ten_Co_So, Dia_Chi, So_Dien_Thoai, Email, Cap_Co_So)
VALUES
    ('CS1HN001', N'Kho dự trữ tổng', N'123 Đường Hoàng Quốc Việt, Cầu Giấy, Hà Nội', '0241234567', 'khotong.hn@gmail.com', '1'),
    
    ('CS2HN007', N'Cơ sở Thanh Xuân', N'45 Nguyễn Trãi, Thanh Xuân, Hà Nội', '0242345678', 'coso.tx@hanoi.gov.vn', '2'),
    ('CS2HN003', N'Cơ sở Hoàn Kiếm', N'20 Hàng Bài, Hoàn Kiếm, Hà Nội', '0243456789', 'coso.hk@hanoi.gov.vn', '2'),
    ('CS2HN009', N'Cơ sở Tây Hồ', N'98 Võ Chí Công, Tây Hồ, Hà Nội', '0244567890', 'coso.th@hanoi.gov.vn', '2'),
    
    ('CS3HN005', N'Trung tâm Y tế Quận Ba Đình', N'12 Đội Cấn, Ba Đình, Hà Nội', '0245678901', 'ttytbd@hanoi.gov.vn', '3'),
    ('CS3HN006', N'Trung tâm Y tế Quận Đống Đa', N'60 Tôn Đức Thắng, Đống Đa, Hà Nội', '0246789012', 'ttytdd@hanoi.gov.vn', '3'),
    ('CS3HN002', N'Trung tâm Y tế Quận Hai Bà Trưng', N'15 Bạch Mai, Hai Bà Trưng, Hà Nội', '0247890123', 'ttythbt@hanoi.gov.vn', '3'),
    ('CS3-HN008', N'Trung tâm Y tế Huyện Gia Lâm', N'234 Nguyễn Đức Thuận, Gia Lâm, Hà Nội', '0248901234', 'ttytgl@hanoi.gov.vn', '3'),

    ('CS2HCM004', N'Cơ sở Quận 1', N'123 Nguyễn Huệ, Quận 1, TP.HCM', '0283123456', 'coso.q1@hcm.gov.vn', '2'),
    ('CS3HCM010', N'Trung tâm Y tế Quận Bình Thạnh', N'88 Đinh Tiên Hoàng, Bình Thạnh, TP.HCM', '0289876543', 'ttytbt@hcm.gov.vn', '3');
Delete CAN_BO_CO_SO;
--Nhập Cán bộ - cơ sở 
INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Kho dự trữ tổng (6 cán bộ)
('CS1HN001', 'CBNTTH868', 'Quản lý kho', '2023-02-01', NULL),
('CS1HN001', 'CBHNN203', 'Phó quản lý kho', '2023-02-20', NULL),
('CS1HN001', 'CBDBP178', 'Nhân viên kho', '2023-03-10', NULL),

('CS1HN001', 'CBHBT092', 'Nhân viên kho', '2023-04-01', null);


INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Cơ sở Quận 1 (6 cán bộ)
('CS2HCM004', 'CBHNN019', 'Bác sĩ', '2023-01-10', NULL),
('CS2HCM004', 'CBLHD013', 'Trưởng khoa', '2023-02-20', NULL),
('CS2HCM004', 'CBLHV017', 'Y tá', '2023-03-05', NULL),
('CS2HCM004', 'CBLLP081', 'Nhân viên y tế', '2023-04-01', NULL),
('CS2HCM004', 'CBLLT259', 'Nhân viên hành chính', '2023-05-15', null),
('CS2HCM004', 'CBNMC026', 'Trưởng khoa', '2023-01-20', '2024-12-15'),

-- Cơ sở Hoàn Kiếm (5 cán bộ)
('CS2HN003', 'CBLHD147', 'Trưởng khoa', '2023-01-05', NULL),
('CS2HN003', 'CBLNT023', 'Bác sĩ', '2023-02-12', NULL),
('CS2HN003', 'CBLTP003', 'Y tá', '2023-03-08', NULL),
('CS2HN003', 'CBMVT029', 'Nhân viên y tế', '2023-04-10', NULL),
('CS2HN003', 'CBNBT018', 'Nhân viên hành chính', '2023-05-20', NULL);
INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Cơ sở Thanh Xuân (4 cán bộ)
('CS2HN007', 'CBNDT030', 'Bác sĩ', '2023-01-15', NULL),
('CS2HN007', 'CBTMA004', 'Trưởng khoa', '2023-02-28', NULL),

('CS2HN007', 'CBNQA011', 'Y tá', '2023-04-05', NULL),
('CS2HN007', 'CBDBH019', 'Nhân viên y tế', '2023-02-15', NULL);
INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Cơ sở Tây Hồ (5 cán bộ)
('CS2HN009', 'CBTTH888', 'Trưởng khoa', '2023-01-18', NULL),
('CS2HN009', 'CBNTH021', 'Bác sĩ', '2023-01-25', NULL),

('CS2HN009', 'CBNTT006', 'Y tá', '2023-03-22', NULL),
('CS2HN009', 'CBNVA001', 'Nhân viên hành chính', '2023-04-15', NULL);

INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Trung tâm Y tế Huyện Gia Lâm (5 cán bộ)
('CS3-HN008', 'CBHBT005', 'Bác sĩ', '2023-01-05', NULL),
('CS3-HN008', 'CBPHT025', 'Y tá', '2023-02-10', NULL),

('CS3-HN008', 'CBPQT022', 'Trưởng khoa', '2023-04-20', NULL),


-- Trung tâm Y tế Quận Bình Thạnh (5 cán bộ)
('CS3HCM010', 'CBPTH002', 'Trưởng khoa', '2023-01-12', NULL),

('CS3HCM010', 'CBPTK016', 'Y tá', '2023-04-15', NULL),
('CS3HCM010', 'CBPVL007', 'Nhân viên hành chính', '2023-05-10', NULL),
('CS3HCM010', 'CBPTH014', 'Bác sĩ', '2023-02-22', '2024-04-15'),
-- Trung tâm Y tế Quận Hai Bà Trưng (4 cán bộ)
('CS3HN002', 'CBTCT009', 'Trưởng khoa', '2023-01-20', NULL),

('CS3HN002', 'CBTNN028', 'Bác sĩ', '2023-04-02', NULL),
('CS3HN002', 'CBTTD015', 'Nhân viên hành chính', '2023-05-12', NULL);
INSERT INTO CAN_BO_CO_SO (Ma_Co_So, Ma_Can_Bo, Chuc_Vu, Ngay_Bat_Dau, Ngay_Ket_Thuc) VALUES
-- Trung tâm Y tế Quận Ba Đình (5 cán bộ)
('CS3HN005', 'CBTTN012', 'Bác sĩ', '2023-01-05', NULL),
('CS3HN005', 'CBTVH024', 'Trưởng khoa', '2023-02-10', NULL),

('CS3HN005', 'CBLHV266', 'Nhân viên hành chính', '2023-04-15', NULL),
('CS3HN005', 'CBDBH010', 'Nhân viên hành chính', '2023-02-22', '2024-04-27'),

-- Trung tâm Y tế Quận Đống Đa (5 cán bộ)
('CS3HN006', 'CBLLP008', 'Trưởng khoa', '2023-01-15', NULL),
('CS3HN006', 'CBLLT027', 'Bác sĩ', '2023-02-25', NULL),


('CS3HN006', 'CBDBP020', 'Y tá', '2023-03-12', '2023-06-15');

--Nhập data cho chi tiết lô

INSERT INTO CHI_TIET_LO_VACCINE (Ma_Lo, Ma_Co_So, So_Lieu_Da_Su_Dung, So_Lieu_Ton_Kho, Ngay_Nhap, Ngay_Xuat)  
VALUES  
('BCG230517', 'CS1HN001', 0, 1335, '2023-05-05', NULL),  
('BCG230528', 'CS1HN001', 0, 1405, '2023-05-10', NULL),  
('BCG250153', 'CS1HN001', 0, 1500, '2025-01-20', NULL),  
('FLU231204', 'CS1HN001', 0, 1675, '2023-12-05', NULL),  
('HBP231210', 'CS1HN001', 0, 1980, '2023-12-05', NULL),  
('HBP231221', 'CS1HN001', 0, 2050, '2023-12-18', NULL),  
('MEN241014', 'CS1HN001', 0, 1648, '2024-10-05', NULL),  
('MEN241025', 'CS1HN001', 0, 1705, '2024-10-20', NULL),  
('PEN241019', 'CS1HN001', 0, 2108, '2024-10-05', NULL),  
('PEN241030', 'CS1HN001', 0, 2200, '2024-10-25', NULL),  
('VER250156', 'CS1HN001', 0, 1850, '2025-01-25', NULL),  
('RAB241320', 'CS1HN001', 0, 1950, '2024-12-05', NULL),  
('ROT241007', 'CS1HN001', 0, 1456, '2024-10-05', NULL); 

INSERT INTO CHI_TIET_LO_VACCINE (Ma_Lo, Ma_Co_So, So_Lieu_Da_Su_Dung, So_Lieu_Ton_Kho, Ngay_Nhap, Ngay_Xuat)  
VALUES  
('CHINA230801', 'CS2HCM004', 123, 1400, '2024-03-01', NULL),  
('CHTYP241001', 'CS2HN003', 150, 1650, '2024-03-02', NULL),  
('DEZOS241001', 'CS2HN007', 150, 1850, '2024-03-03', NULL),  
('FRAFLU231201', 'CS2HN009', 120, 1380, '2024-03-04', NULL),  
('FRDTP241101', 'CS3-HN008', 200, 1900, '2024-03-05', NULL),  
('GBADV230701', 'CS3HCM010', 120, 1480, '2024-03-06', NULL),  
('INROT241001', 'CS3HN002', 150, 1600, '2024-03-07', NULL),  
('JAPJP231201', 'CS3HN005', 100, 1350, '2024-03-08', NULL),  
('JPNIP241001', 'CS3HN006', 150, 1750, '2024-03-09', NULL),  
('KORHBP231201', 'CS2HCM004', 120, 1580, '2024-03-10', NULL),  
('RUSSP230901', 'CS2HN003', 140, 1510, '2024-03-11', NULL),  
('USBVG241201', 'CS2HN007', 180, 1670, '2024-03-12', NULL),  
('USHPV241001', 'CS2HN009', 170, 1780, '2024-03-13', NULL),  
('USMEN241001', 'CS3-HN008', 130, 1420, '2024-03-14', NULL),  
('USMRN230601', 'CS3HCM010', 200, 1900, '2024-03-15', NULL),  
('USMRN231001', 'CS3HN002', 160, 1840, '2024-03-16', NULL),  
('VNBGC230501', 'CS3HN005', 120, 1630, '2024-03-17', NULL),  
('VNFVR231101', 'CS3HN006', 140, 1460, '2024-03-18', NULL),  
('VNPEN241001', 'CS2HCM004', 150, 2050, '2024-03-19', NULL),  
('VNRVG241201', 'CS2HN003', 110, 1390, '2024-03-20', NULL);  

INSERT INTO CHI_TIET_LO_VACCINE (Ma_Lo, Ma_Co_So, So_Lieu_Da_Su_Dung, So_Lieu_Ton_Kho, Ngay_Nhap, Ngay_Xuat)  
VALUES  
('ADV230706', 'CS2HCM004', 50, 1450, '2024-02-01', NULL),  
('BCG240344', 'CS2HN003', 30, 1700, '2024-02-05', NULL),  
('BCG240349', 'CS2HN007', 40, 1600, '2024-02-10', NULL),  
('BCG240356', 'CS2HN009', 25, 1725, '2024-02-12', NULL),  
('BCG240398', 'CS3-HN008', 20, 1680, '2024-02-15', NULL),  
('BCG240399', 'CS3HCM010', 35, 1665, '2024-02-20', NULL),  
('COVID230801', 'CS3HN002', 60, 1440, '2024-02-25', NULL),  
('DTP241105', 'CS3HN005', 45, 1755, '2024-03-01', NULL),  
('HAVB241212', 'CS3HN006', 50, 1800, '2024-03-05', NULL),  
('HAVB241223', 'CS2HCM004', 55, 1745, '2024-03-10', NULL),  
('HAVB250152', 'CS2HN003', 40, 1760, '2024-03-12', NULL),  
('HPV241013', 'CS2HN007', 30, 1920, '2024-03-15', NULL),  
('HPV241024', 'CS2HN009', 35, 1915, '2024-03-18', NULL),  
('HPV250157', 'CS3-HN008', 50, 1900, '2024-03-20', NULL),  
('IMJ241009', 'CS3HCM010', 20, 1480, '2024-03-25', NULL),  
('JEV231208', 'CS3HN002', 60, 1540, '2024-03-28', NULL),  
('MEN250158', 'CS3HN005', 45, 1555, '2024-03-30', NULL),  
('MRN230615', 'CS3HN006', 50, 2050, '2024-04-02', NULL),  
('MRN230626', 'CS2HCM004', 55, 2045, '2024-04-05', NULL),  
('MRN231016', 'CS2HN003', 40, 1960, '2024-04-08', NULL),  
('MRN231027', 'CS2HN007', 30, 1970, '2024-04-10', NULL),  
('MRN250154', 'CS2HN009', 35, 1965, '2024-04-12', NULL),  
('MRN250155', 'CS3-HN008', 50, 1950, '2024-04-15', NULL),  
('PEN250151', 'CS3HCM010', 20, 2180, '2024-04-18', NULL),  
('SPT230911', 'CS3HN002', 60, 1580, '2024-04-20', NULL),  
('SPT230922', 'CS3HN005', 45, 1595, '2024-04-22', NULL),  
('TYP241002', 'CS3HN006', 50, 1850, '2024-04-25', NULL),  
('VER231118', 'CS2HCM004', 55, 1445, '2024-04-28', NULL),  
('VER231129', 'CS2HN003', 40, 1460, '2024-04-30', NULL),  
('ZOS241003', 'CS2HN007', 30, 1970, '2024-05-02', NULL);  


-- Lệnh INSERT dữ liệu vào bảng LICH_HEN (chỉ ngày tháng năm, không giờ phút giây)
INSERT INTO LICH_HEN (Ma_Lich_Hen, Ma_Co_So, Ma_Benh_Nhan, Ngay_Hen, Ngay_Dat_Lich, Ghi_Chu, Tinh_Trang_Lich)
VALUES
('LH050125386', 'CS3-HN008', 'BNHN981001', '2025-01-05', '2024-12-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH050125746', 'CS2HN007', 'BNHN920012', '2025-01-05', '2024-12-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH110125836', 'CS3HN005', 'BNHN010010', '2025-01-11', '2024-12-07', N'Khám Tiêm', N'Đã xác nhận'),
('LH120125777', 'CS3-HN008', 'BNHN990002', '2025-01-12', '2024-11-24', N'Khám Tiêm', N'Đã xác nhận'),
('LH120125550', 'CS2HN007', 'BNHN991234', '2025-01-12', '2024-12-18', N'Khám Tiêm', N'Đã xác nhận'),
('LH130125534', 'CS2HN009', 'BNHN200034', '2025-01-13', '2024-12-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH180125720', 'CS3-HN008', 'BNHN920042', '2025-01-18', '2025-01-06', N'Khám Tiêm', N'Đã xác nhận'),
('LH190125112', 'CS3HN005', 'BNHN990002', '2025-01-19', '2024-11-29', N'Khám Tiêm', N'Đã xác nhận'),

('LH200125853', 'CS2HN007', 'BNHN210035', '2025-01-20', '2024-12-22', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH200125850', 'CS2HN003', 'BNHN980017', '2025-01-20', '2024-12-25', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH220125139', 'CS2HN003', 'BNHN010010', '2025-01-22', '2024-12-08', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH220125170', 'CS2HN009', 'BNHN210039', '2025-01-22', '2025-01-07', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH240125262', 'CS3HN005', 'BNHN180032', '2025-01-24', '2024-12-27', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH250125376', 'CS2HN009', 'BNHN010003', '2025-01-25', '2024-12-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH260125807', 'CS3HN005', 'BNHN000020', '2025-01-26', '2024-12-12', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH290125280', 'CS3HCM010', 'BNHCM000053', '2025-01-29', '2025-01-02', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH300125414', 'CS2HN009', 'BNHN970019', '2025-01-30', '2024-12-07', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH010225208', 'CS2HCM004', 'BNHCM020049', '2025-02-01', '2024-12-17', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH010225141', 'CS3-HN008', 'BNHN970024', '2025-02-01', '2024-12-28', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH100225286', 'CS3HN005', 'BNHN010023', '2025-02-10', '2025-01-21', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH110225268', 'CS2HN003', 'BNHN010010', '2025-02-11', '2025-01-16', N'Khám Tiêm', N'Đã xác nhận'),
('LH140225719', 'CS3HN005', 'BNHN980017', '2025-02-14', '2025-01-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH140225786', 'CS3HN005', 'BNHN020004', '2025-02-14', '2024-12-30', N'Khám Tiêm', N'Đã xác nhận'),
('LH150225572', 'CS3HCM010', 'BNHCM990054', '2025-02-15', '2025-01-08', N'Khám Tiêm', N'Đã xác nhận'),
('LH160225347', 'CS3HN002', 'BNHN970006', '2025-02-16', '2025-01-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH180225492', 'CS3-HN008', 'BNHN920042', '2025-02-18', '2025-01-17', N'Khám Tiêm', N'Đã xác nhận'),
('LH200225302', 'CS2HCM004', 'BNHCM020049', '2025-02-20', '2025-01-08', N'Khám Tiêm', N'Đã xác nhận');

INSERT INTO LICH_HEN (Ma_Lich_Hen, Ma_Co_So, Ma_Benh_Nhan, Ngay_Hen, Ngay_Dat_Lich, Ghi_Chu, Tinh_Trang_Lich)
VALUES
('LH200225895', 'CS3-HN008', 'BNHN990009', '2025-02-20', '2025-01-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH200225172', 'CS2HN007', 'BNHN010003', '2025-02-20', '2025-01-01', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH200225523', 'CS2HN007', 'BNHN970030', '2025-02-20', '2025-01-26', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH220225536', 'CS3HN006', 'BNHN220040', '2025-02-22', '2025-01-22', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH220225617', 'CS2HN007', 'BNHN950041', '2025-02-22', '2024-12-29', N'Khám Tiêm', N'Đã xác nhận'),
('LH220225595', 'CS3HN005', 'BNHN030005', '2025-02-22', '2024-12-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH240225660', 'CS3HN006', 'BNHN020018', '2025-02-24', '2024-12-27', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH280225316', 'CS3HN005', 'BNHN980007', '2025-02-28', '2025-02-10', N'Khám Tiêm', N'Đã xác nhận'),
('LH010325949', 'CS2HCM004', 'BNHCM980046', '2025-03-01', '2025-02-15', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH020325334', 'CS3HN005', 'BNHN980017', '2025-03-02', '2025-02-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH040325180', 'CS2HN007', 'BNHN950013', '2025-03-04', '2025-01-18', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH050325416', 'CS3HN006', 'BNHN020018', '2025-03-05', '2025-02-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH050325655', 'CS3HN002', 'BNHN220040', '2025-03-05', '2025-02-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH070325318', 'CS3HN005', 'BNHN980007', '2025-03-07', '2025-02-11', N'Khám Tiêm', N'Đã xác nhận'),
('LH080325352', 'CS2HN009', 'BNHN970019', '2025-03-08', '2025-02-19', N'Khám Tiêm', N'Đã xác nhận'),
('LH080325313', 'CS2HN007', 'BNHN950043', '2025-03-08', '2025-01-21', N'Khám Tiêm', N'Đã xác nhận'),
('LH100325686', 'CS2HN009', 'BNHN210039', '2025-03-10', '2025-02-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH100325819', 'CS2HN003', 'BNHN020026', '2025-03-10', '2025-02-23', N'Khám Tiêm', N'Đã xác nhận'),
('LH100325659', 'CS3HCM010', 'BNHCM020049', '2025-03-10', '2025-02-02', N'Khám Tiêm', N'Đã xác nhận'),
('LH100325206', 'CS3HN006', 'BNHN000014', '2025-03-10', '2025-01-25', N'Khám Tiêm', N'Đã xác nhận'),
('LH110325599', 'CS3HN005', 'BNHN990021', '2025-03-11', '2025-02-25', N'Khám Tiêm', N'Đã xác nhận'),
('LH110325737', 'CS2HN007', 'BNHN210035', '2025-03-11', '2025-02-19', N'Khám Tiêm', N'Đã xác nhận'),
('LH110325398', 'CS2HN003', 'BNHN970030', '2025-03-11', '2025-01-11', N'Khám Tiêm', N'Đã xác nhận'),
('LH120325429', 'CS3HN006', 'BNHN030027', '2025-03-12', '2025-01-16', N'Khám Tiêm', N'Đã xác nhận'),
('LH120325830', 'CS3-HN008', 'BNHN000044', '2025-03-12', '2025-02-27', N'Khám Tiêm', N'Đã xác nhận'),
('LH120325488', 'CS3HN002', 'BNHN020018', '2025-03-12', '2025-03-04', N'Khám Tiêm', N'Đã xác nhận'),
('LH140325301', 'CS3-HN008', 'BNHN000020', '2025-03-14', '2025-03-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH140325874', 'CS3-HN008', 'BNHN190033', '2025-03-14', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH140325826', 'CS2HN009', 'BNHN990029', '2025-03-14', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH140325486', 'CS3HCM010', 'BNHCM000048', '2025-03-14', '2025-01-18', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH140325416', 'CS3-HN008', 'BNHN030011', '2025-03-14', '2025-02-28', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH150325251', 'CS3HCM010', 'BNHCM990054', '2025-03-15', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH150325469', 'CS2HCM004', 'BNHCM980046', '2025-03-15', '2025-02-11', N'Khám Tiêm', N'Đã xác nhận'),
('LH150325306', 'CS2HN009', 'BNHN980028', '2025-03-15', '2025-02-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH150325562', 'CS3HN006', 'BNHN010015', '2025-03-15', '2025-01-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH150325442', 'CS2HN009', 'BNHN000008', '2025-03-15', '2025-01-19', N'Khám Tiêm', N'Đã xác nhận'),
('LH160325228', 'CS3-HN008', 'BNHN170031', '2025-03-16', '2025-02-17', N'Khám Tiêm', N'Đã xác nhận'),
('LH160325340', 'CS3HN005', 'BNHN190037', '2025-03-16', '2025-02-06', N'Khám Tiêm', N'Đã xác nhận'),
('LH170325375', 'CS2HN009', 'BNHN210039', '2025-03-17', '2025-02-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH170325454', 'CS2HN003', 'BNHN030016', '2025-03-17', '2025-03-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH180325894', 'CS3-HN008', 'BNHN030011', '2025-03-18', '2025-01-26', N'Khám Tiêm', N'Đã xác nhận'),
('LH180325266', 'CS3HN005', 'BNHN990021', '2025-03-18', '2025-02-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH180325205', 'CS3HN005', 'BNHN180032', '2025-03-18', '2025-02-28', N'Khám Tiêm', N'Đã xác nhận'),
('LH190325872', 'CS3HN006', 'BNHN030027', '2025-03-19', '2025-02-21', N'Khám Tiêm', N'Đã xác nhận'),
('LH200325692', 'CS2HN007', 'BNHN210035', '2025-03-20', '2025-01-30', N'Khám Tiêm', N'Đã xác nhận'),
('LH200325279', 'CS3-HN008', 'BNHN030022', '2025-03-20', '2025-02-15', N'Khám Tiêm', N'Đã xác nhận'),
('LH200325320', 'CS2HN003', 'BNHN980017', '2025-03-20', '2025-02-18', N'Lịch tiêm vaccine', N'Đã xác nhận'),
('LH210325595', 'CS3-HN008', 'BNHN000020', '2025-03-21', '2025-01-24', N'Khám Tiêm', N'Đã xác nhận'),
('LH210325608', 'CS3-HN008', 'BNHN010045', '2025-03-21', '2025-03-14', N'Khám Tiêm', N'Đã xác nhận');


INSERT INTO LICH_HEN (Ma_Lich_Hen, Ma_Co_So, Ma_Benh_Nhan, Ngay_Hen, Ngay_Dat_Lich, Ghi_Chu, Tinh_Trang_Lich)
VALUES
('LH210325260', 'CS2HN003', 'BNHN970030', '2025-03-21', '2025-03-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325422', 'CS2HN009', 'BNHN950041', '2025-03-22', '2025-01-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325576', 'CS3HCM010', 'BNHCM000048', '2025-03-22', '2025-03-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325773', 'CS2HN003', 'BNHN180036', '2025-03-22', '2025-02-09', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325210', 'CS3HN002', 'BNHN010023', '2025-03-22', '2025-02-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325627', 'CS3HN006', 'BNHN010015', '2025-03-22', '2025-03-03', N'Khám Tiêm', N'Đã xác nhận'),
('LH220325245', 'CS3HN005', 'BNHN030005', '2025-03-22', '2025-02-01', N'Khám Tiêm', N'Đã xác nhận'),
('LH230325180', 'CS3HN006', 'BNHN190037', '2025-03-23', '2025-03-14', N'Khám Tiêm', N'Đã xác nhận'),
('LH230325393', 'CS2HCM004', 'BNHCM000053', '2025-03-23', '2025-02-22', N'Khám Tiêm', N'Đã xác nhận'),
('LH240325455', 'CS2HN003', 'BNHN030016', '2025-03-24', '2025-03-08', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325883', 'CS3-HN008', 'BNHN030011', '2025-03-25', '2025-01-29', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325198', 'CS3HCM010', 'BNHCM970051', '2025-03-25', '2025-01-25', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325121', 'CS3-HN008', 'BNHN970024', '2025-03-25', '2025-02-05', N'Khám Tiêm', N'Đã xác nhận'),
('LH250325863', 'CS3HN005', 'BNHN180032', '2025-03-25', '2025-03-03', N'Khám Tiêm', N'Đã xác nhận'),
('LH270325277', 'CS3-HN008', 'BNHN990009', '2025-03-27', '2025-03-07', N'Lịch tiêm vaccine', N'Đã gửi mail'),
('LH280325208', 'CS3HN002', 'BNHN000025', '2025-03-28', '2025-03-13', N'Khám Tiêm', N'Đã gửi mail'),
('LH280325818', 'CS3HCM010', 'BNHCM980052', '2025-03-28', '2025-02-01', N'Khám Tiêm', N'Đã gửi mail'),
('LH290325123', 'CS3HN002', 'BNHN200038', '2025-03-29', '2025-02-16', N'Khám Tiêm', N'Đã gửi mail'),
('LH290325339', 'CS3HN005', 'BNHN010023', '2025-03-29', '2025-03-15', N'Khám Tiêm', N'Đã gửi mail'),
('LH300325940', 'CS2HN003', 'BNHN180036', '2025-03-30', '2025-03-15', N'Khám Tiêm', N'Đang chờ'),
('LH300325665', 'CS2HCM004', 'BNHCM010055', '2025-03-30', '2025-02-03', N'Khám Tiêm', N'Đang chờ'),
('LH010425294', 'CS3HCM010', 'BNHCM990054', '2025-04-01', '2025-02-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH010425206', 'CS2HCM004', 'BNHCM980046', '2025-04-01', '2025-02-24', N'Khám Tiêm', N'Đang chờ'),
('LH010425774', 'CS2HN007', 'BNHN950013', '2025-04-01', '2025-02-06', N'Khám Tiêm', N'Đang chờ'),
('LH040425342', 'CS3HN002', 'BNHN000025', '2025-04-04', '2025-03-10', N'Khám Tiêm', N'Đang chờ'),
('LH050425519', 'CS3HN002', 'BNHN220040', '2025-04-05', '2025-03-26', N'Khám Tiêm', N'Đang chờ'),
('LH050425634', 'CS3HCM010', 'BNHCM030050', '2025-04-05', '2025-03-20', N'Khám Tiêm', N'Đang chờ'),
('LH050425502', 'CS3HCM010', 'BNHCM970051', '2025-04-05', '2025-03-11', N'Khám Tiêm', N'Đang chờ'),
('LH080425862', 'CS3HCM010', 'BNHCM980052', '2025-04-08', '2025-02-11', N'Khám Tiêm', N'Đang chờ'),
('LH080425833', 'CS2HCM004', 'BNHCM990047', '2025-04-08', '2025-03-30', N'Khám Tiêm', N'Đang chờ'),
('LH090425370', 'CS3HN005', 'BNHN020004', '2025-04-09', '2025-03-17', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH100425522', 'CS2HCM004', 'BNHCM010055', '2025-04-10', '2025-03-05', N'Khám Tiêm', N'Đang chờ'),
('LH110425108', 'CS2HN007', 'BNHN920012', '2025-04-11', '2025-03-21', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH140425622', 'CS3-HN008', 'BNHN190033', '2025-04-14', '2025-03-11', N'Khám Tiêm', N'Đang chờ'),
('LH150425493', 'CS2HN009', 'BNHN000008', '2025-04-15', '2025-04-05', N'Khám Tiêm', N'Đang chờ'),
('LH150425491', 'CS2HCM004', 'BNHCM980046', '2025-04-15', '2025-03-27', N'Khám Tiêm', N'Đang chờ'),
('LH190425797', 'CS3-HN008', 'BNHN000044', '2025-04-19', '2025-03-27', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH200425494', 'CS2HN007', 'BNHN210035', '2025-04-20', '2025-03-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH200425481', 'CS2HN003', 'BNHN170031', '2025-04-20', '2025-04-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH210425640', 'CS3-HN008', 'BNHN190037', '2025-04-21', '2025-03-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425491', 'CS2HN009', 'BNHN990029', '2025-04-22', '2025-02-27', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425179', 'CS3HCM010', 'BNHCM030050', '2025-04-22', '2025-03-21', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425971', 'CS3-HN008', 'BNHN920042', '2025-04-22', '2025-03-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425594', 'CS2HN003', 'BNHN990021', '2025-04-22', '2025-04-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425458', 'CS3-HN008', 'BNHN950041', '2025-04-22', '2025-03-08', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220425990', 'CS2HN003', 'BNHN000014', '2025-04-22', '2025-03-15', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH230425615', 'CS2HN003', 'BNHN030016', '2025-04-23', '2025-02-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH240425433', 'CS3HN005', 'BNHN980007', '2025-04-24', '2025-03-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250425642', 'CS2HN009', 'BNHN210039', '2025-04-25', '2025-03-15', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250425946', 'CS3HN006', 'BNHN030027', '2025-04-25', '2025-03-25', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH260425188', 'CS3HCM010', 'BNHCM980052', '2025-04-26', '2025-03-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH270425540', 'CS2HN007', 'BNHN000025', '2025-04-27', '2025-03-12', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH270425703', 'CS3-HN008', 'BNHN030022', '2025-04-27', '2025-04-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH280425789', 'CS2HN009', 'BNHN981001', '2025-04-28', '2025-03-27', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290425661', 'CS3HN005', 'BNHN000020', '2025-04-29', '2025-04-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290425336', 'CS3HCM010', 'BNHCM000053', '2025-04-29', '2025-03-13', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290425998', 'CS3-HN008', 'BNHN990009', '2025-04-29', '2025-03-14', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH300425375', 'CS3-HN008', 'BNHN190033', '2025-04-30', '2025-04-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH010525307', 'CS2HN009', 'BNHN000008', '2025-05-01', '2025-04-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH030525665', 'CS2HCM004', 'BNHCM020049', '2025-05-03', '2025-04-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH030525230', 'CS2HN009', 'BNHN200034', '2025-05-03', '2025-03-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH040525563', 'CS2HN007', 'BNHN950043', '2025-05-04', '2025-04-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH060525668', 'CS2HCM004', 'BNHCM990047', '2025-05-06', '2025-03-28', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH060525150', 'CS2HN003', 'BNHN030005', '2025-05-06', '2025-04-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH090525469', 'CS2HCM004', 'BNHCM010055', '2025-05-09', '2025-04-30', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH100525680', 'CS2HN007', 'BNHN010023', '2025-05-10', '2025-03-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH100525176', 'CS2HN007', 'BNHN991234', '2025-05-10', '2025-03-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH110525459', 'CS2HN003', 'BNHN020026', '2025-05-11', '2025-04-15', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH120525139', 'CS2HN009', 'BNHN010015', '2025-05-12', '2025-05-01', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH130525414', 'CS2HN007', 'BNHN200038', '2025-05-13', '2025-03-31', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH140525976', 'CS2HN009', 'BNHN010045', '2025-05-14', '2025-03-20', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220525909', 'CS3HN002', 'BNHN220040', '2025-05-22', '2025-05-12', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220525675', 'CS2HN003', 'BNHN980017', '2025-05-22', '2025-04-08', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220525161', 'CS3-HN008', 'BNHN920042', '2025-05-22', '2025-04-06', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220525754', 'CS2HN007', 'BNHN950041', '2025-05-22', '2025-04-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH240525313', 'CS2HN003', 'BNHN010010', '2025-05-24', '2025-05-08', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH240525682', 'CS3-HN008', 'BNHN030011', '2025-05-24', '2025-05-10', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250525752', 'CS3HN006', 'BNHN020018', '2025-05-25', '2025-04-13', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250525316', 'CS2HN009', 'BNHN180032', '2025-05-25', '2025-04-02', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH260525589', 'CS3HCM010', 'BNHCM980052', '2025-05-26', '2025-04-15', N'Lịch tiêm vaccine', N'Đang chờ');

INSERT INTO LICH_HEN (Ma_Lich_Hen, Ma_Co_So, Ma_Benh_Nhan, Ngay_Hen, Ngay_Dat_Lich, Ghi_Chu, Tinh_Trang_Lich)
VALUES
('LH260525472', 'CS2HN007', 'BNHN000025', '2025-05-26', '2025-03-28', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH270525790', 'CS3-HN008', 'BNHN030022', '2025-05-27', '2025-05-01', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290525529', 'CS3HN005', 'BNHN000020', '2025-05-29', '2025-05-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290525372', 'CS2HN003', 'BNHN970030', '2025-05-29', '2025-05-03', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH300525402', 'CS2HN009', 'BNHN970019', '2025-05-30', '2025-05-16', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH020625600', 'CS2HCM004', 'BNHCM980046', '2025-06-02', '2025-04-20', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH030625876', 'CS2HN009', 'BNHN200034', '2025-06-03', '2025-04-21', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH050625701', 'CS2HN003', 'BNHN030005', '2025-06-05', '2025-05-11', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH070625128', 'CS2HN009', 'BNHN950013', '2025-06-07', '2025-05-29', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH080625347', 'CS3-HN008', 'BNHN970024', '2025-06-08', '2025-04-25', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH100625388', 'CS2HN009', 'BNHN991234', '2025-06-10', '2025-05-26', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH120625631', 'CS2HN003', 'BNHN010015', '2025-06-12', '2025-06-05', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625649', 'CS2HN003', 'BNHN980017', '2025-06-22', '2025-04-28', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625399', 'CS3-HN008', 'BNHN920042', '2025-06-22', '2025-05-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625281', 'CS2HN007', 'BNHN010003', '2025-06-22', '2025-04-23', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625940', 'CS2HN007', 'BNHN950041', '2025-06-22', '2025-06-02', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH220625355', 'CS2HN003', 'BNHN000014', '2025-06-22', '2025-06-09', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH250625573', 'CS2HN009', 'BNHN210039', '2025-06-25', '2025-05-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH260625529', 'CS3HCM010', 'BNHCM980052', '2025-06-26', '2025-06-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH260625757', 'CS3-HN008', 'BNHN000025', '2025-06-26', '2025-05-18', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH290625314', 'CS2HN003', 'BNHN970030', '2025-06-29', '2025-05-19', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH020725850', 'CS3HCM010', 'BNHCM980046', '2025-07-02', '2025-05-07', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH070725744', 'CS2HN009', 'BNHN950013', '2025-07-07', '2025-06-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH190725614', 'CS2HN003', 'BNHN010015', '2025-07-19', '2025-06-22', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH200725596', 'CS2HN003', 'BNHN170031', '2025-07-20', '2025-05-25', N'Lịch tiêm vaccine', N'Đang chờ'),
('LH210925980', 'CS2HN007', 'BNHN200038', '2025-09-21', '2025-08-30', N'Lịch tiêm vaccine', N'Đang chờ');

-- Đảm bảo có dấu chấm phẩy kết thúc câu lệnh trước nếu có
;WITH RankedData AS (
    SELECT 
        LH.[Ma_Lich_Hen],  
        CTLT.[Ma_Vaccine],
        ROW_NUMBER() OVER (PARTITION BY LH.[Ma_Lich_Hen] ORDER BY CTLT.[Ma_Vaccine]) AS rn
    FROM [Udcsdl-19-2].[dbo].[LICH_HEN] LH  
    JOIN [Udcsdl-19-2].[dbo].[HO_SO_TIEM_CHUNG] HSTC  
        ON HSTC.Ma_Benh_Nhan = LH.Ma_Benh_Nhan  
    JOIN [Udcsdl-19-2].[dbo].[LAN_TIEM] LT  
        ON LT.Ma_Ho_So = HSTC.Ma_Ho_So  
    JOIN [Udcsdl-19-2].[dbo].[CHI_TIET_LAN_TIEM] CTLT  
        ON CTLT.Ma_Lan_Tiem = LT.Ma_Lan_Tiem
) 
INSERT INTO CHI_TIET_LICH_HEN (Ma_Lich_Hen, Ma_Vaccine)
SELECT 
    Ma_Lich_Hen,
    Ma_Vaccine
FROM RankedData 
WHERE rn = 1
ORDER BY Ma_Lich_Hen;

