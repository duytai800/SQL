------------------------------------------QUAN LY BAN HANG------------------------------------------
--1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX='Trung Quoc'

--2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE DVT IN('cay', 'quyen')

--3. In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết 
--thúc là “01”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%1'

--4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 
--đến 40.000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX='Trung Quoc' and (gia between 30000 and 40000)

--5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản 
--xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE (NUOCSX='Trung Quoc' or NUOCSX='Thai Lan') and (gia between 30000 and 40000)

--6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD BETWEEN '1/1/2007' AND '2/1/2007'

--7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và 
--trị giá của hóa đơn (giảm dần).
SELECT SOHD, TRIGIA
FROM HOADON
WHERE MONTH(NGHD)=7 AND YEAR(NGHD)=2007
ORDER BY NGHD ASC, TRIGIA DESC

--8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT KH.MAKH, HOTEN 
FROM KHACHHANG KH JOIN HOADON HD ON KH.MAKH=HD.MAKH
WHERE NGHD ='1/1/2007'
 
--9. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 
--28/10/2006.
SET DATEFORMAT DMY
SELECT SOHD, TRIGIA
FROM NHANVIEN NV JOIN HOADON HD ON NV.MANV= HD.MANV
WHERE NGHD='28/10/2006' AND HOTEN='Nguyen Van B'

--10. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” 
--mua trong tháng 10/2006.
SELECT SP.MASP, TENSP
FROM KHACHHANG KH, SANPHAM SP,CTHD, HOADON HD
WHERE KH.MAKH=HD.MAKH AND HD.SOHD=CTHD.SOHD AND CTHD.MASP=SP.MASP AND
		MONTH(NGHD)='10' AND YEAR(NGHD)='2006' AND HOTEN='Nguyen Van A'

--11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT distinct hd.SOHD
FROM HOADON hd, CTHD ct
WHERE hd.SOHD = ct.SOHD AND ct.MASP IN ('BB01','BB02')

--12. Tìm các số óa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm 
--mua với số lượng từ 10 đến 20.
SELECT distinct hd.SOHD
FROM HOADON hd, CTHD ct
WHERE hd.SOHD = ct.SOHD AND ct.MASP IN ('BB01','BB02') AND ct.SL BETWEEN 10 AND 20

--13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản 
--phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB01' AND SL BETWEEN 10 AND 20
INTERSECT
(
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB02' AND SL BETWEEN 10 AND 20
)

--14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản 
--phẩm được bán ra trong ngày 1/1/2007.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX='TRUNG QUOC'
UNION
SELECT SP.MASP, SP.TENSP
FROM HOADON AS HD, SANPHAM AS SP, CTHD AS CT
WHERE HD.NGHD='1/1/2007'
		AND SP.MASP=CT.MASP
		AND HD.SOHD=CT.SOHD

--15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT MASP, TENSP
FROM SANPHAM SP
WHERE SP.MASP NOT IN ( SELECT MASP
						FROM CTHD CT
						WHERE CT.MASP= SP.MASP)

--16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM SP
WHERE SP.MASP NOT IN ( SELECT MASP
						FROM CTHD CT, HOADON HD
						WHERE CT.MASP= SP.MASP AND YEAR(HD.NGHD)='2006'
								AND SP.MASP=CT.MASP
								AND HD.SOHD=CT.SOHD )

--17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán 
--được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM SP
WHERE SP.NUOCSX='Trung Quoc'
	AND SP.MASP NOT IN (   SELECT MASP 
						FROM CTHD CT, HOADON HD
						WHERE CT.MASP=SP.MASP AND  YEAR(HD.NGHD)='2006'
						AND SP.MASP=CT.MASP
						AND HD.SOHD=CT.SOHD )

--18. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT SOHD
FROM HOADON
WHERE
NOT EXISTS
(
    SELECT *
    FROM SANPHAM
    WHERE NUOCSX= 'Singapore' AND MASP NOT IN
    (
        SELECT masp
        FROM CTHD
        WHERE SOHD = HOADON.SOHD and CTHD.MASP = SANPHAM.MASP
    )
)

--19. Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản 
--xuất
SELECT SOHD
FROM HOADON
WHERE YEAR( HOADON.NGHD)='2006' AND
NOT EXISTS
(
    SELECT *
    FROM SANPHAM
    WHERE NUOCSX= 'Singapore' AND MASP NOT IN
    (
        SELECT masp
        FROM CTHD
        WHERE SOHD = HOADON.SOHD and CTHD.MASP = SANPHAM.MASP
    )
)

--20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?SELECT count(SOHD) as SL
FROM HOADON
WHERE MAKH is null

--21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT count(distinct ct.MASP)
FROM HOADON hd, CTHD ct
WHERE YEAR(hd.NGHD) = 2006 and ct.SOHD=hd.SOHD

--22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
 SELECT MAX(TRIGIA) MAXTG, MIN(TRIGIA) MINTG
FROM HOADON;

--23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) 
FROM HOADON
WHERE YEAR(NGHD)='2006'

--24. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA) 'DoanhThu'
FROM HOADON
WHERE YEAR(NGHD)='2006'

--25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT SOHD
FROM HOADON
WHERE YEAR (NGHD)='2006' AND TRIGIA IN (
SELECT max(hd.TRIGIA)
FROM HOADON hd
WHERE YEAR(hd.NGHD) = 2006
)

--26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HOTEN
FROM KHACHHANG KH JOIN HOADON ON KH.MAKH=HOADON.MAKH
WHERE YEAR (NGHD)='2006' AND TRIGIA IN (
SELECT max(hd.TRIGIA)
FROM HOADON hd
WHERE YEAR(hd.NGHD) = 2006
)
--27. In ra danh sách 3 khách hàng đầu tiên (MAKH, HOTEN) sắp xếp theo doanh số giảm 
--dần.
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHDO DESC

--28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao 
--nhất.
SELECT MASP, TENSP
FROM SANPHAM
WHERE GIA IN (	SELECT DISTINCT TOP 3 GIA
				FROM SANPHAM
				ORDER BY GIA DESC)

--29. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 
--trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT SANPHAM.MASP, SANPHAM.TENSP
FROM SANPHAM
WHERE SANPHAM.NUOCSX='Thai Lan' 
AND
SANPHAM.GIA IN
(
SELECT DISTINCT TOP 3 sp.GIA
FROM SANPHAM sp
ORDER BY sp.GIA DESC
)

--30. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 
--trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT SANPHAM.MASP, SANPHAM.TENSP
FROM SANPHAM
WHERE SANPHAM.NUOCSX='Trung Quoc' 
AND
SANPHAM.GIA IN
(
SELECT DISTINCT TOP 3 sp.GIA
FROM SANPHAM sp
WHERE sp.NUOCSX = 'Trung Quoc'
ORDER BY sp.GIA DESC
)

--31. In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC

--32. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(DISTINCT MASP)
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC'

--33. Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX, COUNT(DISTINCT MASP) AS TONGSOSANPHAM
FROM SANPHAM
GROUP BY NUOCSX

--34. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NUOCSX, MAX(GIA) AS MAX, MIN(GIA) AS MIN, AVG(GIA) AS AVG
FROM SANPHAM
GROUP BY NUOCSX

--35. Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD, SUM(TRIGIA) AS DOANHTHU
FROM HOADON
GROUP BY NGHD

--36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT MASP, COUNT(DISTINCT MASP) AS TONGSO
FROM SANPHAM
WHERE MASP IN(SELECT MASP
FROM CTHD C INNER JOIN HOADON H
ON C.SOHD = H.SOHD
WHERE MONTH(NGHD) = 10 AND YEAR(NGHD) = 2006)
GROUP BY MASP

--37. Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD) AS THANG, SUM(TRIGIA) AS DOANHTHU
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)

--38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT *
FROM HOADON
WHERE SOHD IN(SELECT SOHD
FROM CTHD
WHERE SL >= 4)

--39. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT *
FROM HOADON
WHERE SOHD IN(SELECT SOHD
FROM CTHD C INNER JOIN SANPHAM S
ON C.MASP = S.MASP
WHERE NUOCSX = 'VIET NAM' AND SL >= 3)

--40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất. 
SELECT MAKH, HOTEN
FROM KHACHHANG
WHERE MAKH = (SELECT TOP 1 MAKH
FROM HOADON
GROUP BY MAKH
ORDER BY COUNT(DISTINCT SOHD) DESC)

--41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP 1 MONTH(NGHD) AS THANG_DOANHSO_MAX
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC

--42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP = (SELECT TOP 1 MASP
FROM CTHD
GROUP BY MASP
ORDER BY SUM(SL) DESC)

--43. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT sp1.NUOCSX, sp1.MASP, sp1.TENSP
FROM SANPHAM sp1
WHERE sp1.GIA in
(
    SELECT max(sp.GIA)
    FROM SANPHAM sp
    WHERE sp1.NUOCSX = sp.NUOCSX
)

--44. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT sp.NUOCSX
FROM SANPHAM sp
GROUP BY sp.NUOCSX
HAVING count(distinct sp.GIA)>=3

--45. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT hd1.MAKH, DS1.HOTEN
FROM 
(
    SELECT TOP 10 kh1.MAKH, KH1.HOTEN
    FROM KHACHHANG kh1
    WHERE kh1.MAKH is not null
    ORDER BY kh1.DOANHSO DESC
) DS1, HOADON hd1
WHERE DS1.MAKH = hd1.MAKH
GROUP BY hd1.MAKH, DS1.HOTEN
 
HAVING COUNT(HD1.SOHD)>=
ALL(
 
    SELECT count(hd.SOHD)
    FROM 
    (
        SELECT TOP 10 kh.MAKH
        FROM KHACHHANG kh
        WHERE kh.MAKH is not null
        ORDER BY kh.DOANHSO DESC
    ) DS, HOADON hd
    WHERE DS.MAKH = hd.MAKH
    GROUP BY hd.MAKH 
)