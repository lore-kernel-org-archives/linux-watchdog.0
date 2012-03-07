Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49706 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882Ab2CGLmF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 06:42:05 -0500
Received: by bkcik5 with SMTP id ik5so5098106bkc.19
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Mar 2012 03:42:04 -0800 (PST)
Message-ID: <4F574936.3010909@ru.mvista.com>
Date: Wed, 07 Mar 2012 15:40:38 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@st.com>
CC: wim@iguana.be, linus.walleij@stericsson.com,
	srinidhi.kasagar@stericsson.com, spear-devel@list.st.com,
	viresh.linux@gmail.com, alan@lxorguk.ukuu.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 12/15] watchdog/mpcore_wdt: Add support for WDIOF_CARDRESET
References: <cover.1331115751.git.viresh.kumar@st.com> <cb4bdf968a4d53eebf8005636fcef5fde8cbebf7.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cb4bdf968a4d53eebf8005636fcef5fde8cbebf7.1331115752.git.viresh.kumar@st.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello.

On 07-03-2012 14:27, Viresh Kumar wrote:

> mpcore watchdog can give last boot status, whether we got a watchdog reset or
> not, via bit 0 of TWD_WDOG_RESETSTAT register. This patch adds support to return
> correct status if WDIOC_GETBOOTSTATUS cmd is called with ioctl.

    In the subject you say about another ioclt.

> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> ---
>   arch/arm/include/asm/smp_twd.h |    2 ++
>   drivers/watchdog/mpcore_wdt.c  |   10 +++++++++-
>   2 files changed, 11 insertions(+), 1 deletions(-)

WBR, Sergei

