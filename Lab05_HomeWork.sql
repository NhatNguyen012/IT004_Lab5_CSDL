----------HomeWork buổi số 5----------
USE Lab1HomeWORK;
GO
-- Tạo bảng Chuyên gia
CREATE TABLE ChuyenGia (
    MaChuyenGia INT PRIMARY KEY,
    HoTen NVARCHAR(100),
    NgaySinh DATE,
    GioiTinh NVARCHAR(10),
    Email NVARCHAR(100),
    SoDienThoai NVARCHAR(20),
    ChuyenNganh NVARCHAR(50),
    NamKinhNghiem INT
);
GO

-- Tạo bảng Công ty
CREATE TABLE CongTy (
    MaCongTy INT PRIMARY KEY,
    TenCongTy NVARCHAR(100),
    DiaChi NVARCHAR(200),
    LinhVuc NVARCHAR(50),
    SoNhanVien INT
);
GO

-- Tạo bảng Dự án
CREATE TABLE DuAn (
    MaDuAn INT PRIMARY KEY,
    TenDuAn NVARCHAR(200),
    MaCongTy INT,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai NVARCHAR(50),
    FOREIGN KEY (MaCongTy) REFERENCES CongTy(MaCongTy)
);
GO

-- Tạo bảng Kỹ năng
CREATE TABLE KyNang (
    MaKyNang INT PRIMARY KEY,
    TenKyNang NVARCHAR(100),
    LoaiKyNang NVARCHAR(50)
);
GO

-- Tạo bảng Chuyên gia - Kỹ năng
CREATE TABLE ChuyenGia_KyNang (
    MaChuyenGia INT,
    MaKyNang INT,
    CapDo INT,
    PRIMARY KEY (MaChuyenGia, MaKyNang),
    FOREIGN KEY (MaChuyenGia) REFERENCES ChuyenGia(MaChuyenGia),
    FOREIGN KEY (MaKyNang) REFERENCES KyNang(MaKyNang)
);
GO

-- Tạo bảng Chuyên gia - Dự án
CREATE TABLE ChuyenGia_DuAn (
    MaChuyenGia INT,
    MaDuAn INT,
    VaiTro NVARCHAR(50),
    NgayThamGia DATE,
    PRIMARY KEY (MaChuyenGia, MaDuAn),
    FOREIGN KEY (MaChuyenGia) REFERENCES ChuyenGia(MaChuyenGia),
    FOREIGN KEY (MaDuAn) REFERENCES DuAn(MaDuAn)
);
GO

-- Chèn dữ liệu mẫu vào bảng Chuyên gia
INSERT INTO ChuyenGia (MaChuyenGia, HoTen, NgaySinh, GioiTinh, Email, SoDienThoai, ChuyenNganh, NamKinhNghiem)
VALUES 
(1, N'Nguyễn Văn An', '1985-05-10', N'Nam', 'nguyenvanan@email.com', '0901234567', N'Phát triển phần mềm', 10),
(2, N'Trần Thị Bình', '1990-08-15', N'Nữ', 'tranthiminh@email.com', '0912345678', N'An ninh mạng', 7),
(3, N'Lê Hoàng Cường', '1988-03-20', N'Nam', 'lehoangcuong@email.com', '0923456789', N'Trí tuệ nhân tạo', 9),
(4, N'Phạm Thị Dung', '1992-11-25', N'Nữ', 'phamthidung@email.com', '0934567890', N'Khoa học dữ liệu', 6),
(5, N'Hoàng Văn Em', '1987-07-30', N'Nam', 'hoangvanem@email.com', '0945678901', N'Điện toán đám mây', 8),
(6, N'Ngô Thị Phượng', '1993-02-14', N'Nữ', 'ngothiphuong@email.com', '0956789012', N'Phân tích dữ liệu', 5),
(7, N'Đặng Văn Giang', '1986-09-05', N'Nam', 'dangvangiang@email.com', '0967890123', N'IoT', 11),
(8, N'Vũ Thị Hương', '1991-12-20', N'Nữ', 'vuthihuong@email.com', '0978901234', N'UX/UI Design', 7),
(9, N'Bùi Văn Inh', '1989-04-15', N'Nam', 'buivaninch@email.com', '0989012345', N'DevOps', 8),
(10, N'Lý Thị Khánh', '1994-06-30', N'Nữ', 'lythikhanh@email.com', '0990123456', N'Blockchain', 4);
GO

-- Chèn dữ liệu mẫu vào bảng Công ty
INSERT INTO CongTy (MaCongTy, TenCongTy, DiaChi, LinhVuc, SoNhanVien)
VALUES 
(1, N'TechViet Solutions', N'123 Đường Lê Lợi, TP.HCM', N'Phát triển phần mềm', 200),
(2, N'DataSmart Analytics', N'456 Đường Nguyễn Huệ, Hà Nội', N'Phân tích dữ liệu', 150),
(3, N'CloudNine Systems', N'789 Đường Trần Hưng Đạo, Đà Nẵng', N'Điện toán đám mây', 100),
(4, N'SecureNet Vietnam', N'101 Đường Võ Văn Tần, TP.HCM', N'An ninh mạng', 80),
(5, N'AI Innovate', N'202 Đường Lý Tự Trọng, Hà Nội', N'Trí tuệ nhân tạo', 120);
GO

-- Chèn dữ liệu mẫu vào bảng Dự án
INSERT INTO DuAn (MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai)
VALUES 
(1, N'Phát triển ứng dụng di động cho ngân hàng', 1, '2023-01-01', '2023-06-30', N'Hoàn thành'),
(2, N'Xây dựng hệ thống phân tích dữ liệu khách hàng', 2, '2023-03-15', '2023-09-15', N'Đang thực hiện'),
(3, N'Triển khai giải pháp đám mây cho doanh nghiệp', 3, '2023-02-01', '2023-08-31', N'Đang thực hiện'),
(4, N'Nâng cấp hệ thống bảo mật cho tập đoàn viễn thông', 4, '2023-04-01', '2023-10-31', N'Đang thực hiện'),
(5, N'Phát triển chatbot AI cho dịch vụ khách hàng', 5, '2023-05-01', '2023-11-30', N'Đang thực hiện');
GO

-- Chèn dữ liệu mẫu vào bảng Kỹ năng
INSERT INTO KyNang (MaKyNang, TenKyNang, LoaiKyNang)
VALUES 
(1, 'Java', N'Ngôn ngữ lập trình'),
(2, 'Python', N'Ngôn ngữ lập trình'),
(3, 'Machine Learning', N'Công nghệ'),
(4, 'AWS', N'Nền tảng đám mây'),
(5, 'Docker', N'Công cụ'),
(6, 'Kubernetes', N'Công cụ'),
(7, 'SQL', N'Cơ sở dữ liệu'),
(8, 'NoSQL', N'Cơ sở dữ liệu'),
(9, 'React', N'Framework'),
(10, 'Angular', N'Framework');
GO

-- Câu hỏi và ví dụ về Triggers (101-110)

-- 101. Tạo một trigger để tự động cập nhật trường NgayCapNhat trong bảng ChuyenGia mỗi khi có sự thay đổi thông tin.
-- Thêm cột NgayCapNhat vào bảng ChuyenGia
ALTER TABLE ChuyenGia ADD NgayCapNhat DATE;

-- Tạo trigger để cập nhật NgayCapNhat
CREATE TRIGGER trg_UpdateNgayCapNhat
ON ChuyenGia
AFTER UPDATE
AS
BEGIN
    UPDATE ChuyenGia
    SET NgayCapNhat = GETDATE()
    FROM inserted
    WHERE ChuyenGia.MaChuyenGia = inserted.MaChuyenGia;
END;

-- 102. Tạo một trigger để ghi log mỗi khi có sự thay đổi trong bảng DuAn.
CREATE TABLE DuAn_Log (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    MaDuAn INT,
    TenDuAn NVARCHAR(200),
    MaCongTy INT,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai NVARCHAR(50),
    NgayThayDoi DATETIME,
    HanhDong NVARCHAR(50)
);
CREATE TRIGGER trg_LogDuAnChanges
ON DuAn
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Ghi log cho các hành động INSERT
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO DuAn_Log(MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai, NgayThayDoi, HanhDong)
        SELECT MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai, GETDATE(), 'INSERT'
        FROM inserted;
    END

    -- Ghi log cho các hành động UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO DuAn_Log (MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai, NgayThayDoi, HanhDong)
        SELECT MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai, GETDATE(), 'UPDATE'
        FROM inserted;
    END

    -- Ghi log cho các hành động DELETE
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO DuAn_Log (MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai, NgayThayDoi, HanhDong)
        SELECT MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai, GETDATE(), 'DELETE'
        FROM deleted;
    END
END;

-- 103. Tạo một trigger để đảm bảo rằng một chuyên gia không thể tham gia vào quá 5 dự án cùng một lúc.
CREATE TRIGGER trg_C103 ON CHUYENGIA_DUAN
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MACHUYENGIA INT
	DECLARE @SLDA INT

	SELECT @MACHUYENGIA=MACHUYENGIA FROM inserted

	SELECT @SLDA=COUNT(*) FROM ChuyenGia_DuAn WHERE @MACHUYENGIA=MaChuyenGia
	IF(@SLDA>5)
	BEGIN
		PRINT 'THEM KHONG THANH CONG'
		ROLLBACK TRAN
	END
END
-- 104. Tạo một trigger để tự động cập nhật số lượng nhân viên trong bảng CongTy mỗi khi có sự thay đổi trong bảng ChuyenGia.
ALTER TABLE ChuyenGia ADD MaCongTy INT;

CREATE TRIGGER trg_UpdateSoNhanVien
ON ChuyenGia
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Cập nhật số lượng nhân viên sau khi chèn bản ghi mới
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        UPDATE CongTy
        SET SoNhanVien = (SELECT COUNT(*) FROM ChuyenGia WHERE MaCongTy = inserted.MaCongTy)
        FROM inserted
        WHERE CongTy.MaCongTy = inserted.MaCongTy;
    END

    -- Cập nhật số lượng nhân viên sau khi xóa bản ghi
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE CongTy
        SET SoNhanVien = (SELECT COUNT(*) FROM ChuyenGia WHERE MaCongTy = deleted.MaCongTy)
        FROM deleted
        WHERE CongTy.MaCongTy = deleted.MaCongTy;
    END
END;
-- 105. Tạo một trigger để ngăn chặn việc xóa các dự án đã hoàn thành.
CREATE TRIGGER trg_C105 ON DUAN
FOR DELETE
AS
BEGIN
	DECLARE @MADUAN INT
	DECLARE @TRANGTHAI NVARCHAR(50)

	SELECT @MADUAN=MADUAN FROM deleted
	SELECT @TRANGTHAI=TRANGTHAI FROM deleted
	IF(@TRANGTHAI=N'Hoàn thành')
	BEGIN
		PRINT'XOA KHONG THANH CONG'
		ROLLBACK TRAN
	END
END

-- 106. Tạo một trigger để tự động cập nhật cấp độ kỹ năng của chuyên gia khi họ tham gia vào một dự án mới.
CREATE TRIGGER trg_UpdateSkillLevel
ON ChuyenGia_DuAn
AFTER INSERT
AS
BEGIN
    DECLARE @MaChuyenGia INT;
    DECLARE @MaDuAn INT;

    -- Lấy mã chuyên gia và mã dự án từ bản ghi vừa được chèn
    SELECT @MaChuyenGia = inserted.MaChuyenGia, @MaDuAn = inserted.MaDuAn
    FROM inserted;

    -- Giả sử mỗi lần tham gia dự án mới, cấp độ kỹ năng của chuyên gia tăng thêm 1
    UPDATE ChuyenGia_KyNang
    SET CapDo = CapDo + 1
    WHERE MaChuyenGia = @MaChuyenGia;
END;

-- 107. Tạo một trigger để ghi log mỗi khi có sự thay đổi cấp độ kỹ năng của chuyên gia.
CREATE TABLE KyNang_Log (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    MaChuyenGia INT,
    MaKyNang INT,
    CapDoCu INT,
    CapDoMoi INT,
    NgayThayDoi DATETIME,
    HanhDong NVARCHAR(50)
);

CREATE TRIGGER trg_LogSkillLevelChanges
ON ChuyenGia_KyNang
AFTER UPDATE
AS
BEGIN
    INSERT INTO KyNang_Log (MaChuyenGia, MaKyNang, CapDoCu, CapDoMoi, NgayThayDoi, HanhDong)
    SELECT 
        deleted.MaChuyenGia, 
        deleted.MaKyNang, 
        deleted.CapDo AS CapDoCu, 
        inserted.CapDo AS CapDoMoi, 
        GETDATE() AS NgayThayDoi, 
        'UPDATE' AS HanhDong
    FROM inserted
    JOIN deleted ON inserted.MaChuyenGia = deleted.MaChuyenGia AND inserted.MaKyNang = deleted.MaKyNang;
END;
-- 108. Tạo một trigger để đảm bảo rằng ngày kết thúc của dự án luôn lớn hơn ngày bắt đầu.
CREATE TRIGGER trg_C108 ON DUAN
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @NGAYBATDAU DATE
	DECLARE @NGAYKETTHUC DATE

	SELECT @NGAYBATDAU=NGAYBATDAU FROM inserted
	SELECT @NGAYKETTHUC=NGAYKETTHUC FROM inserted
	IF(@NGAYBATDAU>=@NGAYKETTHUC)
	BEGIN
		PRINT'NGAY BAT DAU PHAI NHO HON NGAY KET THUC'
		ROLLBACK TRAN
	END
END
-- 109. Tạo một trigger để tự động xóa các bản ghi liên quan trong bảng ChuyenGia_KyNang khi một kỹ năng bị xóa.
CREATE TRIGGER trg_DeleteRelatedChuyenGiaKyNang
ON KyNang
AFTER DELETE
AS
BEGIN
    DELETE FROM ChuyenGia_KyNang
    WHERE MaKyNang IN (SELECT MaKyNang FROM deleted);
END;

-- 110. Tạo một trigger để đảm bảo rằng một công ty không thể có quá 10 dự án đang thực hiện cùng một lúc.
CREATE TRIGGER trg_C110 ON DUAN
FOR INSERT, UPDATE
AS 
BEGIN
	DECLARE @MACONGTY INT
	DECLARE @SLDA INT

	SELECT @MACONGTY=MACONGTY FROM inserted
	SELECT @SLDA=COUNT(MADUAN) FROM inserted WHERE @MACONGTY=MaCongTy AND TrangThai=N'Đang thực hiện'
	IF(@SLDA>10)
	BEGIN
		PRINT'Một công ty không thể có quá 10 dự án đang thực hiện cùng một lúc.'
		ROLLBACK TRAN
	END
END

-- Câu hỏi và ví dụ về Triggers bổ sung (123-135)

-- 123. Tạo một trigger để tự động cập nhật lương của chuyên gia dựa trên cấp độ kỹ năng và số năm kinh nghiệm.
ALTER TABLE ChuyenGia ADD Luong DECIMAL(18, 2);
CREATE TRIGGER trg_UpdateLuong
ON ChuyenGia_KyNang
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaChuyenGia INT;
    DECLARE @CapDo INT;
    DECLARE @NamKinhNghiem INT;
    DECLARE @Luong DECIMAL(18, 2);

    -- Lấy mã chuyên gia và cấp độ kỹ năng từ bản ghi vừa được chèn hoặc cập nhật
    SELECT @MaChuyenGia = inserted.MaChuyenGia, @CapDo = inserted.CapDo
    FROM inserted;

    -- Lấy số năm kinh nghiệm của chuyên gia
    SELECT @NamKinhNghiem = NamKinhNghiem
    FROM ChuyenGia
    WHERE MaChuyenGia = @MaChuyenGia;

    -- Tính toán lương dựa trên cấp độ kỹ năng và số năm kinh nghiệm
    SET @Luong = (@CapDo * 1000) + (@NamKinhNghiem * 500);

    -- Cập nhật lương của chuyên gia
    UPDATE ChuyenGia
    SET Luong = @Luong
    WHERE MaChuyenGia = @MaChuyenGia;
END;
-- 124. Tạo một trigger để tự động gửi thông báo khi một dự án sắp đến hạn (còn 7 ngày).

-- Tạo bảng ThongBao nếu chưa có
CREATE TABLE ThongBao (
    MaThongBao INT IDENTITY(1,1) PRIMARY KEY,
    MaDuAn INT,
    NoiDung NVARCHAR(500),
    NgayThongBao DATETIME
);
CREATE TRIGGER trg_NotifyProjectDeadline
ON DuAn
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaDuAn INT;
    DECLARE @TenDuAn NVARCHAR(200);
    DECLARE @NgayKetThuc DATE;
    DECLARE @NgayThongBao DATETIME;
    DECLARE @NoiDung NVARCHAR(500);

    -- Lấy thông tin dự án từ bản ghi vừa được chèn hoặc cập nhật
    SELECT @MaDuAn = inserted.MaDuAn, @TenDuAn = inserted.TenDuAn, @NgayKetThuc = inserted.NgayKetThuc
    FROM inserted;

    -- Tính toán ngày thông báo (7 ngày trước ngày kết thúc)
    SET @NgayThongBao = DATEADD(DAY, -7, @NgayKetThuc);

    -- Kiểm tra nếu ngày thông báo là ngày hiện tại
    IF @NgayThongBao = CAST(GETDATE() AS DATE)
    BEGIN
        -- Tạo nội dung thông báo
        SET @NoiDung = 'Dự án "' + @TenDuAn + '" sắp đến hạn trong 7 ngày.';

        -- Chèn thông báo vào bảng ThongBao
        INSERT INTO ThongBao (MaDuAn, NoiDung, NgayThongBao)
        VALUES (@MaDuAn, @NoiDung, GETDATE());
    END
END;
-- 125. Tạo một trigger để ngăn chặn việc xóa hoặc cập nhật thông tin của chuyên gia đang tham gia dự án.
CREATE TRIGGER trg_PreventDeleteChuyenGia
ON ChuyenGia
FOR DELETE
AS
BEGIN
    -- Kiểm tra nếu chuyên gia đang tham gia vào bất kỳ dự án nào
    IF EXISTS (SELECT * FROM deleted WHERE MaChuyenGia IN (SELECT MaChuyenGia FROM ChuyenGia_DuAn))
    BEGIN
        -- Nếu có, ngăn chặn việc xóa và thông báo lỗi
        RAISERROR ('Không thể xóa chuyên gia đang tham gia dự án.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
CREATE TRIGGER trg_PreventUpdateChuyenGia
ON ChuyenGia
FOR UPDATE
AS
BEGIN
    -- Kiểm tra nếu chuyên gia đang tham gia vào bất kỳ dự án nào
    IF EXISTS (SELECT * FROM inserted WHERE MaChuyenGia IN (SELECT MaChuyenGia FROM ChuyenGia_DuAn))
    BEGIN
        -- Nếu có, ngăn chặn việc cập nhật và thông báo lỗi
        RAISERROR ('Không thể cập nhật thông tin của chuyên gia đang tham gia dự án.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

-- 126. Tạo một trigger để tự động cập nhật số lượng chuyên gia trong mỗi chuyên ngành.
CREATE TABLE ChuyenNganh_Count (
    ChuyenNganh NVARCHAR(50) PRIMARY KEY,
    SoLuongChuyenGia INT
);
CREATE TRIGGER trg_UpdateChuyenNganhCount
ON ChuyenGia
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Cập nhật số lượng chuyên gia sau khi chèn bản ghi mới
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        MERGE ChuyenNganh_Count AS target
        USING (SELECT ChuyenNganh, COUNT(*) AS SoLuongChuyenGia FROM ChuyenGia GROUP BY ChuyenNganh) AS source
        ON target.ChuyenNganh = source.ChuyenNganh
        WHEN MATCHED THEN
            UPDATE SET target.SoLuongChuyenGia = source.SoLuongChuyenGia
        WHEN NOT MATCHED THEN
            INSERT (ChuyenNganh, SoLuongChuyenGia) VALUES (source.ChuyenNganh, source.SoLuongChuyenGia);
    END

    -- Cập nhật số lượng chuyên gia sau khi xóa bản ghi
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        MERGE ChuyenNganh_Count AS target
        USING (SELECT ChuyenNganh, COUNT(*) AS SoLuongChuyenGia FROM ChuyenGia GROUP BY ChuyenNganh) AS source
        ON target.ChuyenNganh = source.ChuyenNganh
        WHEN MATCHED THEN
            UPDATE SET target.SoLuongChuyenGia = source.SoLuongChuyenGia
        WHEN NOT MATCHED THEN
            INSERT (ChuyenNganh, SoLuongChuyenGia) VALUES (source.ChuyenNganh, source.SoLuongChuyenGia);
    END
END;
-- Tạo bảng ThongKeChuyenNganh nếu chưa có

-- 127. Tạo một trigger để tự động tạo bản sao lưu của dự án khi nó được đánh dấu là hoàn thành.
CREATE TABLE DuAn_Backup (
    MaDuAn INT PRIMARY KEY,
    TenDuAn NVARCHAR(200),
    MaCongTy INT,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai NVARCHAR(50),
    NgaySaoLuu DATETIME
);
-- Tạo bảng DuAnHoanThanh nếu chưa có
CREATE TRIGGER trg_BackupCompletedProjects
ON DuAn
AFTER UPDATE
AS
BEGIN
    -- Chèn bản ghi vào bảng sao lưu khi dự án được đánh dấu là hoàn thành
    INSERT INTO DuAn_Backup (MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai, NgaySaoLuu)
    SELECT 
        inserted.MaDuAn, 
        inserted.TenDuAn, 
        inserted.MaCongTy, 
        inserted.NgayBatDau, 
        inserted.NgayKetThuc, 
        inserted.TrangThai, 
        GETDATE() AS NgaySaoLuu
    FROM inserted
    WHERE inserted.TrangThai = 'Hoàn thành';
END;

-- 128. Tạo một trigger để tự động cập nhật điểm đánh giá trung bình của công ty dựa trên điểm đánh giá của các dự án.
ALTER TABLE DuAn ADD DiemDanhGia DECIMAL(3, 2);
ALTER TABLE CongTy ADD DiemDanhGiaTrungBinh DECIMAL(3, 2);

CREATE TRIGGER trg_UpdateCompanyRating
ON DuAn
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaCongTy INT;

    -- Lấy mã công ty từ bản ghi vừa được chèn hoặc cập nhật
    SELECT @MaCongTy = inserted.MaCongTy
    FROM inserted;

    -- Cập nhật điểm đánh giá trung bình của công ty
    UPDATE CongTy
    SET DiemDanhGiaTrungBinh = (
        SELECT AVG(DiemDanhGia)
        FROM DuAn
        WHERE MaCongTy = @MaCongTy
    )
    WHERE MaCongTy = @MaCongTy;
END;
-- 129. Tạo một trigger để tự động phân công chuyên gia vào dự án dựa trên kỹ năng và kinh nghiệm.
CREATE TABLE PhanCong (
    MaPhanCong INT IDENTITY(1,1) PRIMARY KEY,
    MaChuyenGia INT,
    MaDuAn INT,
    NgayPhanCong DATE
);
CREATE TRIGGER trg_AssignExpertToProject
ON DuAn
AFTER INSERT
AS
BEGIN
    DECLARE @MaDuAn INT;
    DECLARE @MaKyNang INT;
    DECLARE @MaChuyenGia INT;
    -- Lấy mã dự án từ bản ghi vừa được chèn
    SELECT @MaDuAn = inserted.MaDuAn
    FROM inserted;
    -- Giả sử mỗi dự án yêu cầu một kỹ năng cụ thể, lấy mã kỹ năng từ bảng DuAn (bạn có thể điều chỉnh theo yêu cầu thực tế)
    -- SELECT @MaKyNang = MaKyNang FROM DuAn WHERE MaDuAn = @MaDuAn;
    -- Tìm chuyên gia phù hợp nhất dựa trên kỹ năng và kinh nghiệm
    SELECT TOP 1 @MaChuyenGia = ChuyenGia.MaChuyenGia
    FROM ChuyenGia
    JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
    WHERE ChuyenGia_KyNang.MaKyNang = @MaKyNang
    ORDER BY ChuyenGia_KyNang.CapDo DESC, ChuyenGia.NamKinhNghiem DESC;
    -- Phân công chuyên gia vào dự án
    IF @MaChuyenGia IS NOT NULL
    BEGIN
        INSERT INTO PhanCong (MaChuyenGia, MaDuAn, NgayPhanCong)
        VALUES (@MaChuyenGia, @MaDuAn, GETDATE());
    END
END;
-- 130. Tạo một trigger để tự động cập nhật trạng thái "bận" của chuyên gia khi họ được phân công vào dự án mới.
ALTER TABLE ChuyenGia ADD TrangThai NVARCHAR(50);
CREATE TRIGGER trg_UpdateChuyenGiaStatus
ON PhanCong
AFTER INSERT
AS
BEGIN
    DECLARE @MaChuyenGia INT;

    -- Lấy mã chuyên gia từ bản ghi vừa được chèn
    SELECT @MaChuyenGia = inserted.MaChuyenGia
    FROM inserted;

    -- Cập nhật trạng thái của chuyên gia thành "bận"
    UPDATE ChuyenGia
    SET TrangThai = 'Bận'
    WHERE MaChuyenGia = @MaChuyenGia;
END;

-- 131. Tạo một trigger để ngăn chặn việc thêm kỹ năng trùng lặp cho một chuyên gia.
CREATE TRIGGER trg_duplicationSkill ON CHUYENGIA_KYNANG
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (SELECT * FROM inserted WHERE MaKyNang IN (SELECT MaKyNang FROM ChuyenGia_KyNang))
	BEGIN
		PRINT'CHUYEN GIA DA CO KY NANG NAY ROI'
		ROLLBACK TRAN
	END
END

UPDATE ChuyenGia_KyNang
SET MaKyNang=1
WHERE MaChuyenGia=1 AND CAPDO=4

-- 132. Tạo một trigger để tự động tạo báo cáo tổng kết khi một dự án kết thúc.
CREATE TABLE BaoCaoTongKet (
    MaBaoCao INT IDENTITY(1,1) PRIMARY KEY,
    MaDuAn INT,
    TenDuAn NVARCHAR(200),
    MaCongTy INT,
    NgayBatDau DATE,
    NgayKetThuc DATE,
    TrangThai NVARCHAR(50),
    NgayTaoBaoCao DATETIME,
    NoiDung NVARCHAR(MAX)
);
CREATE TRIGGER trg_CreateSummaryReport
ON DuAn
AFTER UPDATE
AS
BEGIN
    DECLARE @MaDuAn INT;
    DECLARE @TenDuAn NVARCHAR(200);
    DECLARE @MaCongTy INT;
    DECLARE @NgayBatDau DATE;
    DECLARE @NgayKetThuc DATE;
    DECLARE @TrangThai NVARCHAR(50);
    DECLARE @NoiDung NVARCHAR(MAX);
    -- Lấy thông tin dự án từ bản ghi vừa được cập nhật
    SELECT @MaDuAn = inserted.MaDuAn, 
           @TenDuAn = inserted.TenDuAn, 
           @MaCongTy = inserted.MaCongTy, 
           @NgayBatDau = inserted.NgayBatDau, 
           @NgayKetThuc = inserted.NgayKetThuc, 
           @TrangThai = inserted.TrangThai
    FROM inserted;
    -- Kiểm tra nếu dự án đã kết thúc
    IF @TrangThai = 'Hoàn thành'
    BEGIN
        -- Tạo nội dung báo cáo tổng kết
        SET @NoiDung = 'Dự án "' + @TenDuAn + '" đã hoàn thành. Thời gian bắt đầu: ' + CONVERT(NVARCHAR, @NgayBatDau) + ', Thời gian kết thúc: ' + CONVERT(NVARCHAR, @NgayKetThuc) + '.';
        -- Chèn báo cáo tổng kết vào bảng BaoCaoTongKet
        INSERT INTO BaoCaoTongKet (MaDuAn, TenDuAn, MaCongTy, NgayBatDau, NgayKetThuc, TrangThai, NgayTaoBaoCao, NoiDung)
        VALUES (@MaDuAn, @TenDuAn, @MaCongTy, @NgayBatDau, @NgayKetThuc, @TrangThai, GETDATE(), @NoiDung);
    END
END;

-- 133. Tạo một trigger để tự động cập nhật thứ hạng của công ty dựa trên số lượng dự án hoàn thành và điểm đánh giá.
ALTER TABLE CongTy ADD ThuHang INT;
CREATE TRIGGER trg_UpdateCompanyRanking
ON DuAn
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaCongTy INT;

    -- Lấy mã công ty từ bản ghi vừa được chèn hoặc cập nhật
    SELECT @MaCongTy = inserted.MaCongTy
    FROM inserted;

    -- Cập nhật thứ hạng của công ty dựa trên số lượng dự án hoàn thành và điểm đánh giá trung bình
    UPDATE CongTy
    SET ThuHang = (
        SELECT RANK() OVER (ORDER BY COUNT(DISTINCT DuAn.MaDuAn) DESC, AVG(DuAn.DiemDanhGia) DESC)
        FROM DuAn
        WHERE DuAn.TrangThai = 'Hoàn thành' AND DuAn.MaCongTy = CongTy.MaCongTy
        GROUP BY DuAn.MaCongTy
    )
    WHERE MaCongTy = @MaCongTy;
END;


-- 133. (tiếp tục) Tạo một trigger để tự động cập nhật thứ hạng của công ty dựa trên số lượng dự án hoàn thành và điểm đánh giá.
CREATE TRIGGER trg_UpdateCompanyRanking
ON DuAn
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaCongTy INT;

    -- Lấy mã công ty từ bản ghi vừa được chèn hoặc cập nhật
    SELECT @MaCongTy = inserted.MaCongTy
    FROM inserted;

    -- Cập nhật thứ hạng của công ty dựa trên số lượng dự án hoàn thành và điểm đánh giá trung bình
    UPDATE CongTy
    SET ThuHang = (
        SELECT RANK() OVER (ORDER BY COUNT(DISTINCT DuAn.MaDuAn) DESC, AVG(DuAn.DiemDanhGia) DESC)
        FROM DuAn
        WHERE DuAn.TrangThai = 'Hoàn thành' AND DuAn.MaCongTy = CongTy.MaCongTy
        GROUP BY DuAn.MaCongTy
    )
    WHERE MaCongTy = @MaCongTy;
END;

-- 134. Tạo một trigger để tự động gửi thông báo khi một chuyên gia được thăng cấp (dựa trên số năm kinh nghiệm).
CREATE TABLE ThongBao (
    MaThongBao INT IDENTITY(1,1) PRIMARY KEY,
    MaChuyenGia INT,
    NoiDung NVARCHAR(500),
    NgayThongBao DATETIME
);
CREATE TRIGGER trg_NotifyPromotion
ON ChuyenGia
AFTER UPDATE
AS
BEGIN
    DECLARE @MaChuyenGia INT;
    DECLARE @HoTen NVARCHAR(100);
    DECLARE @NamKinhNghiem INT;
    DECLARE @NoiDung NVARCHAR(500);

    -- Lấy thông tin chuyên gia từ bản ghi vừa được cập nhật
    SELECT @MaChuyenGia = inserted.MaChuyenGia, 
           @HoTen = inserted.HoTen, 
           @NamKinhNghiem = inserted.NamKinhNghiem
    FROM inserted;

    -- Kiểm tra nếu số năm kinh nghiệm tăng lên và đạt mốc thăng cấp (ví dụ: 5, 10, 15 năm)
    IF @NamKinhNghiem IN (5, 10, 15)
    BEGIN
        -- Tạo nội dung thông báo
        SET @NoiDung = 'Chuyên gia ' + @HoTen + ' đã được thăng cấp với ' + CAST(@NamKinhNghiem AS NVARCHAR) + ' năm kinh nghiệm.';

        -- Chèn thông báo vào bảng ThongBao
        INSERT INTO ThongBao (MaChuyenGia, NoiDung, NgayThongBao)
        VALUES (@MaChuyenGia, @NoiDung, GETDATE());
    END
END;
-- 135. Tạo một trigger để tự động cập nhật trạng thái "khẩn cấp" cho dự án khi thời gian còn lại ít hơn 10% tổng thời gian dự án.
ALTER TABLE DuAn ADD TrangThaiKhan NVARCHAR(50);

CREATE TRIGGER trg_UpdateUrgentStatus
ON DuAn
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaDuAn INT;
    DECLARE @NgayBatDau DATE;
    DECLARE @NgayKetThuc DATE;
    DECLARE @NgayHienTai DATE;
    DECLARE @TongThoiGian INT;
    DECLARE @ThoiGianConLai INT;

    -- Lấy thông tin dự án từ bản ghi vừa được chèn hoặc cập nhật
    SELECT @MaDuAn = inserted.MaDuAn, 
           @NgayBatDau = inserted.NgayBatDau, 
           @NgayKetThuc = inserted.NgayKetThuc
    FROM inserted;

    -- Tính toán tổng thời gian dự án và thời gian còn lại
    SET @NgayHienTai = GETDATE();
    SET @TongThoiGian = DATEDIFF(DAY, @NgayBatDau, @NgayKetThuc);
    SET @ThoiGianConLai = DATEDIFF(DAY, @NgayHienTai, @NgayKetThuc);

    -- Kiểm tra nếu thời gian còn lại ít hơn 10% tổng thời gian dự án
    IF @ThoiGianConLai <= 0.1 * @TongThoiGian
    BEGIN
        -- Cập nhật trạng thái của dự án thành "khẩn cấp"
        UPDATE DuAn
        SET TrangThaiKhan = 'Khẩn cấp'
        WHERE MaDuAn = @MaDuAn;
    END
END;
-- 136. Tạo một trigger để tự động cập nhật số lượng dự án đang thực hiện của mỗi chuyên gia.

ALTER TABLE ChuyenGia ADD SoDuAnDangThucHien INT DEFAULT 0;
CREATE TRIGGER trg_UpdateOngoingProjectsCount
ON ChuyenGia_DuAn
AFTER INSERT, DELETE
AS
BEGIN
    -- Cập nhật số lượng dự án đang thực hiện sau khi chèn bản ghi mới
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        UPDATE ChuyenGia
        SET SoDuAnDangThucHien = (
            SELECT COUNT(*)
            FROM ChuyenGia_DuAn
            WHERE ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
        )
        FROM inserted
        WHERE ChuyenGia.MaChuyenGia = inserted.MaChuyenGia;
    END

    -- Cập nhật số lượng dự án đang thực hiện sau khi xóa bản ghi
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE ChuyenGia
        SET SoDuAnDangThucHien = (
            SELECT COUNT(*)
            FROM ChuyenGia_DuAn
            WHERE ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
        )
        FROM deleted
        WHERE ChuyenGia.MaChuyenGia = deleted.MaChuyenGia;
    END
END;
-- 137. Tạo một trigger để tự động tính toán và cập nhật tỷ lệ thành công của công ty dựa trên số dự án hoàn thành và tổng số dự án.
ALTER TABLE CongTy ADD TyLeThanhCong DECIMAL(5, 2);
CREATE TRIGGER trg_UpdateSuccessRate
ON DuAn
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Cập nhật tỷ lệ thành công của tất cả các công ty
    UPDATE CongTy
    SET TyLeThanhCong = (
        SELECT 
            CASE 
                WHEN COUNT(*) = 0 THEN 0
                ELSE CAST(COUNT(CASE WHEN TrangThai = 'Hoàn thành' THEN 1 END) AS DECIMAL(5, 2)) / COUNT(*) * 100
            END
        FROM DuAn
        WHERE DuAn.MaCongTy = CongTy.MaCongTy
    );
END;
-- 138. Tạo một trigger để tự động ghi log mỗi khi có thay đổi trong bảng lương của chuyên gia.
CREATE TABLE Luong_Log (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    MaChuyenGia INT,
    LuongCu DECIMAL(18, 2),
    LuongMoi DECIMAL(18, 2),
    NgayThayDoi DATETIME,
    HanhDong NVARCHAR(50)
);
CREATE TRIGGER trg_LogSalaryChanges
ON ChuyenGia
AFTER UPDATE
AS
BEGIN
    -- Chỉ ghi log nếu có thay đổi trong cột Luong
    IF UPDATE(Luong)
    BEGIN
        INSERT INTO Luong_Log (MaChuyenGia, LuongCu, LuongMoi, NgayThayDoi, HanhDong)
        SELECT 
            deleted.MaChuyenGia, 
            deleted.Luong AS LuongCu, 
            inserted.Luong AS LuongMoi, 
            GETDATE() AS NgayThayDoi, 
            'UPDATE' AS HanhDong
        FROM inserted
        JOIN deleted ON inserted.MaChuyenGia = deleted.MaChuyenGia;
    END
END;
-- 139. Tạo một trigger để tự động cập nhật số lượng chuyên gia cấp cao trong mỗi công ty.
ALTER TABLE CongTy ADD SoLuongChuyenGiaCapCao INT DEFAULT 0;

CREATE TRIGGER trg_UpdateSeniorExpertCount
ON ChuyenGia
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Cập nhật số lượng chuyên gia cấp cao sau khi chèn hoặc cập nhật bản ghi
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        UPDATE CongTy
        SET SoLuongChuyenGiaCapCao = (
            SELECT COUNT(*)
            FROM ChuyenGia
            WHERE ChuyenGia.MaCongTy = CongTy.MaCongTy AND ChuyenGia.NamKinhNghiem >= 10
        )
        FROM inserted
        WHERE CongTy.MaCongTy = inserted.MaCongTy;
    END

    -- Cập nhật số lượng chuyên gia cấp cao sau khi xóa bản ghi
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE CongTy
        SET SoLuongChuyenGiaCapCao = (
            SELECT COUNT(*)
            FROM ChuyenGia
            WHERE ChuyenGia.MaCongTy = CongTy.MaCongTy AND ChuyenGia.NamKinhNghiem >= 10
        )
        FROM deleted
        WHERE CongTy.MaCongTy = deleted.MaCongTy;
    END
END;

-- 140. Tạo một trigger để tự động cập nhật trạng thái "cần bổ sung nhân lực" cho dự án khi số lượng chuyên gia tham gia ít hơn yêu cầu.
ALTER TABLE DuAn ADD SoLuongChuyenGiaYeuCau INT;
ALTER TABLE DuAn ADD TrangThaicn NVARCHAR(50);
CREATE TRIGGER trg_UpdateProjectStatus
ON ChuyenGia_DuAn
AFTER INSERT, DELETE
AS
BEGIN
    DECLARE @MaDuAn INT;
    DECLARE @SoLuongChuyenGiaThamGia INT;
    DECLARE @SoLuongChuyenGiaYeuCau INT;
    -- Cập nhật trạng thái sau khi chèn bản ghi mới
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SELECT @MaDuAn = inserted.MaDuAn
        FROM inserted;
        -- Lấy số lượng chuyên gia tham gia và yêu cầu của dự án
        SELECT @SoLuongChuyenGiaThamGia = COUNT(*)
        FROM ChuyenGia_DuAn
        WHERE MaDuAn = @MaDuAn;
        SELECT @SoLuongChuyenGiaYeuCau = SoLuongChuyenGiaYeuCau
        FROM DuAn
        WHERE MaDuAn = @MaDuAn;
        -- Cập nhật trạng thái của dự án
        IF @SoLuongChuyenGiaThamGia < @SoLuongChuyenGiaYeuCau
        BEGIN
            UPDATE DuAn
            SET TrangThai = 'Cần bổ sung nhân lực'
            WHERE MaDuAn = @MaDuAn;
        END
        ELSE
        BEGIN
            UPDATE DuAn
            SET TrangThai = 'Đủ nhân lực'
            WHERE MaDuAn = @MaDuAn;
        END
    END
    -- Cập nhật trạng thái sau khi xóa bản ghi
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        SELECT @MaDuAn = deleted.MaDuAn
        FROM deleted;
        -- Lấy số lượng chuyên gia tham gia và yêu cầu của dự án
        SELECT @SoLuongChuyenGiaThamGia = COUNT(*)
        FROM ChuyenGia_DuAn
        WHERE MaDuAn = @MaDuAn;
        SELECT @SoLuongChuyenGiaYeuCau = SoLuongChuyenGiaYeuCau
        FROM DuAn
        WHERE MaDuAn = @MaDuAn;
        -- Cập nhật trạng thái của dự án
        IF @SoLuongChuyenGiaThamGia < @SoLuongChuyenGiaYeuCau
        BEGIN
            UPDATE DuAn
            SET TrangThai = 'Cần bổ sung nhân lực'
            WHERE MaDuAn = @MaDuAn;
        END
        ELSE
        BEGIN
            UPDATE DuAn
            SET TrangThai = 'Đủ nhân lực'
            WHERE MaDuAn = @MaDuAn;
        END
    END
END;