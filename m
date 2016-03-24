Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52365 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcCXTti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Mar 2016 15:49:38 -0400
Subject: Re: [PATCH 08/17] watchdog: qcom: configure BARK time in addition to BITE time
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
From: Matthew McClintock <mmcclint@codeaurora.org>
In-Reply-To: <20160324161754.GA6515@roeck-us.net>
Date: Thu, 24 Mar 2016 14:49:33 -0500
Cc: Stephen Boyd <sboyd@codeaurora.org>, andy.gross@linaro.org,
	linux-arm-msm@vger.kernel.org,
	qca-upstream.external@qca.qualcomm.com,
	Wim Van Sebroeck <wim@iguana.be>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <7B88A165-5D16-4545-85ED-798CA38CF927@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org> <1458770712-10880-9-git-send-email-mmcclint@codeaurora.org> <20160323224226.GD18567@codeaurora.org> <19DAEEE1-1019-49FB-A921-4311F592A7EC@codeaurora.org> <20160324161754.GA6515@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mar 24, 2016, at 11:17 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
>>> Why isn't TZ configuring the bark time to what it wants? I'm lost
>>> why we have to do this for them.
>> 
>> So it was done like this to ensure we had a valid upgrade. The bootloader is using the watchdog to ensure the system is bootable and if not it will revert back to the working images.
>> 
>> Bottom line is, for some versions of TZ out there, if we enable watchdog coming out of boot the bark time is already configured by the boot loader and TZ is configured to intercept this interrupt and do some register saving (for crashdump) and we end up getting a watchdog reset during boot.
>> 
>> It’s even a little more complex, because in order for the TZ to save the registers you need to pad the BITE time a bit higher than the BARK time, but I was leaving that for another day.
>> 
> Sounds like an op[timal target for using pretimeout ?

So the bark is basically a pretimeout, sure I think that will work. We can configure it to be off by default.

Thanks for the heads up, I’ll take a look.

-M