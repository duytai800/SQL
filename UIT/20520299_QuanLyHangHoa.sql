------------------------------------------QUAN LY HANG HOA------------------------------------------
--1. Hiển thị thông tin (maNCC, tenNCC, thanhpho) của tất cả nhà cung cấp.
SELECT maNCC, tenNCC, thanhpho
FROM Nhacungcap

--2. Hiển thị thông tin của tất cả các phụ tùng.
SELECT maPT, tenPT, mausac, khoiluong, thanhpho
FROM Phutung

--3. Hiển thị thông tin các nhà cung cấp ở thành phố London.
SELECT maNCC, tenNCC,trangthai, thanhpho
FROM Nhacungcap
WHERE thanhpho='London';

--4. Hiển thị mã phụ tùng, tên và màu sắc của tất cả các phụ tùng ở thành 
--phố Paris.
SELECT maPT, tenPT, mausac
FROM Phutung
WHERE thanhpho='Paris';

--5. Hiển thị mã phụ tùng, tên, khối lượng của những phụ tùng có khối 
--lượng lớn hơn 15.
SELECT maPT, tenPT, khoiluong
FROM Phutung
WHERE khoiluong>15;

--6. Tìm những phụ tùng (maPT, tenPt, mausac) có khối lượng lớn hơn 15, 
--không phải màu đỏ (red).
SELECT maPT, tenPT, mausac
FROM Phutung
WHERE khoiluong >15 and mausac != 'red';

--7. Tìm những phụ tùng (maPT, tenPt, mausac) có khối lượng lớn hơn 15, 
--màu sắc khác màu đỏ (red) và xanh (green).
SELECT maPT, tenPt, mausac
FROM Phutung
WHERE khoiluong >15 and mausac not in  ('red', 'green')

--8. Hiển thị những phụ tùng (maPT, tenPT, khối lượng) có khối lượng lớn 
--hơn 15 và nhỏ hơn 20, sắp xếp theo tên phụ tùng.
SELECT maPT, tenPt, khoiluong
FROM Phutung
WHERE khoiluong>15 and khoiluong <20 
ORDER BY tenPT ASC

--9. Hiển thị những phụ tùng được vận chuyển bởi nhà cung cấp có mã số S1. 
--Không hiển thị kết quả trùng. (sử dụng phép kết).
SELECT PT.MAPT, TENPT
FROM PHUTUNG PT JOIN Vanchuyen VC ON PT.MAPT=VC.MAPT
WHERE maNCC='S1' 

--10. Hiển thị những nhà cung cấp vận chuyển phụ tùng có mã là P1 (sử dụng 
--phép kết).
select *
from Nhacungcap n join Vanchuyen vc
on n.maNCC = vc.maNCC
where vc.maPT = 'P1'

--11. Hiển thị thông tin nhà cung cấp ở thành phố London và có vận chuyển 
--phụ tùng của thành phố London. Không hiển thị kết quả trùng. (Sử dụng 
--phép kết)
select n.maNCC, n.tenNCC
from (Nhacungcap n join Vanchuyen vc on n.maNCC = vc.maNCC) join Phutung pt on vc.maPT = pt.maPT
where n.maNCC = 'London' and pt.thanhpho = 'London'

--12. Lặp lại câu 9 nhưng sử dụng toán tử IN.
--Hiển thị những phụ tùng được vận chuyển bởi nhà cung cấp có mã số S1. 
--Không hiển thị kết quả trùng
SELECT MAPT, TENPT
FROM PHUTUNG
WHERE MAPT IN (SELECT MAPT
			   FROM VANCHUYEN VC
			   WHERE VC.MAPT =PHUTUNG.MAPT AND MANCC='S1');

--13. Lặp lại câu 10 nhưng sử dụng toán tử IN  
-- Hiển thị những nhà cung cấp vận chuyển phụ tùng có mã là P1 (sử dụng 
--phép kết
select *
FROM Nhacungcap NCC
WHERE MANCC IN ( SELECT MANCC
				FROM VANCHUYEN VC
				WHERE NCC.maNCC= VC.maNCC AND VC.MAPT='P1')

--14. Lặp lại câu 9 nhưng sử dụng toán tử EXISTS
SELECT MAPT, TENPT
FROM PHUTUNG
WHERE EXISTS (	SELECT *
				FROM VANCHUYEN VC
				WHERE VC.MAPT=Phutung.MAPT AND MANCC='S1');

--15. Lặp lại câu 10 nhưng sử dụng toán tử EXISTS 
--Hiển thị những nhà cung cấp vận chuyển phụ tùng có mã là P1 (sử dụng 
--phép kết)
SELECT *
FROM NHACUNGCAP NCC
WHERE EXISTS (  SELECT *
				FROM Vanchuyen VC
				WHERE NCC.maNCC= VC.maNCC AND VC.MAPT='P1')

--16. Lặp lại câu 11 nhưng sử dụng truy vấn con. Sử dụng toán tử IN.
--Hiển thị thông tin nhà cung cấp ở thành phố London và có vận chuyển 
--phụ tùng của thành phố London. Không hiển thị kết quả trùng.
SELECT *
FROM Nhacungcap ncc
WHERE maNCC IN (SELECT maNCC
FROM Vanchuyen vc JOIN Phutung pt on vc.maPT=pt.maPT
WHERE ncc.thanhpho='London' and pt.thanhpho = 'London' and ncc.maNCC=vc.maNCC)

--17. Lặp lại câu 11 nhưng dùng truy vấn con. Sử dụng toán tử EXISTS. 
SELECT *
FROM Nhacungcap ncc
WHERE exists (SELECT *
FROM Vanchuyen vc JOIN Phutung pt on vc.maPT=pt.maPT
WHERE ncc.thanhpho='London' and pt.thanhpho = 'London' and ncc.maNCC=vc.maNCC)

--18. Tìm nhà cung cấp chưa vận chuyển bất kỳ phụ tùng nào. Sử dụng NOT 
--IN.
SELECT *
FROM Nhacungcap
WHERE maNCC NOT IN(SELECT VC.maNCC
FROM Vanchuyen VC
WHERE VC.maNCC=Nhacungcap.maNCC );

--19. Tìm nhà cung cấp chưa vận chuyển bất kỳ phụ tùng nào. Sử dụng NOT 
--EXISTS.
select *
from Nhacungcap 
where not exists (select maNCC from Vanchuyen
where Nhacungcap.maNCC = Vanchuyen.maNCC)

--20. Tìm nhà cung cấp chưa vận chuyển bất kỳ phụ tùng nào. Sử dụng outer 
--JOIN (Phép kết ngoài)
select *
from Nhacungcap n left join Vanchuyen v
on n.maNCC = v.maNCC
where v.maPT is null

--21. Có tất cả bao nhiêu nhà cung cấp?
SELECT COUNT(MANCC) 'SL_NCC'
FROM NHACUNGCAP

--22. Có tất cả bao nhiêu nhà cung cấp ở London?
SELECT COUNT(MANCC) 
FROM NHACUNGCAP
WHERE thanhpho='London'
--23. Hiển thị trị giá cao nhất, thấp nhất của trangthai của các nhà cung 
--cấp.
SELECT MAX(TRANGTHAI) TrangThaiCaoNhat, Min(Trangthai) TrangThaiThapNhat
FROM Nhacungcap

--24. Hiển thị giá trị cao nhất, thấp nhất của trangthai trong table 
--nhacungcap ở thành phố London.
SELECT MAX(TRANGTHAI) TrangThaiCaoNhat, Min(Trangthai) TrangThaiThapNhat
FROM Nhacungcap
WHERE thanhpho='London'

--25. Mỗi nhà cung cấp vận chuyển bao nhiêu phụ tùng? Chỉ hiển thị mã nhà
--cung cấp, tổng số phụ tùng đã vận chuyển.
SELECT NCC.maNCC, SUM(soluong) 'SL_PT'
FROM Vanchuyen VC FULL JOIN Nhacungcap NCC ON VC.MANCC=NCC.MANCC
GROUP BY NCC.maNCC

--26. Mỗi nhà cung cấp vận chuyển bao nhiêu phụ tùng? Hiển thị mã nhà cung 
--cấp, tên, thành phố của nhà cung cấp và tổng số phụ tùng đã vận chuyển
SELECT NCC.maNCC, tenNCC, NCC.thanhpho, SUM(soluong) 'SL_PT'
FROM Vanchuyen VC RIGHT JOIN Nhacungcap NCC ON VC.MANCC=NCC.MANCC
GROUP BY NCC.maNCC, tenNCC,thanhpho

--27. Nhà cung cấp nào đã vận chuyển tổng cộng nhiều hơn 500 phụ tùng? Chỉ
--hiển thị mã nhà cung cấp
SELECT VC.maNCC, SUM(soluong) 'SL_PT'
FROM Vanchuyen VC 
GROUP BY VC.maNCC
HAVING SUM(SOLUONG)>500

--28. Nhà cung cấp nào đã vận chuyển nhiều hơn 300 phụ tùng màu đỏ (red). 
--Chỉ hiển thị mã nhà cung cấp.
SELECT VC.maNCC, SUM(soluong) 'SL_PT'
FROM Vanchuyen VC JOIN PHUTUNG PT ON VC.maPT= PT.maPT
WHERE mausac='RED'
GROUP BY VC.maNCC
HAVING SUM(SOLUONG)>300

--29. Nhà cung cấp nào đã vận chuyển nhiều hơn 300 phụ tùng màu đỏ (red). 
--Hiển thị mã nhà cung cấp, tên, thành phố và số lượng phụ tùng màu đỏ đã 
--vận chuyển.
SELECT NCC.maNCC, tenNCC, NCC.thanhpho, SUM(soluong) 'SL_PT'
FROM (Vanchuyen VC JOIN PHUTUNG PT ON VC.maPT= PT.maPT)JOIN Nhacungcap NCC ON NCC.MANCC=VC.MANCC
WHERE mausac='RED'
GROUP BY NCC.maNCC, tenNCC, NCC.thanhpho
HAVING SUM(SOLUONG)>300

--30. Có bao nhiêu nhà cung cấp ở mỗi thành phố.
SELECT thanhpho , COUNT(MANCC) NHACUNGCAP
FROM Nhacungcap
GROUP BY thanhpho

--31. Nhà cung cấp nào đã vận chuyển nhiều phụ tùng nhất. Hiển thị tên nhà
--cung cấp và số lượng phụ tùng đã vận chuyển.
SELECT TOP 1 TENNCC, SUM(SOLUONG) SOLUONG
FROM NHACUNGCAP A JOIN VANCHUYEN B ON A.MANCC= B.MANCC 
GROUP BY TENNCC
ORDER BY SUM(SOLUONG) DESC

--32. Thành phố nào có cả nhà cung cấp và phụ tùng.
SELECT THANHPHO
FROM Nhacungcap
INTERSECT 
SELECT THANHPHO
FROM Phutung

--33. Viết câu lệnh SQL để insert nhà cung cấp mới: S6, Duncan, 30, Paris.
INSERT inTO NHACUNGCAP VALUES('S6', 'Duncan' , '30' , 'Paris')

--34. Viết câu lệnh SQL để thay đổi thanh phố S6 (ở câu 33) thành Sydney.
update
Nhacungcap
set thanhpho= 'Sydney'
WHERE thanhpho = 'Ducan'

--35. Viết câu lệnh SQL tăng trangthai của nhà cung cấp ở London lên thêm
update 
Nhacungcap 
set trangthai = trangthai + '10'
where Nhacungcap.thanhpho = 'london'

--36. Viết câu lệnh SQL xoá nhà cung cấp S6
delete from Nhacungcap
where Nhacungcap.maNCC ='S6'