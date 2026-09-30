Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350F36D9E7
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738725; cv=none; b=NdtZ8Ctq9wSV9LVHXqB0A8Ary1BOIVdLTn3x0NN69WXlh5tQlUQg6r+UJcMssTPyMpgNt/bf6SXDgfM87+loNAaaEYpEgAWvuDOT94VSJdafXw9XLhwnAeIzqUe9OEFk5S7+Y7G97HL81JTB4quR/Yd9tU6SfRnvGUpC7XGSa2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738725; c=relaxed/simple;
	bh=X93RA5rgWCekk+Xsp5aOujEMtC+NO/2XlXgFmidXf8A=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=HJl7A70zWMHKAt/jX8rWmaB5hxP/OgCtwX9/IN/CwhvTj5tXZ0K4nEUuK4CZCTJMvzns3q+B8W3nl9jzryIn02peBtAGZJcGDmf+8U1aXIPyCSYWhSRr4MwvbsWTpWkZ2HCZ8dHeZcMx6hGuChDV2ROykIASinwPfXvJNoZwUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YJ/7lv1N; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YJ/7lv1N"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260930032520epoutp026d26d64a92e76da2374d528ca6456c71~Z_2DjWOVd2428424284epoutp02m
	for <linux-watchdog@vger.kernel.org>; Wed, 30 Sep 2026 03:25:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260930032520epoutp026d26d64a92e76da2374d528ca6456c71~Z_2DjWOVd2428424284epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790738720;
	bh=qV/9he1CawIScaCGwp9M2kCWY31FQD0hOy1LYFGRfWQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=YJ/7lv1NTqkHWVZJBDhKZGIA6PI9CmYxFlGMYE3ZLIjz9PSymQqjaJJXw8+e1jNOO
	 iQUVkyHFIu62a3ZiIVITzpGd5v3jOIa/YrZWD0KhNwtIL995PUH908SvuXnNQszqPR
	 qJeHKVJrLJjI3TWIMTpxE4CYlBhmBfIJwgTOLMxg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260930032519epcas5p3ad47f970405abdcfcd06ac7290b08725~Z_2DDEJ9F0907109071epcas5p3Z;
	Wed, 30 Sep 2026 03:25:19 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.95]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hvgR1131Jz6B9m4; Wed, 30 Sep
	2026 03:25:17 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260930032516epcas5p4d193b18297c922226d567018e738bf41~Z_1-jov4d1681816818epcas5p4X;
	Wed, 30 Sep 2026 03:25:16 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260930032514epsmtip2aff10d7c9cb83aa870b567b932aff677~Z_199F3SY1916719167epsmtip2P;
	Wed, 30 Sep 2026 03:25:14 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <peter.griffin@linaro.org>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <linusw@kernel.org>
Cc: <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<linux@roeck-us.net>, <hajun.sung@samsung.com>, <wim@linux-watchdog.org>
In-Reply-To: <4cc0ca7d-82ae-493d-ac15-478cdd8f0e08@kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindings: watchdog: Add Exynos8855 watchdog
 compatible string
Date: Wed, 30 Sep 2026 08:55:12 +0530
Message-ID: <13f401dd508b$4fac48b0$ef04da10$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGT+8p9vB0AkaS/QifuXnNLP8ZDSgH+CJFiAV/CSEW3XjBwgA==
Content-Language: en-us
X-CMS-MailID: 20260930032516epcas5p4d193b18297c922226d567018e738bf41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260927150938epcas5p33b7d0495f8d9a8e84bf5f09c66e757fb
References: <CGME20260927150938epcas5p33b7d0495f8d9a8e84bf5f09c66e757fb@epcas5p3.samsung.com>
	<20260927152738.3673504-1-alim.akhtar@samsung.com>
	<4cc0ca7d-82ae-493d-ac15-478cdd8f0e08@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Sunday, September 27, 2026 10:41 PM
> To: Alim Akhtar <alim.akhtar@samsung.com>; peter.griffin@linaro.org;
> robh@kernel.org; conor+dt@kernel.org; linusw@kernel.org
> Cc: linux-samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-watchdog@vger.kernel.org; linux@roeck-
> us.net; hajun.sung@samsung.com; wim@linux-watchdog.org
> Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add Exynos8855
> watchdog compatible string
> 
> On 27/09/2026 17:27, Alim Akhtar wrote:
> > Add the 'samsung,exynos8855-wdt' compatible string to the Samsung
> > watchdog device tree binding documentation. The Exynos8855 watchdog
> > nodes use two clocks (bus clock and source clock), require
> > samsung,cluster-index and samsung,syscon-phandle properties, similar
> > to Exynos850 watchdog implementation.
> >
> > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> > ---
> > * Changes in V2:
> >  - Fixed Sashiko review comment
> > 	- [Low] dt-bindings: watchdog: missing comma in
> > samsung,syscon-phandle description
> >
> >  Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml | 6
> > ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> > b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> > index a32c47831577..3f8c3e56ea07 100644
> > --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.yaml
> > @@ -25,6 +25,7 @@ properties:
> >            - samsung,exynos5515-wdt
> >            - samsung,exynos7-wdt                   # for Exynos7
> >            - samsung,exynos850-wdt                 # for Exynos850
> > +          - samsung,exynos8855-wdt                # for Exynos8855
> 
> 
> Just drop the comment like we did for 5515.
> 
Sure, will update in next version

> Reviewed-by: Krzysztof Kozlowski
> <krzysztof.kozlowski@oss.qualcomm.com>
> 
Thanks for your review. 

> Best regards,
> Krzysztof

