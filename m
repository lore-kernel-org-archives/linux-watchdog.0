Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37633 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419Ab2CGMKh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 07:10:37 -0500
Received: by wibhm2 with SMTP id hm2so3315728wib.19
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Mar 2012 04:10:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F574936.3010909@ru.mvista.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
	<cb4bdf968a4d53eebf8005636fcef5fde8cbebf7.1331115752.git.viresh.kumar@st.com>
	<4F574936.3010909@ru.mvista.com>
Date: Wed, 7 Mar 2012 04:10:36 -0800
Message-ID: <CAOh2x==p26zb-vHcX5vnPZYD_P8DWkvTwj=J+4pLytusoMZSOA@mail.gmail.com>
Subject: Re: [PATCH 12/15] watchdog/mpcore_wdt: Add support for WDIOF_CARDRESET
From: viresh kumar <viresh.linux@gmail.com>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Viresh Kumar <viresh.kumar@st.com>, wim@iguana.be,
	linus.walleij@stericsson.com, srinidhi.kasagar@stericsson.com,
	spear-devel@list.st.com, alan@lxorguk.ukuu.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 3/7/12, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> On 07-03-2012 14:27, Viresh Kumar wrote:
>
>> mpcore watchdog can give last boot status, whether we got a watchdog reset
>> or
>> not, via bit 0 of TWD_WDOG_RESETSTAT register. This patch adds support to
>> return
>> correct status if WDIOC_GETBOOTSTATUS cmd is called with ioctl.
>
>     In the subject you say about another ioclt.
>

Actually i mentioned what we add in watchdog_info (WDIOF_CARDRESET) in subject,
and mentioned IOCTL in body. Both are right, but yes they must be
consistent. Will
fix subject in V2.

--
viresh
