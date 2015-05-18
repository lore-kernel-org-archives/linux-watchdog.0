Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55952 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbERNPV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 May 2015 09:15:21 -0400
Message-ID: <5559E5E6.2000508@roeck-us.net>
Date: Mon, 18 May 2015 06:15:18 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Nick & John <levelwol@gmail.com>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: via_wdt: Partial fix for programming error
 and support additional southbridges
References: <CANxHX8_A+v0wBt8aQPTB1mae7mnMFmULE-DuoP8kAxL3DdaNeg@mail.gmail.com>
In-Reply-To: <CANxHX8_A+v0wBt8aQPTB1mae7mnMFmULE-DuoP8kAxL3DdaNeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/18/2015 03:50 AM, Nick & John wrote:
>      This patch fixes a programming error by limiting WDT_TIMEOUT_MAX to 255.
>      That is done to avoid invalid settings. Putting a value bigger than 255
>      results in non working watchdog and reset is not performed. We are trying
>      to fit a 10bit value to an 8bit area! To support 1023 seconds MMIO addr+5
>      bit1:0 must be used to store the last(higher) two bits of count number.
>      Strangely no error was logged at the system when using values bigger than
>      255, the driver just ignores the time count.
>

While I have no idea why, the watchdog in this driver is pinged using a soft timer,
and it is always pinged every 0.5 seconds. So reducing the maximum timeout is not
necessary; in fact the driver could support a higher timeout.

The real fix, if it is really necessary, would be to either store the upper bits
as suggested above, or to just program the chip to a timeout of 255 seconds
if the desired timeout is larger than 255.

>      Also it adds support for VT8235 and VT8237 series southbridges. Tested with
>      VT8235M, VT8237 and VT8237S boards.
>
This should be a separate patch; see Documentation/SubmittingPatches, chapter 3.

Thanks,
Guenter

