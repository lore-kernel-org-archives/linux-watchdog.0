Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107116;
	b=MoPLyGlOpRmZPaDgFdQurg6+3Rdt3+GvO74eUGpcbzuGrQu4LsDfooZ9enGtZtWKk7SO
	 qu+srLuueVBbbx55HZRcx0GuQmhVjD8DGEkRLiJGfYsZhplm5IG08dBflucM4bWUZ+HG2
	 OimDrMW4dCfnSVZDQfUGP+j+gMwRDiaTOaxGw6VSxkvrz8r0C7mBlPOSDh6CoydjY8FZn
	 So8DKUWBQd3AG4oxXvYCGcrR7eGIUpKqlU0nC9QfPtGIaip7v3ygQPQzkwBCR+qqfSNDj
	 tGEvq321Yoqi9NT7gSucqYEUoDlEi26kndCXz0oxdOU6jQAgIFJcbC+rj8uIbXhBUdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107116;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=VyuLjUWlndm/ZBOLKhEN/lw43++AjMQwOBflJ5LOk6s=;
	b=ejyw6I03p0anZRZtu1VS3ctJ9tw4cpOmuolXopRPRcJuOiwyW52lfGw4pcDT79Qhy9s+
	 ZGoVVGbuNvg2KZ4Yx5eYpdJgGH+G55v0N1b74psN3brW5y16SATiekCdUFktbpu3rJZ9G
	 yGPoDB0jWzb4TYvSYVtrRBGFzx0P/FS56YbAuwypfsLclwVFZDhj0MG6hKISGuckR45m7
	 Zr+MgmRWFRcHfONydE8Znk+1AbjIFJ5FzR5xQQxcJOlAEQVwyiMjZAq1xRnJjvKkuWwof
	 tcnD396m3+s7H+fSdNVUb0/tz1lGTAvvnvOFvFiKsuYqzmDlONuDQSCCH4vUEk+dkUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=TpqgAi2t;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1260A2603
	for <linux-watchdog@vger.kernel.org>; Thu, 19 Nov 2026 16:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C1260A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=TpqgAi2t
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id U4YNxdny6V16IU5MYxNRcl; Thu, 19 Nov 2026 16:51:54 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id U5MXx7Hv2laNKU5MYx3cog; Thu, 19 Nov 2026 16:51:54 +0000
X-Authority-Analysis: v=2.4 cv=UbpRSLSN c=1 sm=1 tr=0 ts=6aff292a
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=_jlGtV7tAAAA:8 a=IvRCNjoTNcy513YpXOgA:9 a=CjuIK1q_8ugA:10
 a=nlm17XC03S6CtCLSeiRr:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VyuLjUWlndm/ZBOLKhEN/lw43++AjMQwOBflJ5LOk6s=; b=TpqgAi2tfvQr8FgT+aFEOK34fc
	3BysAvJ3YX/SX8uqux912onyChgt5l0XwEoTIgfdY/1lBqm7IMEn6J/8+aGDb33+H/lB0s39d8TnS
	B/mahwJPkIOGTLThSks0Cv7GF3nMMo6zlRDfPMzlIeFRp9S3LTTVWZufQrV0ZuSjvXLVk22NZBLiK
	yUFAn+/tHSSCR2K7Qwjn6LLS07jB3IqxBZT+nL1igRkeT+1J9R9vZmtSKE6ONG5T/SUrA+Iy9o6GO
	5YMPBYf8w1IaGxuiT/Nu5jdGrHh0xkEPD6ST9rtP5aNBQ4Dz6xwFiqbxswfmDbLD7C/DiRRdR6cpi
	qSo3ZOzQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:56426 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xU5MU-00000003LGz-3x54;
	Thu, 19 Nov 2026 22:21:51 +0530
Date: Thu, 19 Nov 2026 08:51:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: a0282524688@gmail.com
Cc: lee@kernel.org, Ming Yu <tmyu0@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v10 06/13] mfd: nct6694: Move module type macros to
 shared header
Message-ID: <670e71a1-6f47-4d27-ae6d-10c24c66e34c@roeck-us.net>
References: <20261118081625.2399247-1-a0282524688@gmail.com>
 <20261118081625.2399247-7-a0282524688@gmail.com>
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
In-Reply-To: <20261118081625.2399247-7-a0282524688@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xU5MU-00000003LGz-3x54
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:56426
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 7
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIo6d4mnsyhsT4vlwROUgmKM5fdUcnFfkBwBKnpRKk0OLn+NUhD3Won+Yq26y75LNG/7ugedutM1EPAvmKbpWOaUTJG5neVXw41USTDJwz1VZBYjwcUG
 YQgQ8/Fd0Tu7+mr1LgOgwLEhzAZSdfb1vO/1eERHnMlSdF2/56pdF7AbxBb7NWpqmnrnCbucPZZoKF6OuKhLc8yZw7djmERMVgUBMW0p5kO9DCq+uHYMPWBk

On Wed, Nov 18, 2026 at 04:16:17PM +0800, a0282524688@gmail.com wrote:
> From: Ming Yu <a0282524688@gmail.com>
> 
> Each sub-device driver defines the module type used by its own
> commands. The upcoming HIF transport also needs to recognise
> NCT6694_RPT_MOD, as report accesses are served from a separate
> register space rather than through the command mailbox.
> 
> Move all module types into the shared header so that the transports
> and the sub-device drivers use a single set of definitions.
> 
> No functional change.
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Ming Yu <a0282524688@gmail.com>
> ---
> Changes in v10:
> - None.
> 
> Changes in v9:
> - Added Andi's Reviewed-by.
> 
> Changes in v8:
> - Reworded the commit message to explain why the transport needs the
>   module types.
> 
> Changes in v7:
> - None.
> 
> Changes in v6:
> - None.
> 
> Changes in v5:
> - Split from the monolithic v4 patch to follow the single logical change
>   principle.
> 
>  drivers/gpio/gpio-nct6694.c         |  7 -------
>  drivers/hwmon/nct6694-hwmon.c       | 21 ---------------------
>  drivers/i2c/busses/i2c-nct6694.c    |  7 -------
>  drivers/net/can/usb/nct6694_canfd.c |  6 ------
>  drivers/rtc/rtc-nct6694.c           |  7 -------
>  drivers/watchdog/nct6694_wdt.c      |  7 -------
>  include/linux/mfd/nct6694.h         |  9 +++++++++
>  7 files changed, 9 insertions(+), 55 deletions(-)

For hwmon and watchdog:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter
