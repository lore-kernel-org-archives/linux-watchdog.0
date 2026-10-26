Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055665;
	b=JiOsAJQRk9BOKrz4IPjpxRIlf9eVcAIFefUbnoWlR2zo658yNqK46wfjtnYK3Qr7+KV9
	 ie0DNpyY0xaMP/ybNXP75Cx05FIXNS5oHEJmRkgmc5vdCAI0+K+LxJVquprvpbPlRNXmE
	 xbWG4azCzwwHFZriPH+v+D0DeWzLu5ni5fCp0KT3jncphCAOo8D7/iNXW/pSfFH2j5A+O
	 fFlaIMexU9NrZtApf5ryDEaYNFQh7+dZv5TZv1w4HBixrkNLK3/GmqKau5Vw+ZxbBhnxY
	 ZtTz5MpVHILz3sr4chYdKsA3rivIFug96xMuQsjh0/aDaleVrM7UuOF9I1KchFOHJQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055665;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=ZS1PHJd/1kfglLt+YTBZHOFCcwN5pAQrZFvDsEPdmWI=;
	b=3GCrQuJvDWhH2QL/ocmnJeNcWUPKDQoTVTOZanzYhOM/RCcf1DY3Y57jtoEMslfep27T
	 SkBFr9nKHymodbv69477BxXvdTXJtByh/UBwGDYYbI+/agpaizVnz+DNHuFXeXqWa+Opy
	 yTiN3glElIVx2Lv70zvCacPhBEI5qbgK2118ES2QsgSzKI4SdjjDC7XIxIpx0CM7E90f4
	 f8NGifQnGoNYWp15nSV5v4je8ueWJlY7IhTphVr/atG0V5aSry55KcTyzpJkQ8G6Ed0sV
	 XTD8mkNTfp1/yWt53/ABsGt2N9SkQa1kEAWI0Qh41gHg+LYfc7HbUSdqX84NzljaftA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=2jM83HXB;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E64606A31E
	for <linux-watchdog@vger.kernel.org>; Mon, 26 Oct 2026 23:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62E64606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=2jM83HXB
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id LPYjxk828usRSLTgaxwEX2; Mon, 26 Oct 2026 23:01:00 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LTgZx1Og9nXJHLTgZxvYtO; Mon, 26 Oct 2026 23:00:59 +0000
X-Authority-Analysis: v=2.4 cv=JMM7s9Kb c=1 sm=1 tr=0 ts=6adfdbab
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=Sy_gwa-xmTSU6y4k134A:9 a=CjuIK1q_8ugA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZS1PHJd/1kfglLt+YTBZHOFCcwN5pAQrZFvDsEPdmWI=; b=2jM83HXB819/h3xM9KjgljF/9n
	vL2UCLcg9ZQhTotDPoROs33v2zgPEpqR1FAuAaPhl8HH7Vvn45Q2NGKWthn3/S8ttfDtgv95ZRfHo
	MnxjXy41RHg59ViklqyAaS6yWuVN3PaW+dnjBnHBmg3feGGI/dkm/epTXwfPjZ1X9SkVi+Bziyb/S
	XlBAWZoTUzdxdvMII3DZNMTU5WQnv7bPWUL7Ev+x1qA+BqIpcfPH/LwMCOoQ4GkWaRKU1sjH/i+/2
	JcZybELE0P9vbERM3XUdgFrvuWq5vGR6e/13oHONEYwUU9b8bRv30nUZuTxDZScL7IBav5kctQVgB
	1sIcCFAA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48364 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLTgY-00000004JNJ-3Igt;
	Tue, 27 Oct 2026 04:30:58 +0530
Date: Mon, 26 Oct 2026 16:00:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: p.zabel@pengutronix.de, Sergey.Semin@baikalelectronics.ru,
	mika.westerberg@linux.intel.com, andi.shyti@kernel.org, iav@iav.lv,
	tzungbi@kernel.org, wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] watchdog: dw_wdt: use
 devm_reset_control_get_optional_shared_deasserted
Message-ID: <ae899e5f-dc86-4fcd-a706-b096ef766c38@roeck-us.net>
References: <20261024140854.25664-1-a.shimko.dev@gmail.com>
 <20261024140854.25664-2-a.shimko.dev@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024140854.25664-2-a.shimko.dev@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLTgY-00000004JNJ-3Igt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:48364
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBv2PPUlx0pOspMnefuWrkPn1OkDHsXrnljd4WVvVekZFCXcj8iWqq59It0HwbpWtMBWCCO59DSPnL6a87e1ECtHkwfY7Lgyi4CY5qABYO62xyHULmM9
 wxW5HD3zhpu2i39CPpioyHB4ZwZ/EBoMPRB2HV3yIqTjZL8+W3hmKjxvbr8ZuQ46hnhhucpYYbR0lFJXwwAggNPd8NaHZ4sFYO9cwWgbid9UIjxjrSk6w+np

On Sat, Oct 24, 2026 at 05:08:50PM +0300, Artem Shimko wrote:
> Replace devm_reset_control_get_optional_shared() with
> devm_reset_control_get_optional_shared_deasserted() to let the
> device-managed API handle reset line deassertion and assertion
> automatically.
> 
> The driver currently manages the reset control manually: it calls
> reset_control_deassert() during probe and reset_control_assert() in
> error paths and remove. This is error-prone and requires explicit
> cleanup in multiple places.
> 
> Switching to the _deasserted variant deasserts the reset line on
> acquisition and asserts it again when the device is removed, which
> allows removing the out_assert_rst label along with the related
> assertions in the probe error paths and in dw_wdt_drv_remove().
> 
> Tested-by: Igor Velkov <iav@iav.lv>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>

Applied.

Thanks,
Guenter
