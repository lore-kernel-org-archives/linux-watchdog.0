Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A642382289;
	Thu,  2 Apr 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114238; cv=none; b=GceAwqR15ytUof6YrsLuOaa0aN6Dyn0wllsdaVDGcxGuZi7u4jQH4QXYuUf2CKpdLqNWuqbY/9Sia7pFi/xDggwtM4dcAJglZLEGI/K/lTaahnpRd8o3Yb3rxo9pCYOTgSG4EGVmVqaZdraXaluFUhJty5E3vtU9dJ17XYjhZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114238; c=relaxed/simple;
	bh=zxHiHfOjFxUFkDnrq3pHwxlX8zHOOIIa9DClIPmpmqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rLe+MhKHmq9Gm/Z8alV++mqLel97oi8nCOc5J8TKow65VTyzoWKPyGuJeDUNjBldLmAOE3Rvy8trKxHbae7ejtaSsZzKVMhL+/y2QfCZYObHnGJQY+5AGdvo0M7w8t5JI3zK0b2Wa1SXGHz7phAnlIXPI+YrTI9rTl86Knh8ssI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iDQP4K8J; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="iDQP4K8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775114206;
	bh=HTHEhMNy1LKjVkA3Y3VLCDgMuXh/nWRwqm1DxefL2fY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=iDQP4K8JVKewm/0NKwYEPnDeYsHpEghi98cS9Phzhs5vZ5xMaC5fuh9uGAdLbl+5Z
	 SekLsMngt5BrxLOz1qdnt+XtqckZ+loBjOeHPvd7RdQjs9s+JqT/OFerFMt3bJ82qL
	 GsOzA0r4TqA24ia2SN1DDGMeMmi7gbMI12JiJ1co=
X-QQ-mid: zesmtpip3t1775114189t1bfbe1fa
X-QQ-Originating-IP: dna/jcmKyfxU8dCu5kKumofqgaR30Gt66mCoksdFMlg=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 02 Apr 2026 15:16:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2599220049431425010
EX-QQ-RecipientCnt: 6
From: Yingjie Gao <gaoyingjie@uniontech.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net,
	yuechao.zhao@advantech.com.cn,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yingjie Gao <gaoyingjie@uniontech.com>
Subject: [PATCH 1/1] watchdog: sp5100_tco: Use EFCH MMIO for newer Hygon FCH
Date: Thu,  2 Apr 2026 15:16:17 +0800
Message-Id: <20260402071617.634563-2-gaoyingjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260402071617.634563-1-gaoyingjie@uniontech.com>
References: <20260402071617.634563-1-gaoyingjie@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MHjhwO7LGLku1ASnyHybtSUQJFbdPV+MMvGa4jviCrDVED+WZiH3ZaVO
	QxP+HFRD/JHIsDI97iCec7GHt9pp9WCE7XXNhIuumCgyJms8+UOcE/Mpjr8fg4z/oo1jWpo
	RyMrr75l81JeuH2hdV5ep8oNNOBEQ5ebIAU8DPcygWK17TSrjKfNEANA8pio/zu36LRvGOs
	9qPjJwcrfqMAbJjhoa5I7NOLWgzgZj4G2AbfmJJBVzlGpqhMMXGg1XJV6SN6q6jzQrqV1Bo
	4QgwITOLMLhvO0KRbFwaFEiY+P3xlWO9eVw5k5Qk8dcb5jUzOJwpXbSeOLHl5vwxXd2Ek/n
	MMdbyIjNghFygCr2XXBLgVV2N5JQQ9hLO4b8dPjtyLuN3FdZIQ8QRvgwFYX/0wnfye2uaKR
	4JC9MW3HoZQohyaO8u0F8lX85DqleEpYhN6RlzkeLeyQp877GUnuxqI6XUXKsINSKdKU0kM
	UvOzwNROmcNPYjwtE1gARcWNKzE9Nj6J+V5uFu7jXPOxFElb2P8NDFNoQDXMalyvrAoFAr4
	1hVLeohYgd1N4cpVpXcaoj8q9PlDFiMVgsAvp/Ts6c37JWhl4wyjR12DOBPYf4/7PcoZkeK
	mxQhRO8tb+hfXFOaN3lt6GkzMpob6StuSDFTPWn8ewbALWjWcJIyXU84NdP4k9U2dY5Glp7
	FXv1A5NSyvBV6NkH5NHqQkvE/lrPx0POoJYHcjHOoch/5GMXxSi4JHcbdPpSgEmrFgrPPkz
	Z/d0dhfyQ30dcA7d+cagbBeGtk3F+CowVByFWzQA4tAbZoHk0tM4d3/iKfrc09ulqvU2tAK
	ULFLx12ZvQVETX6bcJe9pyKTUjyPaqZVRVh+I/7+v23vFUcEXrMGNWxsb1jh3NiCO6OIL9h
	iejG/b1xJgPln0Jp7po1G/dRZ7jFPN9arYGKYE3o5b7aZxsWO9xVUT/VSXxzTMUIjDOXXuR
	zc064sWIGZdFaxPAQM5wDzH/DAmtgEmYW2YUQOzni9+llU9mqjQNj4Kzl/m56bXRIPm4poo
	p5oH7zIu+2gMvA5JQlkdOht07SGRZdCc9Uc1+sULosfGOzBumgrjEqKt+zn6RlHi5lSpC8O
	gtYoYbqdJddfVZmPojd06vVf6mU0UJUbkgZDkXvV1oEaT6AdSvYs/Q=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Commit 009637de1f65 ("watchdog: sp5100_tco: support Hygon FCH/SCH
(Server Controller Hub)") added Hygon vendor matching to the efch
layout selection, but newer Hygon 0x790b SMBus devices still need the
efch_mmio path.

The efch_mmio path enables EFCH_PM_DECODEEN_WDT_TMREN before probing the
watchdog MMIO block. If firmware leaves that bit clear and the driver
picks the legacy efch path instead, probe falls back to the alternate
window and fails with "Watchdog hardware is disabled".

Select efch_mmio for Hygon 0x790b devices with revision 0x51 or later,
matching the equivalent AMD behavior and allowing the watchdog to
initialize on those systems.

Fixes: 009637de1f65 ("watchdog: sp5100_tco: support Hygon FCH/SCH (Server Controller Hub)")
Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>
---
 drivers/watchdog/sp5100_tco.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 2bd3dc25cb03..7e99c3b1f367 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -92,7 +92,8 @@ static enum tco_reg_layout tco_reg_layout(struct pci_dev *dev)
 	    dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	    dev->revision < 0x40) {
 		return sp5100;
-	} else if (dev->vendor == PCI_VENDOR_ID_AMD &&
+	} else if ((dev->vendor == PCI_VENDOR_ID_AMD ||
+		    dev->vendor == PCI_VENDOR_ID_HYGON) &&
 	    sp5100_tco_pci->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
 	    sp5100_tco_pci->revision >= AMD_ZEN_SMBUS_PCI_REV) {
 		return efch_mmio;
-- 
2.20.1

