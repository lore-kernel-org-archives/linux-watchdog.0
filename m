Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:18444 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab2A0VXC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Jan 2012 16:23:02 -0500
Message-ID: <4F2315B0.2010507@freescale.com>
Date: Fri, 27 Jan 2012 15:22:56 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Dmitry Artamonow <mad_soft@inbox.ru>
CC: <linux-watchdog@vger.kernel.org>,
	Kumar Gala <galak@kernel.crashing.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: fix GETTIMEOUT ioctl in booke_wdt
References: <1327605870-9226-1-git-send-email-mad_soft@inbox.ru> <4F231234.5030007@freescale.com>
In-Reply-To: <4F231234.5030007@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Timur Tabi wrote:
> Dmitry Artamonow wrote:
>> +#ifdef	CONFIG_FSL_BOOKE
>> +		return put_user(period_to_sec(booke_wdt_period), p);
>> +#else
> 
> period_to_sec() returns an unsigned long long, which means that the driver
> will write 8 bytes instead of 4 to user space. 

Ok, I take that back.  put_user() uses the size of the pointer, which
makes more sense anyway.


-- 
Timur Tabi
Linux kernel developer at Freescale

