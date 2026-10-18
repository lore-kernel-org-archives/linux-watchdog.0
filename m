Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945A4D37A5
	for <linux-watchdog@vger.kernel.org>; Sun, 18 Oct 2026 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337160; cv=pass; b=uaudhZ3WhMzajaXtCZ7dJrThcB3V7mmcoVi2U32b5EbKoqGpuL4aSXW+G/BWy4MH/YMC2UokmliL2hOANLgplTKc7HMaGuGoL7G1jNqnDwjYPDMHmvHM+Hm6RLdo6vhRT1CzghAUST3Z6U5JHs1H2s6C03E3b218mUinQciUK40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337160; c=relaxed/simple;
	bh=pYj9KOwby5WOyiUljX2P5pkbJpyvoEONB/A3xxCE51E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=V/Be3OYhLAyO4B1HnDLmyN87gQ+X2ma7fXMnDyb+M/IG0IQsr25eWUAOct93f1h1k3HPL0LSgZmV5Z1bHx/gcGFHqNvFWDwht0YTwEmFGBz+AuEpmBwKqGprBLwqvAeFSbAjkNAPyCRB6IhQoALKtv66ZI9j7dmcXUoHHbOn71g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=VE+lwrZa; arc=pass smtp.client-ip=136.143.169.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="VE+lwrZa"
ARC-Seal: i=1; a=rsa-sha256; t=1792337112; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XL0mLtks285Qvqgw6s3AE/+rqkTeKSld6BrzIf9QLiP7uJS2tY1NvRqPLr2zZEA96xl4pawM9WMKh6q9qh8mBz2X+KM2PwoYJd/yO4W0W6PpMASq1W78mkVRp/1jZ0JBG5NvWR4/24eP/meg0ybRtcbukUP8mkxGWk/maGituoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792337112; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pYj9KOwby5WOyiUljX2P5pkbJpyvoEONB/A3xxCE51E=; 
	b=E3724LjIAqJy1YsiIQ6dHX5GuEMoOmLLjJAZ21xpFPIFXTvUBirKh/xsHaQtvKQNWSyS0cVBFIrvRD7i1G6e5LhCQvJElF4BUssCiRI0tWvVJzdCjOaiymjTEu0KnFrPnWl1S1xQvFKTcJbG0j/z/r6z3cOqyh6eerACYgjkxYw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792337112;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pYj9KOwby5WOyiUljX2P5pkbJpyvoEONB/A3xxCE51E=;
	b=VE+lwrZaxl0iOFRffB5zL0yAwmuX/jqDnXuzk1u0SlDJx2KIHV9nwMH79zSH8Dmc
	ldSaI9LdcbIWmIR3atkoquWbTWDoBPmq0o4hdXe8pO0l2oIre3/y5FcvVZaiiXBWSWa
	2lQUOBZM93EpO0JmBK+idCgyoJE3qXJwVF5+EMDQ=
Received: by smtp.zoho.eu with SMTPS id 1792337107899928.9049207179256;
	Sun, 18 Oct 2026 17:25:07 +0200 (CEST)
Date: Sun, 18 Oct 2026 18:25:06 +0300
From: Igor Velkov <iav@iav.lv>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>, p.zabel@pengutronix.de, mika.westerberg@linux.intel.com, andi.shyti@kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH 0/5] watchdog: dw_wdt: reset clean up and pm
In-Reply-To: <CAOPX747Nbzs0aQBoxXx2_K9qY2_6RyMqtcpWcop3KrZqcm0u7g@mail.gmail.com>
References: <20260320135624.223863-1-a.shimko.dev@gmail.com> <25916fdf-22e2-4884-a78f-a7926a99b63e@roeck-us.net> <20261018-dw-wdt-shimko-v2-ask@iav.lv> <CAOPX747Nbzs0aQBoxXx2_K9qY2_6RyMqtcpWcop3KrZqcm0u7g@mail.gmail.com>
Message-ID: <20261018-dw-wdt-shimko-v2-test@iav.lv>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Artem,

Sounds good. Glad to help with testing v2 on Helios64 and ROCK Pi 4A;
please Cc me.

Igor
