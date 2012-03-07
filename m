Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47839 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab2CGLkV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 06:40:21 -0500
Received: by bkcik5 with SMTP id ik5so5096651bkc.19
        for <linux-watchdog@vger.kernel.org>; Wed, 07 Mar 2012 03:40:20 -0800 (PST)
Message-ID: <4F5748CC.9020601@ru.mvista.com>
Date: Wed, 07 Mar 2012 15:38:52 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Viresh Kumar <viresh.kumar@st.com>
CC: wim@iguana.be, linus.walleij@stericsson.com,
	srinidhi.kasagar@stericsson.com, spear-devel@list.st.com,
	viresh.linux@gmail.com, alan@lxorguk.ukuu.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 10/15] watchdog/mpcore_wdt: Add support for dev_pm_ops
 interface
References: <cover.1331115751.git.viresh.kumar@st.com> <b50542be97df8b90d3e7c696a8d13be707f581f9.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <b50542be97df8b90d3e7c696a8d13be707f581f9.1331115752.git.viresh.kumar@st.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello.

On 07-03-2012 14:27, Viresh Kumar wrote:

> This patch adds dev_pm_ops support for standby/slepp/hibernate.

> Signed-off-by: Viresh Kumar<viresh.kumar@st.com>
> ---
>   drivers/watchdog/mpcore_wdt.c |   18 +++++++++---------
>   1 files changed, 9 insertions(+), 9 deletions(-)

> diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
> index e02c02b..a099418 100644
> --- a/drivers/watchdog/mpcore_wdt.c
> +++ b/drivers/watchdog/mpcore_wdt.c
[...]
> @@ -384,40 +385,39 @@ static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
[...]
>   /* work with hotplug and coldplug */
>   MODULE_ALIAS("platform:mpcore_wdt");
>
>   static struct platform_driver mpcore_wdt_driver = {
>   	.probe		= mpcore_wdt_probe,
>   	.remove		= __devexit_p(mpcore_wdt_remove),
> -	.suspend	= mpcore_wdt_suspend,
> -	.resume		= mpcore_wdt_resume,
>   	.shutdown	= mpcore_wdt_shutdown,
>   	.driver		= {
>   		.owner	= THIS_MODULE,
>   		.name	= "mpcore_wdt",
> +		.pm = &mpcore_wdt_dev_pm_ops,

    Please align the right part of initializer like all above.

WBR, Sergei
