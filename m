Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38796 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753326AbdEDMrq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 4 May 2017 08:47:46 -0400
Date: Thu, 4 May 2017 14:47:34 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: linux-kernel@vger.kernel.org, moritz.fischer@ettus.com,
        linux-watchdog@vger.kernel.org, linux@roeck-us.net, wim@iguana.be,
        a.zummo@towertech.it, rtc-linux@googlegroups.com,
        alex.williams@ni.com
Subject: Re: [PATCH 2/2] rtc: ds1374: wdt: Fix stop/start ioctl always
 returning -EINVAL
Message-ID: <20170504124734.by5glj3yiluu3aai@piout.net>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
 <1493071512-5718-3-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493071512-5718-3-git-send-email-mdf@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 24/04/2017 at 15:05:12 -0700, Moritz Fischer wrote:
> Fix commit 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
> 
> The WDIOC_SETOPTIONS case in the watchdog ioctl would alwayss falls
> through to the -EINVAL case. This is wrong since thew watchdog does
> actually get stopped or started correctly.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/rtc/rtc-ds1374.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
