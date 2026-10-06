Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308C372EE4
	for <linux-watchdog@vger.kernel.org>; Tue,  6 Oct 2026 04:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791260928; cv=none; b=nZ6E6aZhm+rSC+gnr/EZsRF+eu5uHohNFIDp1Tk4rMUEFWWWyUW8icjbglZ+Dzg18CL4ROMdMRB3EfLuki+6b7NAeCm9fTyNkMj1dBZJy/A/a0kNguXFydEHhOvA18WQ8n3drkSH60eX2mgciQFNBiA9OyfJq6TYnAb7kvuh6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791260928; c=relaxed/simple;
	bh=bo2X3hDeI4pBnunTcHhhTv7/UJwW6YG6gQ9h4NZtf1c=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=JxDY7rED9RHsv2Dn+/yUcd9c373ZYa1YeaNL2pNa+hxf5POw1C5apthNzSNljYhWxa1K/jGiUMZqsQECTAadj3n2trRk/6GRO5hoYOFBsWrGGnqvEBT96fdLKd5K7DtL1WhXXxM9wQ0nc190nEYiIvsK4j+Fr/hoZ8VbNfNjUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=az278A1A; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="az278A1A"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261006042836epoutp04b78f824f545f4e4e937730c13c2e6d03~b1lAycZ7T1628416284epoutp04P
	for <linux-watchdog@vger.kernel.org>; Tue,  6 Oct 2026 04:28:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261006042836epoutp04b78f824f545f4e4e937730c13c2e6d03~b1lAycZ7T1628416284epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791260916;
	bh=LgntyPCT6mbiDQeIW6B53O9DRHxz2wX1AyNTwm4lHi4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=az278A1AT5woz2LO9nCwKc56yOcJp2CKzCO033T58bFlnVZ5IbgAYglFDQcik64tV
	 ssUF2dQgmftHgqF5d8kXAsQmDCq5esefw9ccB51LnrKLnGvb/RSPUQF8OYUtPCgpbj
	 GgIz4lndLDTBNieNw+a/Xg02xCjbRZPagyx7S6hY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261006042835epcas5p24a08e2017b6d2f377eb2245a203597c7~b1k-SGrtO1183111831epcas5p2Z;
	Tue,  6 Oct 2026 04:28:35 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hzNYG2vjjz6B9mD; Tue,  6 Oct
	2026 04:28:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261006042833epcas5p4ce0e831af9c9d099e022ee6fc6e8ec79~b1k9_G1RV0768007680epcas5p4Y;
	Tue,  6 Oct 2026 04:28:33 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20261006042832epsmtip1b09d3016748e0b94bfd2d6f288100092~b1k8bE5mJ0554705547epsmtip10;
	Tue,  6 Oct 2026 04:28:31 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Peter Griffin'" <peter.griffin@linaro.org>
Cc: <krzk@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<linusw@kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux@roeck-us.net>,
	<hajun.sung@samsung.com>, <wim@linux-watchdog.org>
In-Reply-To: <CADrjBPrXYX4_d9dJ=SUqHf-eMDyuSpSChkuTsrPHfo2ZNh2mMw@mail.gmail.com>
Subject: RE: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add support for
 Exynos8855 SoC
Date: Tue, 6 Oct 2026 09:58:30 +0530
Message-ID: <18b901dd554b$259eb890$70dc29b0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJaA0b9OUQoKjNfig97L7/y+bvwowH+CJFiAXoAkAkBm/b0zbXN73ow
Content-Language: en-us
X-CMS-MailID: 20261006042833epcas5p4ce0e831af9c9d099e022ee6fc6e8ec79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260927150943epcas5p1fb1720070f2bdca2c6cd32094dde895c
References: <CGME20260927150943epcas5p1fb1720070f2bdca2c6cd32094dde895c@epcas5p1.samsung.com>
	<20260927152738.3673504-1-alim.akhtar@samsung.com>
	<20260927152738.3673504-2-alim.akhtar@samsung.com>
	<CADrjBPrXYX4_d9dJ=SUqHf-eMDyuSpSChkuTsrPHfo2ZNh2mMw@mail.gmail.com>

Hi Peter

> -----Original Message-----
> From: Peter Griffin <peter.griffin@linaro.org>
> Sent: Friday, October 2, 2026 8:32 PM
> To: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: krzk@kernel.org; robh@kernel.org; conor+dt@kernel.org;
> linusw@kernel.org; linux-samsung-soc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-
> watchdog@vger.kernel.org; linux@roeck-us.net; hajun.sung@samsung.com;
> wim@linux-watchdog.org
> Subject: Re: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add support for
> Exynos8855 SoC
> 
> On Sun, 27 Sept 2026 at 16:09, Alim Akhtar <alim.akhtar@samsung.com>
> wrote:
> >
> > Watchdog IP on this SoC is similar to Exynos850/ExynosAutov{9/920}.
> > This does not have CNT_EN_WDT bit in PMU and offset of RST_STAT is
> > different then the previously support SoC.
> > Reuse the offset as much as from already supported SoC
> >
> > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> > ---
> 
> Small nit: If you send another version, the last sentence could be updated
> slightly for clarity. Something like "Reuse the offsets as much as possible
> from already supported SoCs"
> 
Sure, will update

> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> 
Thank you!

