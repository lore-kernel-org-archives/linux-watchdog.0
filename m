Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56084 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbbERNRE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 May 2015 09:17:04 -0400
Message-ID: <5559E64F.8020508@roeck-us.net>
Date: Mon, 18 May 2015 06:17:03 -0700
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
>      Also it adds support for VT8235 and VT8237 series southbridges. Tested with
>      VT8235M, VT8237 and VT8237S boards.
>
>      Sending patch to stable too since it seems like an overflow error if big
>      timeout values are chosen and because those chipsets were very popular in
>      x86 boards supporting processors from all vendors (AMD, intel and VIA).
>
>      Signed-off-by: Ioannis Barkas <risc4all@yahoo.com>
>      Signed-off-by: Nikos Barkas <levelwol@gmail.com>

Another note: From: must contain "Nikos Barkas", not "Nick & John".

Guenter

