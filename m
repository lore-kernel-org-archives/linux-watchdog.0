Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47818 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbcC1V4i (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Mar 2016 17:56:38 -0400
Date: Mon, 28 Mar 2016 14:56:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
	"qca-upstream.external" <qca-upstream.external@qca.qualcomm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/17] watchdog: qcom: add option for standalone watchdog
 not in timer block
Message-ID: <20160328215638.GA25221@roeck-us.net>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-8-git-send-email-mmcclint@codeaurora.org>
 <20160325162326.GA25767@roeck-us.net>
 <D54FA5B6-F170-40D3-BF0D-60D40A2C2829@codeaurora.org>
 <20160328181356.GA29820@roeck-us.net>
 <938942F3-D0ED-4BCA-9B6A-EF716A101E0C@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <938942F3-D0ED-4BCA-9B6A-EF716A101E0C@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 28, 2016 at 03:40:58PM -0500, Matthew McClintock wrote:
> On Mar 28, 2016, at 1:13 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> >>> bit 0 is the enable bit, and bit 1 enables interrupts. At address 0x08 (eg
> >>> LPASS_QDSP6SS_WDOG_UNMASKED_INT_EN), bit 0 enables interrupts and bit 1 is
> >>> undefined.
> >> 
> >> I honestly don’t see anything at 0x8 for either blocks that looks like this. For the new block bit 0 is enabling and bit 1 enabled interrupts.
> >> 
> > That is from the APQ8064 datasheet. 
> 
> So taken from the timer offset 0x0208A000 I just have a generic counter register CPU0_APCS_GPT0_CNT at 0x8
> 
> What doc are you looking at?
> 
"Qualcomm Snapdragon 600 Processor APQ8064 Hardware Register Description"

It is available for download from the Qualcomm web site.

See chapter 12.10.3, "Watchdog timer registers". The register block is at
0x28882000. Registers are almost the same, except for the offset and the
definition of the bits in the enable register.

LPASS is "Low Power Audio Subsystem". Maybe it has its own watchdog.

Guenter
