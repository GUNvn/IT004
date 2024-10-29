USE CongTy;
-- 8. Hiển thị tên và cấp độ của tất cả các kỹ năng của chuyên gia có MaChuyenGia là 1.

SELECT KyNang.TenKyNang, ChuyenGia_KyNang.CapDo
FROM ChuyenGia_KyNang
JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
WHERE ChuyenGia_KyNang.MaChuyenGia = 1;


-- 9. Liệt kê tên các chuyên gia tham gia dự án có MaDuAn là 2.

SELECT ChuyenGia.HoTen
FROM ChuyenGia
JOIN ChuyenGia_DuAn ON ChuyenGia.MaChuyenGia = ChuyenGia_DuAn.MaChuyenGia
WHERE ChuyenGia_DuAn.MaDuAn = 2;


-- 10. Hiển thị tên công ty và tên dự án của tất cả các dự án.

SELECT CongTy.TenCongTy, DuAn.TenDuAn
FROM DuAn
JOIN CongTy ON DuAn.MaCongTy = CongTy.MaCongTy;


-- 11. Đếm số lượng chuyên gia trong mỗi chuyên ngành.

SELECT ChuyenNganh, COUNT(*) AS SoLuongChuyenGia
FROM ChuyenGia
GROUP BY ChuyenNganh;


-- 12. Tìm chuyên gia có số năm kinh nghiệm cao nhất.

SELECT TOP 1 HoTen, NamKinhNghiem
FROM ChuyenGia
ORDER BY NamKinhNghiem DESC;


-- 13. Liệt kê tên các chuyên gia và số lượng dự án họ tham gia.

SELECT ChuyenGia.HoTen, COUNT(ChuyenGia_DuAn.MaDuAn) AS SoLuongDuAn
FROM ChuyenGia
LEFT JOIN ChuyenGia_DuAn ON ChuyenGia.MaChuyenGia = ChuyenGia_DuAn.MaChuyenGia
GROUP BY ChuyenGia.HoTen;


-- 14. Hiển thị tên công ty và số lượng dự án của mỗi công ty.

SELECT CongTy.TenCongTy, COUNT(DuAn.MaDuAn) AS SoLuongDuAn
FROM CongTy
LEFT JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
GROUP BY CongTy.TenCongTy;


-- 15. Tìm kỹ năng được sở hữu bởi nhiều chuyên gia nhất.

SELECT TOP 1 KyNang.TenKyNang, COUNT(ChuyenGia_KyNang.MaChuyenGia) AS SoLuongChuyenGia
FROM KyNang
JOIN ChuyenGia_KyNang ON KyNang.MaKyNang = ChuyenGia_KyNang.MaKyNang
GROUP BY KyNang.TenKyNang
ORDER BY SoLuongChuyenGia DESC;



-- 16. Liệt kê tên các chuyên gia có kỹ năng 'Python' với cấp độ từ 4 trở lên.

SELECT ChuyenGia.HoTen
FROM ChuyenGia
JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
JOIN KyNang ON ChuyenGia_KyNang.MaKyNang = KyNang.MaKyNang
WHERE KyNang.TenKyNang = 'Python' AND ChuyenGia_KyNang.CapDo >= 4;


-- 17. Tìm dự án có nhiều chuyên gia tham gia nhất.

SELECT TOP 1 DuAn.TenDuAn, COUNT(ChuyenGia_DuAn.MaChuyenGia) AS SoLuongChuyenGia
FROM DuAn
JOIN ChuyenGia_DuAn ON DuAn.MaDuAn = ChuyenGia_DuAn.MaDuAn
GROUP BY DuAn.TenDuAn
ORDER BY SoLuongChuyenGia DESC;



-- 18. Hiển thị tên và số lượng kỹ năng của mỗi chuyên gia.

SELECT ChuyenGia.HoTen, COUNT(ChuyenGia_KyNang.MaKyNang) AS SoLuongKyNang
FROM ChuyenGia
LEFT JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
GROUP BY ChuyenGia.HoTen;


-- 19. Tìm các cặp chuyên gia làm việc cùng dự án.

SELECT A.HoTen AS ChuyenGia1, B.HoTen AS ChuyenGia2, DuAn.TenDuAn
FROM ChuyenGia A
JOIN ChuyenGia_DuAn CA ON A.MaChuyenGia = CA.MaChuyenGia
JOIN ChuyenGia B ON A.MaChuyenGia < B.MaChuyenGia
JOIN ChuyenGia_DuAn CB ON B.MaChuyenGia = CB.MaChuyenGia AND CA.MaDuAn = CB.MaDuAn
JOIN DuAn ON CA.MaDuAn = DuAn.MaDuAn;


-- 20. Liệt kê tên các chuyên gia và số lượng kỹ năng cấp độ 5 của họ.

SELECT ChuyenGia.HoTen, COUNT(*) AS SoLuongKyNangCap5
FROM ChuyenGia
JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
WHERE ChuyenGia_KyNang.CapDo = 5
GROUP BY ChuyenGia.HoTen;


-- 21. Tìm các công ty không có dự án nào.

SELECT TenCongTy
FROM CongTy
LEFT JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
WHERE DuAn.MaDuAn IS NULL;


-- 22. Hiển thị tên chuyên gia và tên dự án họ tham gia, bao gồm cả chuyên gia không tham gia dự án nào.

SELECT ChuyenGia.HoTen, DuAn.TenDuAn
FROM ChuyenGia
LEFT JOIN ChuyenGia_DuAn ON ChuyenGia.MaChuyenGia = ChuyenGia_DuAn.MaChuyenGia
LEFT JOIN DuAn ON ChuyenGia_DuAn.MaDuAn = DuAn.MaDuAn;



-- 23. Tìm các chuyên gia có ít nhất 3 kỹ năng.

SELECT HoTen
FROM ChuyenGia
JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
GROUP BY HoTen
HAVING COUNT(MaKyNang) >= 3;


-- 24. Hiển thị tên công ty và tổng số năm kinh nghiệm của tất cả chuyên gia trong các dự án của công ty đó.

SELECT CongTy.TenCongTy, SUM(ChuyenGia.NamKinhNghiem) AS TongNamKinhNghiem
FROM CongTy
JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
JOIN ChuyenGia_DuAn ON DuAn.MaDuAn = ChuyenGia_DuAn.MaDuAn
JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
GROUP BY CongTy.TenCongTy;


-- 25. Tìm các chuyên gia có kỹ năng 'Java' nhưng không có kỹ năng 'Python'.

SELECT ChuyenGia.HoTen
FROM ChuyenGia
JOIN ChuyenGia_KyNang K1 ON ChuyenGia.MaChuyenGia = K1.MaChuyenGia
JOIN KyNang KN1 ON K1.MaKyNang = KN1.MaKyNang AND KN1.TenKyNang = 'Java'
WHERE NOT EXISTS (
    SELECT 1
    FROM ChuyenGia_KyNang K2
    JOIN KyNang KN2 ON K2.MaKyNang = KN2.MaKyNang AND KN2.TenKyNang = 'Python'
    WHERE K2.MaChuyenGia = ChuyenGia.MaChuyenGia
);


-- 76. Tìm chuyên gia có số lượng kỹ năng nhiều nhất.
SELECT TOP 1 ChuyenGia.HoTen, COUNT(ChuyenGia_KyNang.MaKyNang) AS SoLuongKyNang
FROM ChuyenGia
JOIN ChuyenGia_KyNang ON ChuyenGia.MaChuyenGia = ChuyenGia_KyNang.MaChuyenGia
GROUP BY ChuyenGia.HoTen
ORDER BY SoLuongKyNang DESC;


-- 77. Liệt kê các cặp chuyên gia có cùng chuyên ngành.

SELECT A.HoTen AS ChuyenGia1, B.HoTen AS ChuyenGia2, A.ChuyenNganh
FROM ChuyenGia A
JOIN ChuyenGia B ON A.MaChuyenGia < B.MaChuyenGia AND A.ChuyenNganh = B.ChuyenNganh;


-- 78. Tìm công ty có tổng số năm kinh nghiệm của các chuyên gia trong dự án cao nhất.

SELECT TOP 1 CongTy.TenCongTy, SUM(ChuyenGia.NamKinhNghiem) AS TongNamKinhNghiem
FROM CongTy
JOIN DuAn ON CongTy.MaCongTy = DuAn.MaCongTy
JOIN ChuyenGia_DuAn ON DuAn.MaDuAn = ChuyenGia_DuAn.MaDuAn
JOIN ChuyenGia ON ChuyenGia_DuAn.MaChuyenGia = ChuyenGia.MaChuyenGia
GROUP BY CongTy.TenCongTy
ORDER BY TongNamKinhNghiem DESC;


-- 79. Tìm kỹ năng được sở hữu bởi tất cả các chuyên gia.

SELECT TenKyNang
FROM KyNang
JOIN ChuyenGia_KyNang ON KyNang.MaKyNang = ChuyenGia_KyNang.MaKyNang
GROUP BY TenKyNang
HAVING COUNT(DISTINCT ChuyenGia_KyNang.MaChuyenGia) = (SELECT COUNT(*) FROM ChuyenGia);
