Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63971 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757662Ab2CGML2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 07:11:28 -0500
Received: by wibhm2 with SMTP id hm2so3316249wib.19
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Mar 2012 04:11:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F5748CC.9020601@ru.mvista.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
	<b50542be97df8b90d3e7c696a8d13be707f581f9.1331115752.git.viresh.kumar@st.com>
	<4F5748CC.9020601@ru.mvista.com>
Date: Wed, 7 Mar 2012 04:11:27 -0800
Message-ID: <CAOh2x=mvuFyG3Gg-rdU23hz2TyHNM=u2JWn2uiONuKUEUY3GnQ@mail.gmail.com>
Subject: Re: [PATCH 10/15] watchdog/mpcore_wdt: Add support for dev_pm_ops interface
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

>>   static struct platform_driver mpcore_wdt_driver = {

>>   	.driver		= {
>>   		.owner	= THIS_MODULE,
>>   		.name	= "mpcore_wdt",
>> +		.pm = &mpcore_wdt_dev_pm_ops,
>
>     Please align the right part of initializer like all above.
>
> WBR, Sergei
>

Sure.

--
viresh
