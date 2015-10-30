Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35260 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758017AbbJ3Rbl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 13:31:41 -0400
Received: by obctp1 with SMTP id tp1so49489411obc.2
        for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2015 10:31:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5633A21B.2040300@timesys.com>
References: <1433448960-9257-2-git-send-email-tharvey@gateworks.com>
	<1438097230-2653-1-git-send-email-tharvey@gateworks.com>
	<5633A21B.2040300@timesys.com>
Date: Fri, 30 Oct 2015 10:31:24 -0700
Message-ID: <CAJ+vNU0wKrTyY_2YYyYWPsW8kvHtj-8-U8TeQZfm_ne9v2mZ1w@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] imx6: Implement external watchdog reset
From: Tim Harvey <tharvey@gateworks.com>
To: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Stefan Roese <sr@denx.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Iain Paton <ipaton0@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Oct 30, 2015 at 10:00 AM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
>
>
> On 07/28/2015 11:27 AM, Tim Harvey wrote:
>>
>> The IMX6 watchdog supports assertion of a signal (WDOG_B) which
>> can be pinmux'd to an external pin. This is typically used for boards that
>> have PMIC's in control of the IMX6 power rails. In fact, failure to use
>> such an external reset on boards with external PMIC's can result in
>> various
>> hangs due to the IMX6 not being fully reset [1] as well as the board
>> failing
>> to reset because its PMIC has not been reset to provide adequate voltate
>> for
>> the CPU when comming out of reset at 800Mhz when it was at 400Mhz prior to
>> reset.
>>
>> This adds a new device-tree property 'ext-reset-output' to fsl-imx-wdt in
>> order to indicate the board has such a reset and to cause the watchdog to
>> be
>> configured to assert WDOG_B instead of an internal reset both on a
>> watchdog timeout and in system_restart.
>>
>
> Hi, was there a reason why this patch did not make it to the upstream
> kernel? We would like to use this feature on a Advantech/GE board and I can
> rebase the first patch onto the latest linux-next, resubmit if needed.
>
> Thanks, Akshay
>

Akshay,

I have no idea why it hasn't made it upstream yet. I realized a couple
of weeks ago that I never sent it to Wim who is listed as the
maintainer of watchdog device drivers or the linux-watchdog maillist
so I did so at that time and haven't heard anything yet.

The original patch was:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347168.html
The 2nd version was:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348761.html

It's likely that a rebase/resubmit (including the proper list) may
result in a better outcome.

Tim
