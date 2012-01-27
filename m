Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:32969
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752378Ab2A0VIQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Jan 2012 16:08:16 -0500
Message-ID: <4F231234.5030007@freescale.com>
Date: Fri, 27 Jan 2012 15:08:04 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Dmitry Artamonow <mad_soft@inbox.ru>
CC: <linux-watchdog@vger.kernel.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: fix GETTIMEOUT ioctl in booke_wdt
References: <1327605870-9226-1-git-send-email-mad_soft@inbox.ru>
In-Reply-To: <1327605870-9226-1-git-send-email-mad_soft@inbox.ru>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dmitry Artamonow wrote:
> +#ifdef	CONFIG_FSL_BOOKE
> +		return put_user(period_to_sec(booke_wdt_period), p);
> +#else

period_to_sec() returns an unsigned long long, which means that the driver
will write 8 bytes instead of 4 to user space.  You need to use a
temporary u32, just like WDIOC_SETTIMEOUT:

		if (get_user(tmp, p))
			return -EFAULT;


-- 
Timur Tabi
Linux kernel developer at Freescale

