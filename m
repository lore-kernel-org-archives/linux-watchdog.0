Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:43288 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750733AbbJCQrj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 3 Oct 2015 12:47:39 -0400
Date: Sat, 3 Oct 2015 18:47:35 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Wim Van Sebroeck <wim@iguana.be>, rtc-linux@googlegroups.com,
	linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151003164735.GF2694@piout.net>
References: <1443817082-24370-1-git-send-email-harald@ccbib.org>
 <1443817082-24370-2-git-send-email-harald@ccbib.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1443817082-24370-2-git-send-email-harald@ccbib.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 02/10/2015 at 20:18:02 +0000, Harald Geyer wrote :
> +static void stmp3xxx_wdt_clear_bootstatus(struct device *dev)
> +{
> +	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
> +
> +	writel(STMP3XXX_RTC_PERSISTENT2_WDT_ACTIVE,
> +	       STMP3XXX_RTC_PERSISTENT2 + STMP_OFFSET_REG_CLR + rtc_data->io);

nitpick: I would put rtc_data->io first here for consistency.

Else, this seems fine to me, I can take that patch with the watchdog
maintainers ack.
-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
