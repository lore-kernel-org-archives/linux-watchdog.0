Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35850 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbcCXQR5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 Mar 2016 12:17:57 -0400
Date: Thu, 24 Mar 2016 09:17:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, andy.gross@linaro.org,
	linux-arm-msm@vger.kernel.org,
	qca-upstream.external@qca.qualcomm.com,
	Wim Van Sebroeck <wim@iguana.be>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/17] watchdog: qcom: configure BARK time in addition to
 BITE time
Message-ID: <20160324161754.GA6515@roeck-us.net>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-9-git-send-email-mmcclint@codeaurora.org>
 <20160323224226.GD18567@codeaurora.org>
 <19DAEEE1-1019-49FB-A921-4311F592A7EC@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19DAEEE1-1019-49FB-A921-4311F592A7EC@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 24, 2016 at 10:46:42AM -0500, Matthew McClintock wrote:
> On Mar 23, 2016, at 5:42 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > 
> > On 03/23, Matthew McClintock wrote:
> >> For certain parts and some versions of TZ, TZ will reset the chip
> >> when a BARK is triggered even though it was not configured here. So
> >> by default let's configure this BARK time as well.
> >> 
> > 
> > Why isn't TZ configuring the bark time to what it wants? I'm lost
> > why we have to do this for them.
> 
> So it was done like this to ensure we had a valid upgrade. The bootloader is using the watchdog to ensure the system is bootable and if not it will revert back to the working images.
> 
> Bottom line is, for some versions of TZ out there, if we enable watchdog coming out of boot the bark time is already configured by the boot loader and TZ is configured to intercept this interrupt and do some register saving (for crashdump) and we end up getting a watchdog reset during boot.
> 
> It’s even a little more complex, because in order for the TZ to save the registers you need to pad the BITE time a bit higher than the BARK time, but I was leaving that for another day.
> 
Sounds like an op[timal target for using pretimeout ?

Guenter
