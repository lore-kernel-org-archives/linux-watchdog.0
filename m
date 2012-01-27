Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:13052
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752836Ab2A0VfE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Jan 2012 16:35:04 -0500
Message-ID: <4F231877.9050504@freescale.com>
Date: Fri, 27 Jan 2012 15:34:47 -0600
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
> Commit dcfb748422 ([WATCHDOG] fix book E watchdog to take
> WDIOC_SETTIMEOUT arg in seconds) fixed SETTIMEOUT ioctl
> to use seconds as a parameter instead of some hardware-specific
> "period", but missed to apply similar changes to GETTIMEOUT,
> so it still returns "period" value. Let's fix it!
> Also, while at it, make SETTIMEOUT ioctl return real timeout
> value as it should do according to the documentation.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> ---

Acked-by: Timur Tabi <timur@freescale.com>

I don't have an easy way to test the watchdog ioctls.

-- 
Timur Tabi
Linux kernel developer at Freescale

