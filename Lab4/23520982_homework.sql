USE CongTy
GO

-- 76. Liệt kê top 3 chuyên gia có nhiều kỹ năng nhất và số lượng kỹ năng của họ.
SELECT TOP 3 ChuyenGia.HoTen, COUNT(ChuyenGia_KyNang.MaKyNang) AS SoLuongKyNang
FROM ChuyenGia
JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
GROUP BY ChuyenGia.HoTen
ORDER BY SoLuongKyNang DESC;


-- 77. Tìm các cặp chuyên gia có cùng chuyên ngành và số năm kinh nghiệm chênh lệch không quá 2 năm.

SELECT c1.HoTen AS ChuyenGia1, c2.HoTen AS ChuyenGia2, c1.ChuyenNganh, ABS(c1.NamKinhNghiem - c2.NamKinhNghiem) AS ChenhLechNamKN
FROM ChuyenGia c1
JOIN ChuyenGia c2 ON c1.ChuyenNganh = c2.ChuyenNganh AND c1.MaChuyenGia < c2.MaChuyenGia
WHERE ABS(c1.NamKinhNghiem - c2.NamKinhNghiem) <= 2;

-- 78. Hiển thị tên công ty, số lượng dự án và tổng số năm kinh nghiệm của các chuyên gia tham gia dự án của công ty đó.
SELECT CongTy.TenCongTy, COUNT(DISTINCT DuAn.MaDuAn) AS SoLuongDuAn, SUM(ChuyenGia.NamKinhNghiem) AS TongNamKinhNghiem
FROM CongTy
JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
JOIN ChuyenGia_DuAn ON DuAn.MaDuAn = ChuyenGia_DuAn.MaDuAn
JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
GROUP BY CongTy.TenCongTy;


-- 79. Tìm các chuyên gia có ít nhất một kỹ năng cấp độ 5 nhưng không có kỹ năng nào dưới cấp độ 3.

SELECT DISTINCT ChuyenGia.HoTen
FROM ChuyenGia
JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
WHERE ChuyenGia_KyNang.CapDo = 5
AND ChuyenGia.MaChuyenGia NOT IN (
    SELECT MaChuyenGia
    FROM ChuyenGia_KyNang
    WHERE CapDo < 3
);


-- 80. Liệt kê các chuyên gia và số lượng dự án họ tham gia, bao gồm cả những chuyên gia không tham gia dự án nào.

SELECT ChuyenGia.HoTen, COUNT(ChuyenGia_DuAn.MaDuAn) AS SoLuongDuAn
FROM ChuyenGia
LEFT JOIN ChuyenGia_DuAn ON ChuyenGia.MaChuyenGia = ChuyenGia_DuAn.MaChuyenGia
GROUP BY ChuyenGia.HoTen;


-- 81*. Tìm chuyên gia có kỹ năng ở cấp độ cao nhất trong mỗi loại kỹ năng.

WITH MaxCapDoKyNang AS (
    SELECT MaKyNang, MAX(CapDo) AS CapDoCaoNhat
    FROM ChuyenGia_KyNang
    GROUP BY MaKyNang
)
SELECT KyNang.TenKyNang, ChuyenGia.HoTen, ChuyenGia_KyNang.CapDo
FROM ChuyenGia
JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
JOIN MaxCapDoKyNang ON ChuyenGia_KyNang.MaKyNang = MaxCapDoKyNang.MaKyNang
AND ChuyenGia_KyNang.CapDo = MaxCapDoKyNang.CapDoCaoNhat;



-- 82. Tính tỷ lệ phần trăm của mỗi chuyên ngành trong tổng số chuyên gia.

SELECT ChuyenNganh, (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ChuyenGia)) AS TiLePhanTram
FROM ChuyenGia
GROUP BY ChuyenNganh;


-- 83. Tìm các cặp kỹ năng thường xuất hiện cùng nhau nhất trong hồ sơ của các chuyên gia.

SELECT k1.TenKyNang AS KyNang1, k2.TenKyNang AS KyNang2, COUNT(*) AS SoLanCungXuatHien
FROM ChuyenGia_KyNang ck1
JOIN ChuyenGia_KyNang ck2 ON ck1.MaChuyenGia = ck2.MaChuyenGia AND ck1.MaKyNang < ck2.MaKyNang
JOIN KyNang k1 ON ck1.MaKyNang = k1.MaKyNang
JOIN KyNang k2 ON ck2.MaKyNang = k2.MaKyNang
GROUP BY k1.TenKyNang, k2.TenKyNang
ORDER BY SoLanCungXuatHien DESC;


-- 84. Tính số ngày trung bình giữa ngày bắt đầu và ngày kết thúc của các dự án cho mỗi công ty.

SELECT CongTy.TenCongTy, AVG(DATEDIFF(day, DuAn.NgayBatDau, DuAn.NgayKetThuc)) AS SoNgayTrungBinh
FROM CongTy
JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
GROUP BY CongTy.TenCongTy;


-- 85*. Tìm chuyên gia có sự kết hợp độc đáo nhất của các kỹ năng (kỹ năng mà chỉ họ có).

SELECT ChuyenGia.HoTen
FROM ChuyenGia
JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
GROUP BY ChuyenGia.MaChuyenGia, ChuyenGia.HoTen
HAVING COUNT(DISTINCT ChuyenGia_KyNang.MaKyNang) = 1;


-- 86*. Tạo một bảng xếp hạng các chuyên gia dựa trên số lượng dự án và tổng cấp độ kỹ năng.

SELECT ChuyenGia.HoTen, COUNT(ChuyenGia_DuAn.MaDuAn) AS SoLuongDuAn, SUM(ChuyenGia_KyNang.CapDo) AS TongCapDoKyNang,
       RANK() OVER (ORDER BY COUNT(ChuyenGia_DuAn.MaDuAn) DESC, SUM(ChuyenGia_KyNang.CapDo) DESC) AS XepHang
FROM ChuyenGia
LEFT JOIN ChuyenGia_DuAn ON ChuyenGia.MaChuyenGia = ChuyenGia_DuAn.MaChuyenGia
LEFT JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
GROUP BY ChuyenGia.HoTen;


-- 87. Tìm các dự án có sự tham gia của chuyên gia từ tất cả các chuyên ngành.

SELECT DuAn.TenDuAn
FROM DuAn
JOIN ChuyenGia_DuAn ON DuAn.MaDuAn = ChuyenGia_DuAn.MaDuAn
JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
GROUP BY DuAn.TenDuAn
HAVING COUNT(DISTINCT ChuyenGia.ChuyenNganh) = (SELECT COUNT(DISTINCT ChuyenNganh) FROM ChuyenGia);


-- 88. Tính tỷ lệ thành công của mỗi công ty dựa trên số dự án hoàn thành so với tổng số dự án.

SELECT CongTy.TenCongTy,
       (SUM(CASE WHEN DuAn.TrangThai = N'Hoàn thành' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS TiLeThanhCong
FROM CongTy
JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
GROUP BY CongTy.TenCongTy;


-- 89. Tìm các chuyên gia có kỹ năng "bù trừ" nhau (một người giỏi kỹ năng A nhưng yếu kỹ năng B, người kia ngược lại).

SELECT c1.HoTen AS ChuyenGia1, c2.HoTen AS ChuyenGia2, k1.TenKyNang AS KyNangA, k2.TenKyNang AS KyNangB
FROM ChuyenGia c1
JOIN ChuyenGia c2 ON c1.MaChuyenGia < c2.MaChuyenGia
JOIN ChuyenGia_KyNang ck1 ON c1.MaChuyenGia = ck1.MaChuyenGia
JOIN ChuyenGia_KyNang ck2 ON c2.MaChuyenGia = ck2.MaChuyenGia
JOIN KyNang k1 ON ck1.MaKyNang = k1.MaKyNang
JOIN KyNang k2 ON ck2.MaKyNang = k2.MaKyNang
WHERE ck1.CapDo >= 4 AND ck2.CapDo <= 2
   AND ck2.CapDo >= 4 AND ck1.CapDo <= 2
   AND ck1.MaKyNang = ck2.MaKyNang
   AND k1.MaKyNang <> k2.MaKyNang;

