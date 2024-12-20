﻿--Tuan 5--
-------------------------------- QuanLyBanHang --------------------------------------------
USE QuanLyBanHang;
GO
--11. Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).
CREATE TRIGGER trg_ins_hd ON HOADON
FOR INSERT
AS
BEGIN
	DECLARE @NGAYHD SMALLDATETIME, @MAKH CHAR(4), @NGAYDK SMALLDATETIME

	SELECT @NGAYHD=NGHD, @MAKH=MAKH
	FROM INSERTED
	SELECT @NGAYDK=NGDK
	FROM KHACHHANG
	WHERE MAKH=@MAKH
	IF(@NGAYHD<@NGAYDK)
	BEGIN
		PRINT 'LOI: NGAY HOA DON KHONG HOP LE!'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT 'THEM MOI MOT HOA DON THANH CONG'
	END
END
--12. Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.
CREATE TRIGGER trg_ins_hdbai12 ON HOADON
FOR INSERT
AS
BEGIN
	DECLARE @NGAYHD SMALLDATETIME, @MANV CHAR(4), @NGAYVL SMALLDATETIME
	SELECT @NGAYHD=NGHD, @MANV=MANV
	FROM INSERTED
	SELECT @NGAYVL=NGVL 
	FROM NHANVIEN
	WHERE @MANV=MANV
	IF(@NGAYHD<@NGAYVL)
	BEGIN
		PRINT 'LOI: NGAY HOA DON KHONG HOP LE!'
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT 'THEM MOI MOT HOA DON THANH CONG'
	END
END
--13. Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.
CREATE TRIGGER INSERT_HOADON_CAU13 ON HOADON
    FOR UPDATE
    AS
    BEGIN
        DECLARE @sohd INT
        SELECT  @sohd  = SOHD FROM inserted
        UPDATE HOADON
        SET TRIGIA = 0
        WHERE @sohd = SOHD
    END

CREATE TRIGGER UPDATE_CTHD_CAU13 ON CTHD
    FOR UPDATE
    AS
    BEGIN
        DECLARE @sohd INT, @SLC INT, @SLM INT, @GTC MONEY, @GTM MONEY, @MASP CHAR(4), @GIA MONEY

        SELECT @sohd = SOHD, @SLC = SL, @MASP = MASP FROM deleted
        SELECT @SLM = SL FROM  inserted
        SELECT @GIA = GIA FROM SANPHAM WHERE SANPHAM.MASP = @MASP
        SELECT @GTC = @SLC * @GIA
        SELECT @GTM = @SLM * @GIA
        UPDATE HOADON
        SET TRIGIA = TRIGIA - @GTC + @GTM
        WHERE SOHD = @sohd
    END

CREATE OR ALTER TRIGGER INSERT_CTHD_CAU13 ON CTHD
    FOR
    INSERT
    AS
    BEGIN
        DECLARE @SOHD INT, @SL INT, @GIA MONEY, @MASP CHAR(4), @TONGTRIGIA MONEY
        SELECT @SOHD = SOHD, @SL = SL, @MASP = MASP FROM inserted
        SELECT @GIA = GIA FROM SANPHAM WHERE MASP = @MASP
        SELECT @TONGTRIGIA = @GIA * @SL
        UPDATE HOADON
        SET TRIGIA = TRIGIA + @TONGTRIGIA
        WHERE SOHD = @SOHD
    END

CREATE OR ALTER TRIGGER DELETE_CTHD_CAU13 ON CTHD
    FOR
    DELETE
    AS
    BEGIN
        DECLARE @SOHD INT, @SL INT, @GIA MONEY, @MASP CHAR(4), @TONGTRIGIA MONEY
        SELECT @SOHD = SOHD, @SL = SL, @MASP = MASP FROM deleted
        SELECT @GIA = GIA FROM SANPHAM WHERE MASP = @MASP
        SELECT @TONGTRIGIA = @GIA * @SL
        UPDATE HOADON
        SET TRIGIA = TRIGIA - @TONGTRIGIA
        WHERE SOHD = @SOHD
    END

--14. Doanh số của một khách hàng là tổng trị giá các hóa đơn mà khách hàng thành viên đó đã mua
CREATE TRIGGER trg_update_doanhso_khachhang ON KHACHHANG
FOR UPDATE
    AS
BEGIN
    DECLARE @doanhso MONEY
    DECLARE @tongtrigia MONEY
    SELECT @doanhso = DOANHSO FROM INSERTED
    SELECT @tongtrigia = SUM(TRIGIA)
    FROM HOADON,
         INSERTED
    WHERE HOADON.MAKH = INSERTED.MAKH

    IF @doanhso <> @tongtrigia
        BEGIN
            ROLLBACK TRAN
        END
END

----------------------------------- QuanLiHocVu ----------------------------------------------
USE QuanLiHocVu
GO
-- 9. Lớp trưởng của một lớp phải là học viên của lớp đó
CREATE TRIGGER trg_validate_classleader ON LOP
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @trglop CHAR(5)
    DECLARE @malop CHAR(3)
    SELECT @trglop = TRGLOP FROM INSERTED
    SELECT @malop = MALOP FROM INSERTED
    IF @trglop NOT IN (SELECT MAHV FROM HOCVIEN WHERE HOCVIEN.MALOP= @malop)
    BEGIN
        PRINT N'học sinh này không thuộc lớp'
        ROLLBACK TRAN
    END
END;
--10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.
CREATE TRIGGER trg_validate_trgkhoa ON KHOA
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @trgkhoa CHAR(5)
    DECLARE @makhoa CHAR(3)
    DECLARE @hocvi VARCHAR(10)
    SELECT @trgkhoa = TRGKHOA FROM INSERTED
    SELECT @makhoa = MAKHOA FROM INSERTED
    SELECT @hocvi = HOCVI FROM GIAOVIEN WHERE @trgkhoa = MAGV

    IF @hocvi NOT IN ('TS','PTS')
    BEGIN
        PRINT N'Học vị của trường khoa không phù hợp'
        ROLLBACK TRAN
    END
END;
--15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này
CREATE TRIGGER trg_kiem_tra_ngay_thi ON KETQUATHI
FOR UPDATE, INSERT
AS
BEGIN
    DECLARE @mahv CHAR(5)
    DECLARE @malop CHAR(3)
    DECLARE @mamh VARCHAR(10)
    DECLARE @ngaykt DATETIME
    DECLARE @ngaythi DATETIME

    SELECT @mahv = MAHV FROM INSERTED
    SELECT @mamh = MAMH FROM INSERTED
    SELECT @ngaythi =NGTHI FROM INSERTED
    SELECT @malop = MALOP FROM HOCVIEN WHERE @mahv = MAHV
    SELECT @ngaykt = DENNGAY FROM GIANGDAY WHERE @malop = MALOP AND @mamh = MAMH

    IF @ngaykt >= @ngaythi
    BEGIN
        ROLLBACK TRAN
    END
END
--16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn
CREATE TRIGGER trg_test_b16 ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MALOP CHAR(3)
	DECLARE @HOCKY TINYINT
	DECLARE @NAM SMALLINT
	DECLARE @SL TINYINT

	SELECT @MALOP=MALOP FROM inserted
	SELECT @HOCKY=HOCKY FROM inserted
	SELECT @NAM=NAM FROM inserted
	SELECT @SL=COUNT(MAMH) FROM GIANGDAY
	WHERE @MALOP=MALOP
	AND @HOCKY=HOCKY
	AND @NAM=NAM
	IF(@SL>3)
	BEGIN
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		PRINT 'THEM THANH CONG'
	END
END
--17. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó.
CREATE TRIGGER INSERT_LOP_CAU17 ON LOP
FOR INSERT
AS
BEGIN
    DECLARE @MALOP CHAR(3)
    SELECT @MALOP = MALOP FROM inserted
    UPDATE LOP
    SET SISO = 0
    WHERE MALOP = @MALOP
END

CREATE OR ALTER TRIGGER INSERT_HOCVIEN_CAU17 ON HOCVIEN
FOR INSERT
    AS
BEGIN
    DECLARE @MALOP CHAR(3)
    SELECT @MALOP = MALOP FROM INSERTED
    UPDATE LOP
    SET SISO = SISO + 1
    WHERE MALOP = @MALOP
END

CREATE OR ALTER TRIGGER UPDATE_HOCVIEN_CAU17 ON HOCVIEN
FOR UPDATE
AS
BEGIN
    DECLARE @MLM CHAR(3), @MLC CHAR(3)
    SELECT @MLM = MALOP FROM INSERTED
    SELECT @MLC = MALOP FROM DELETED
    UPDATE LOP SET SISO = SISO + 1 WHERE MALOP = @MLM
    UPDATE LOP SET SISO = SISO - 1 WHERE MALOP = @MLC
END

CREATE OR ALTER TRIGGER DELETE_HOCVIEN_CAU17 ON HOCVIEN
FOR DELETE
AS
BEGIN
    DECLARE @MALOP CHAR(3)
    SELECT @MALOP = MALOP FROM DELETED
    UPDATE LOP
    SET SISO = SISO - 1
    WHERE MALOP = @MALOP
END
--18. Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng
--một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và
--(“B”,”A”).
CREATE OR ALTER TRIGGER DIEUKIEN_CAU18 ON DIEUKIEN
FOR INSERT ,UPDATE
AS
BEGIN
    DECLARE @MAMH VARCHAR(10), @MAMH_TRUOC VARCHAR(10)
    SELECT @MAMH = MAMH, @MAMH_TRUOC = MAMH_TRUOC FROM INSERTED
    IF (@MAMH = @MAMH_TRUOC)
    BEGIN
        ROLLBACK TRAN
        PRINT 'MAMH VA MAMHTRUOC KHONG DUOC GIONG NHAU'
    END
    ELSE
    BEGIN
        IF (EXISTS(SELECT * FROM DIEUKIEN WHERE MAMH = @MAMH_TRUOC AND MAMH_TRUOC = @MAMH))
        BEGIN
            ROLLBACK TRAN
            PRINT 'DIEU KIEN KHONG THOA MAN'
        END
    END
END
--19. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau.
CREATE TRIGGER trg_B19 ON GIAOVIEN
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MAGV CHAR(4)
	DECLARE @HOCVI VARCHAR(10)
	DECLARE @HOCHAM VARCHAR(10)
	DECLARE @HESO NUMERIC(4,2)
	DECLARE @MUCLUONG MONEY

	SELECT @MUCLUONG=MUCLUONG FROM inserted
	SELECT @MAGV=MAGV FROM inserted
	SELECT @HOCVI=HOCVI FROM inserted
	SELECT @HOCHAM=HOCHAM FROM inserted
	SELECT @HESO=HESO FROM inserted
	SELECT MAGV=@MAGV FROM GIAOVIEN 
	WHERE HOCVI=@HOCVI
	AND @HOCHAM=HOCHAM
	AND @HESO=HESO
	IF(@MUCLUONG <> (SELECT MUCLUONG FROM GIAOVIEN WHERE MAGV<>@MAGV AND HOCVI=@HOCVI AND HOCHAM=@HOCHAM AND HESO=@HESO))
	BEGIN
		ROLLBACK TRAN
	END
END
--20. Học viên chỉ được thi lại (lần thi >1) khi điểm của lần thi trước đó dưới 5.
CREATE TRIGGER trg_B20 ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @LANTHI TINYINT, @MAHV CHAR(5), @MAMH VARCHAR(10),@DIEMTHILANTRUOC NUMERIC(4,2)
    SELECT @MAHV = MAHV , @MAMH = MAMH, @LANTHI = LANTHI FROM inserted
    IF(@LANTHI > 1)
    BEGIN
        SELECT @DIEMTHILANTRUOC = DIEM
        FROM KETQUATHI
        WHERE MAHV = @MAHV
        AND MAMH = @MAMH
        AND LANTHI = @LANTHI - 1
        IF(@DIEMTHILANTRUOC > 5)
        BEGIN
            PRINT 'KHONG DUOC THI LAI'
            ROLLBACK TRANSACTION
        END
    END
END
--21. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học).
CREATE TRIGGER trg_B21 ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MAHV CHAR(5)
	DECLARE @MAMH VARCHAR(10)
	DECLARE @LANTHI TINYINT
	DECLARE @NGTHISAU SMALLDATETIME
	DECLARE @NGTHITRUOC SMALLDATETIME

	SELECT @MAHV=MAHV FROM inserted
	SELECT @MAMH=MAMH FROM inserted
	SELECT @LANTHI=LANTHI FROM inserted
	SELECT @NGTHISAU=NGTHI FROM inserted
	IF(@LANTHI>1)
	BEGIN
		SELECT @NGTHITRUOC=NGTHI
		FROM KETQUATHI
		WHERE MAHV=@MAHV
		AND MAMH=@MAMH
		AND LANTHI=@LANTHI-1
		IF(@NGTHISAU<=@NGTHITRUOC)
		BEGIN
			ROLLBACK TRAN
		END
	END
END
--22. Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học (sau
--khi học xong những môn học phải học trước mới được học những môn liền sau)
CREATE OR ALTER TRIGGER GIANGDAY_CAU23 ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @MALOP CHAR(3), @MAMH VARCHAR(10), @MAMH_TRUOC VARCHAR(10)
    SELECT @MALOP = MALOP, @MAMH = MAMH FROM INSERTED
    SELECT @MAMH_TRUOC = MAMH_TRUOC FROM DIEUKIEN WHERE MAMH = @MAMH
    IF NOT EXISTS (SELECT 1 FROM GIANGDAY WHERE MAMH = @MAMH_TRUOC
                                        AND MALOP = @MALOP)
    BEGIN
        PRINT 'MON HOC TRUOC CHUA DUOC HOC'
        ROLLBACK TRANSACTION
    END
END
--23. Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.
CREATE TRIGGER trg_B23 ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MAGV CHAR(4)
	DECLARE @MAMH VARCHAR(10)
	DECLARE @MAKHOAMH VARCHAR(4)
	DECLARE @MAKHOAGV VARCHAR(4)
	
	SELECT @MAGV=MAGV FROM inserted
	SELECT @MAMH=MAMH FROM inserted
	SELECT @MAKHOAMH=MAKHOA FROM MONHOC WHERE @MAMH=MAMH
	SELECT @MAKHOAGV=MAKHOA FROM GIAOVIEN WHERE @MAGV=MAGV
	IF(@MAKHOAMH<>@MAKHOAGV)
	BEGIN
		ROLLBACK TRAN
	END
END
